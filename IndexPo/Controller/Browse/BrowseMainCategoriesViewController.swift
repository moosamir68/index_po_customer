//
//  BrowseMainCategoriesViewController.swift
//  IndexPo
//
//  Created by Moosa Mir on 3/12/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class BrowseMainCategoriesViewController: BrowseMasterCollectionViewController {

    var url:String?
    var items:[BrowseObject] = [BrowseObject]()
    
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
        Service.sharedInstanse.getItemForBrowseMainCategories(url: self.url) { (items, error) in
            
        }
    }

}
