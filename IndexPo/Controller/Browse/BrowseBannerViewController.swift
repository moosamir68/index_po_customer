//
//  BrowseBannerViewController.swift
//  IndexPo
//
//  Created by Moosa Mir on 3/12/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class BrowseBannerViewController: BrowseMasterViewController {
    var banner = BrowseBanner()
    
    @IBOutlet var BannerImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- initUI
    internal override func initUI() {
        let url = URL(string: self.banner.image)
        self.BannerImageView.kf.setImage(with: url)
    }

}
