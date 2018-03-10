//
//  BrowseViewController.swift
//  iOSShopBase
//
//  Created by Moosa Mir on 2/6/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

let identifireProductTableViewCell = "ProductTableViewCell"
let identifireProductCollectionViewCell = "ProductCollectionViewCell"

protocol BrowseDelegate {
    func showProductFromBrowse(from:BrowseViewController, itemSelected item:Product)
}

import UIKit

class BrowseViewController: MasterTableViewController {

    var products: [Int:[Product]]{
        get {
            return self.items as! [Int:[Product]]
        }
        set {
            self.items = newValue
        }
    }
    
    var delegate:BrowseDelegate?
    var searchObject = SearchParameters()
    
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
        self.tableView.register(UINib(nibName: identifireProductTableViewCell, bundle: nil), forCellReuseIdentifier: identifireProductTableViewCell)
        self.heightForPerCellOnSections = [0:(87.0 as CGFloat)]
        super.initUI()
    }
    
    //MARK:- get data
    internal override func getData() {
        Service.sharedInstanse.browseProducts(searchObject: self.searchObject) { (products, error) in
            if(products != nil){
                let productsLocal:[Int:[Product]] = [0:products!]
                self.products = productsLocal
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    //MARK:- taleview delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(self.checkIsEmptyDataSource()){
            let errorCell = self.tableView.dequeueReusableCell(withIdentifier: identifireErrorTableViewCell, for: indexPath) as! ErrorTableViewCell
            errorCell.fillData(title: self.errorDescription)
            return errorCell
        }
        
        let cartCell = self.tableView.dequeueReusableCell(withIdentifier: identifireProductTableViewCell, for: indexPath) as! ProductTableViewCell
        let product = self.products[indexPath.section]![indexPath.row]
        cartCell.fillData(product: product)
        return cartCell
    }
    
    //MARK:- parent method
    override func userDidTapOnItem(select item: BaseObject) {
        self.delegate?.showProductFromBrowse(from: self, itemSelected: item as! Product)
        
    }
    
    //MARK:- internal method
    
    
}
