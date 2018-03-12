//
//  BrowseViewController.swift
//  iOSShopBase
//
//  Created by Moosa Mir on 2/6/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

let identifireProductTableViewCellImage = "ProductTableViewCellImage"
let identifireProductTableViewCellVideo = "ProductTableViewCellVideo"
let identifireProductCollectionViewCell = "ProductCollectionViewCell"

protocol BrowseDelegate {
    func showProductFromBrowse(from:BrowseViewController, itemSelected item:Product)
}

import UIKit

class BrowseViewController: MasterViewController {

    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var delegate:BrowseDelegate?
    var searchObject = SearchParameters()
    var toolBarItems:[MainToolBar]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- initUI
    internal override func initUI(){
        super.initUI()
        self.mainScrollView.isPagingEnabled = true
    }
    
    //MARK:- get data
    internal override func getData() {
        Service.sharedInstanse.getToolBarMenuBrowse { (toolBarItems, error) in
            DispatchQueue.main.async {
                self.toolBarItems = toolBarItems
                if(!self.checkIsEmptyData()){
                    self.initToolbarWithItems()
                }
            }
        }
    }
    
    //MARK:- internal method
    private func initToolbarWithItems(){
        self.mainScrollView.contentSize = CGSize(width: CGFloat((self.toolBarItems?.count)!) * self.boxView.frame.size.width, height: self.boxView.frame.size.height)
        
        for itemToolBar in self.toolBarItems!{
            switch itemToolBar.type {
            case 1:
                let home = BrowseMainHomeViewController()
                self.addChildViewController(home)
                break
            case 2:
                let categories = BrowseMainCategoriesViewController()
                self.addChildViewController(categories)
                break
            case 3:
                let grid = BrowseMainGridViewController()
                self.addChildViewController(grid)
                break
            case 4:
                let collections = BrowseMainCollectionsViewController()
                self.addChildViewController(collections)
                break
            case 5:
                let gift = BrowseMainGiftViewController()
                self.addChildViewController(gift)
                break
                
            default:
                return;
            }
        }
    }
    
    //MARK:- add controller to parent
    private func addControllerToParentOnScrollView(controller:MasterViewController){
        let currentChild:UIViewController? = self.childViewControllers.last
        self.addChildViewController(controller)
        self.mainScrollView.addSubview(controller.view)
        controller.view.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            if(currentChild != nil){
                make.left.equalTo((currentChild?.view.snp.trailing)!)
            }else{
                make.left.equalToSuperview()
            }
        }
        
        controller.willMove(toParentViewController: self)
    }
    
    private func addItemToToolBarMenu(toolBarItem:MainToolBar){
        
    }
    
    private func checkIsEmptyData() -> Bool{
        if(self.toolBarItems == nil || self.toolBarItems?.count == 0){
            return true
        }
        
        return false
    }
}
