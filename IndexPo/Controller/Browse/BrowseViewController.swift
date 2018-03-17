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
        let contentSize = CGSize(width: CGFloat((self.toolBarItems?.count)!) * self.boxView.frame.size.width, height: 0.0)
        self.mainScrollView.contentSize = contentSize
        for itemToolBar in self.toolBarItems!{
            switch itemToolBar.type {
            case 1:
                let home = BrowseMainHomeViewController()
                self.addControllerToParentOnScrollView(controller: home)
                break
            case 2:
                let categories = BrowseMainCategoriesViewController()
                self.addControllerToParentOnScrollView(controller: categories)
                break
            case 3:
                let grid = BrowseMainGridViewController()
                self.addControllerToParentOnScrollView(controller: grid)
                break
            case 4:
                let collections = BrowseMainCollectionsViewController()
                self.addControllerToParentOnScrollView(controller: collections)
                break
            case 5:
                let gift = BrowseMainGiftViewController()
                self.addControllerToParentOnScrollView(controller: gift)
                break
                
            default:
                return;
            }
        }
    }
    
    //MARK:- add controller to parent
    private func addControllerToParentOnScrollView(controller:UIViewController){
        let currentChild:UIViewController? = self.childViewControllers.last
        self.addChildViewController(controller)
        self.mainScrollView.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
        
        controller.view.snp.makeConstraints { (make) in
            make.top.equalTo(self.mainScrollView.snp.top)
            if(currentChild != nil){
                make.leading.equalTo((currentChild?.view.snp.trailing)!)
            }else{
                make.leading.equalTo(self.mainScrollView.snp.leading)
            }
            
            make.width.equalTo(self.mainScrollView.frame.size.width)
            make.height.equalTo(self.mainScrollView.frame.size.height)
        }
        
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
