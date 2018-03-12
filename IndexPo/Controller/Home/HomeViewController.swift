//
//  HomeViewController.swift
//  iOSShopBase
//
//  Created by Moosa Mir on 2/6/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

protocol HomeDelegate {
//    func userDidTapOnProductFromBrowse(from:HomeViewController, itemSelected item:Product)
}

import UIKit

class HomeViewController: MasterTableViewController, ProductTableViewCellDelegate {
    
    var products:[Int:[Product]]{
        get {
            return self.items as! [Int:[Product]]
        }
        set {
            self.items = newValue
        }
    }
    
    var delegate:CartDelegate?
    var searchObject = SearchParameters()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initUI()
        self.getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark:- initUI
    internal override func initUI(){
        self.tableView.register(UINib(nibName: identifireProductTableViewCellVideo, bundle: nil), forCellReuseIdentifier: identifireProductTableViewCellVideo)
        self.tableView.register(UINib(nibName: identifireProductTableViewCellImage, bundle: nil), forCellReuseIdentifier: identifireProductTableViewCellImage)
        let height = UIScreen.main.bounds.size.width + 16 + 21 + 8 + 21 + 12 + 12 + 32 + 14
        self.heightForPerCellOnSections = [0:(height as CGFloat)]
        super.initUI()
    }
    
    //Mark:- get data
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
    
    //Mark:- taleview delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(self.checkIsEmptyDataSource()){
            let errorCell = self.tableView.dequeueReusableCell(withIdentifier: identifireErrorTableViewCell, for: indexPath) as! ErrorTableViewCell
            errorCell.fillData(title: self.errorDescription)
            return errorCell
        }
        
        let productCell = self.tableView.dequeueReusableCell(withIdentifier: identifireProductTableViewCellImage, for: indexPath) as! ProductTableViewCellImage
        let product = self.products[indexPath.section]![indexPath.row]
        productCell.delegate = self
        productCell.fillData(product: product)
        return productCell
    }
    
    //Mark:- internal method
    
    //MARK:- table view cell delegate
    func userDidTapOnMore(on product: Product) {
        
    }
    
    func userDidTapOnFancy(on product: Product) {
        
    }
    
    func userDidTapOnBuyButton(on product: Product) {
        
    }
    
    func userDidTapOnImage(on product: Product) {
        
    }
}

