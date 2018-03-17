//
//  BrowseImageViewController.swift
//  IndexPo
//
//  Created by Moosa Mir on 3/14/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class BrowseImageViewController:  BrowseMasterViewController{

    @IBOutlet var imageView: UIImageView!
    var imageUrlString:String?
    
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
        let url = URL(string: self.imageUrlString!)
        self.imageView.kf.setImage(with: url)
    }

}
