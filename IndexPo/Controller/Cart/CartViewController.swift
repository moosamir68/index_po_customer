//
//  CartViewController.swift
//  iOSShopBase
//
//  Created by Moosa Mir on 2/6/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

let identifireCartTableViewCell = "CartTableViewCell"

protocol CartDelegate {
    func showProductFromCartController(from:CartViewController, item:Product)
}

import UIKit

class CartViewController: MasterTableViewController {

    var cartItems: [Int:[CartItem]]{
        get {
            return self.items as! [Int:[CartItem]]
        }
        set {
            self.items = newValue
        }
    }
    
    var delegate:CartDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Mark:- initUI
    internal override func initUI(){
        self.tableView.register(UINib(nibName: identifireCartTableViewCell, bundle: nil), forCellReuseIdentifier: identifireCartTableViewCell)
        self.heightForPerCellOnSections = [0:(64.0 as CGFloat)]
        super.initUI()
    }
    
    //Mark:- get data
    internal override func getData() {
        Service.sharedInstanse.getCartItems { (cartItems, error) in
            if(cartItems != nil){
                let cartItemLocal:[Int:[CartItem]] = [0:cartItems!]
                self.cartItems = cartItemLocal
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
        
        let cartCell = self.tableView.dequeueReusableCell(withIdentifier: identifireCartTableViewCell, for: indexPath) as! CartTableViewCell
        let item = self.cartItems[indexPath.section]![indexPath.row]
        cartCell.fillData(cartItem: item)
        return cartCell
    }
    
    //MARK:- parent method override
    override func userDidTapOnItem(select item: BaseObject) {
        self.delegate?.showProductFromCartController(from: self, item: (item as! CartItem).product)
    }
    
    //Mark:- internal method
    
}
