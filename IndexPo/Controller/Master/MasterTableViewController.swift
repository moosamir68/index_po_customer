//
//  MasterTableViewController.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/3/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

let identifireErrorTableViewCell = "ErrorTableViewCell"

protocol MasterTableViewDelegate {
    
}

import UIKit
import Kingfisher
import DGElasticPullToRefresh

class MasterTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var navigationTitle:String?
    var errorDescription = "Fetching Data...".localized()
    var items: [Int:[BaseObject]] = [:]
    var heightForPerCellOnSections:[Int:Any]?
    
    var masterTableViewDelegate:MasterTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageCache.default.maxDiskCacheSize = 40 * 1024 * 1024
        ImageCache.default.maxMemoryCost = 40 * 1024 * 1024
        ImageCache.default.maxCachePeriodInSecond = 60 * 60 * 24 * 3
        
        self.edgesForExtendedLayout = []
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logoNavigation"))
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIUtility.navigationBarColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.view.semanticContentAttribute = .forceLeftToRight
        
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "indicator")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "indicator")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.view.backgroundColor = UIUtility.colorRootView()
        
        self.initUI()
    }

    //MARK:- initUI
    func initUI(){
        self.tableView.separatorColor = .clear
        self.tableView.register(UINib(nibName: identifireErrorTableViewCell, bundle: nil), forCellReuseIdentifier: identifireErrorTableViewCell)
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIUtility.sormaeiColor()
        self.tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            // Add your logic here
            // Do not forget to call dg_stopLoading() at the end
            self?.refresh()
            self?.tableView.dg_stopLoading()
            }, loadingView: loadingView)
        self.tableView.dg_setPullToRefreshFillColor(UIUtility.navigationBarColor())
        self.tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    //MARK:- getData
    func getData(){
        
    }
    
    //MARK:- refreshData
    func refresh(){
        self.getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- taleview delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        if(self.checkIsEmptyDataSource()){
            return 1
        }
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.checkIsEmptyDataSource()){
            return 1
        }
        
        return self.items[section]!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(self.checkIsEmptyDataSource()){
            return self.view.frame.size.height
        }
        
        if let _ = self.heightForPerCellOnSections![indexPath.section]{
            if let dictionaryForSpecialSection:[Int:CGFloat] = self.heightForPerCellOnSections![indexPath.section] as? [Int:CGFloat]{
                if let _ = dictionaryForSpecialSection[indexPath.row]{
                    return dictionaryForSpecialSection[indexPath.row]!
                }
            }
            
            return self.heightForPerCellOnSections![indexPath.section]! as! CGFloat
        }
        
        let item = self.items[indexPath.section]![indexPath.row]
        return item.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.checkIsEmptyDataSource()){
            
        }else{
            let item = self.items[indexPath.section]![indexPath.row]
            self.userDidTapOnItem(select: item)
        }
    }
    
    //MARK:- internal method
    func userDidTapOnItem(select item:BaseObject){
        
    }
    
    //MARK:- check is empty data source
    func checkIsEmptyDataSource() -> Bool{
        if(self.items.count == 0){
            return true
        }
        return false
    }
    
}
