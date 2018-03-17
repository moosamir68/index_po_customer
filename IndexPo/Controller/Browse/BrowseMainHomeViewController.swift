//
//  BrowseMainHomeViewController.swift
//  IndexPo
//
//  Created by Moosa Mir on 3/12/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class BrowseMainHomeViewController: BrowseMasterViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var itemToolBar:MainToolBar?
    var url:String?
    var items:[BrowseObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- get data
    internal override func getData(){
        Service.sharedInstanse.getItemForBrowseMainHome(url: self.url) { (items, error) in
            self.items = items
            DispatchQueue.main.async {
                self.initUI()
            }
        }
    }

    //MARK:- initUI
    internal override func initUI() {
        var contentHeight = 0.0
        let screenWidth = Double(UIScreen.main.bounds.size.width)
        for item in self.items!{
            var controller:MasterViewController?
            switch item.type{
            case BrowseObjectType.slider?:
                controller = BrowseSliderViewController()
                (controller as! BrowseSliderViewController).sliderObject = (item as! BrowseSlider)
                contentHeight = contentHeight + screenWidth * BrowseMainHomeViewController.getMultiplyHeightForType(typeItem: item.type!)
                break;
            case BrowseObjectType.pair?:
                controller = BrowsePairProductViewController()
                (controller as! BrowsePairProductViewController).pairItem = (item as! BrowsePair)
                contentHeight = contentHeight + screenWidth * BrowseMainHomeViewController.getMultiplyHeightForType(typeItem: item.type!)
                break;
            case BrowseObjectType.banner?:
                controller = BrowseBannerViewController()
                (controller as! BrowseBannerViewController).banner = (item as! BrowseBanner)
                contentHeight = contentHeight + screenWidth * BrowseMainHomeViewController.getMultiplyHeightForType(typeItem: item.type!)
                break;
            case BrowseObjectType.collection?:
                controller = BrowseCollectionViewController()
                (controller as! BrowseCollectionViewController).collectionObject = (item as! BrowseCollection)
                contentHeight = contentHeight + screenWidth * BrowseMainHomeViewController.getMultiplyHeightForType(typeItem: item.type!)
                break;
                
            default:
                break;
            }
            
            self.addControllerViewToSubViewScrollView(controller: controller!, typeItem: item.type!)
        }
        
        self.scrollView.contentSize = CGSize(width: Double(UIScreen.main.bounds.size.width), height: contentHeight)
    }
    
    //MARK:- add subview to scrollview
    private func addControllerViewToSubViewScrollView(controller:MasterViewController, typeItem:BrowseObjectType){
        let lastChild = self.childViewControllers.last
        
        self.addChildViewController(controller)
        self.scrollView.addSubview(controller.view)
        self.didMove(toParentViewController: self)
        controller.view.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            if(lastChild != nil){
                make.top.equalTo((lastChild?.view?.snp.bottom)!)
            }else{
                make.top.equalTo(0.0)
            }
            make.width.equalTo(self.scrollView.snp.width)
            make.height.equalTo(self.scrollView.snp.width).multipliedBy(BrowseMainHomeViewController.getMultiplyHeightForType(typeItem: typeItem))
        }
    }
    
    //MARK:- multiply for heiht a type item
    static func getMultiplyHeightForType(typeItem:BrowseObjectType) ->Double{
        switch typeItem{
        case BrowseObjectType.slider:
            return 0.75
        case BrowseObjectType.pair:
            return 0.75
        case BrowseObjectType.banner:
            return 0.75
        case BrowseObjectType.collection:
            return 0.75
        }
    }
}
