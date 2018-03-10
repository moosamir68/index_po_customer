//
//  MasterViewController.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/3/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit
import Kingfisher

class MasterViewController: UIViewController {
    
    @IBOutlet weak var boxView: UIView!
    
    var navigationTitle:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
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
        self.getData()
    }
    
    func initUI(){
    }
    
    func getData(){
    }
}
