//
//  BrowseCollectionViewController.swift
//  IndexPo
//
//  Created by Moosa Mir on 3/12/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class BrowseCollectionViewController: BrowseMasterCollectionViewController {
    var collectionObject = BrowseCollection()
    
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
        
    }
}
