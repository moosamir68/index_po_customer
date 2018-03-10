//
//  ProductsViewController.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/11/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

let identifireProductCollectionCell = "ProductCollectionViewCell"
let identifireErrorCollectionCell = "ErrorCollectionViewCell"

import UIKit
import KTCenterFlowLayout

protocol ProductsDelegate {
    func showProduct(fromController:ProductsViewController?, withProduct product:Product?)
}

class ProductsViewController: MasterCollectionViewController {

    @IBOutlet var titleBoxView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleBoxViewConstraintHeight: NSLayoutConstraint!
    
    @IBOutlet var expirePriceProductsButton:UIButton?
    
    var delegate:ProductsDelegate?
    var products = [Product]()
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

    //MARK:- initUI
    internal override func initUI(){
        
        self.edgesForExtendedLayout = []
        
        self.titleLabel.font = UIUtility.boldFontAutoWithPlusSize(increaseSize: 1.0)
        self.titleLabel.text = "Select Product for Special Offer".localized()
        
        self.collectionView.register(UINib(nibName: identifireErrorCollectionCell, bundle: nil), forCellWithReuseIdentifier: identifireErrorCollectionCell)
        
        self.collectionView.register(UINib(nibName: identifireProductCollectionCell, bundle: nil), forCellWithReuseIdentifier: identifireProductCollectionCell)
        let flowLayout = KTCenterFlowLayout()
        let cellWidth = (self.boxView.frame.size.width / 2) - 12
        let cellHeight = cellWidth + 8 + 21 + 8 + 21 + 8
        flowLayout.itemSize = CGSize(width: cellWidth ,
                                     height: cellHeight)
        flowLayout.minimumInteritemSpacing = 8.0
        flowLayout.minimumLineSpacing = 8.0
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView.collectionViewLayout = flowLayout
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.allowsMultipleSelection = false
        self.collectionView.allowsSelection = true
        self.collectionView.alwaysBounceVertical = true
        
        self.expirePriceProductsButton?.backgroundColor = UIUtility.sormaeiColor()
        self.expirePriceProductsButton?.layer.cornerRadius = 4.0
        self.expirePriceProductsButton?.layer.masksToBounds = true
        self.expirePriceProductsButton?.setTitleColor(.white, for: .normal)
        self.expirePriceProductsButton?.titleLabel?.font = UIUtility.boldFontAutoWithPlusSize()
        
    }
    
    //MARK:- get data
    internal override func getData(){
        self.errorDescription = "Fetching Data...".localized()
        Service.sharedInstanse.browseProducts(searchObject: self.searchObject) { (products, error) in
            if(error == nil){
                self.products = products!
                if(products == nil || products?.count == 0){
                    self.errorDescription = "Empty Product".localized()
                }
            }else{
                self.errorDescription = (error?.errorDescription!)!
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK:- collectionview delegate
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(self.checkEmptyDataSource()){
            let cell:ErrorCollectionViewCell? = self.collectionView.dequeueReusableCell(withReuseIdentifier: identifireErrorCollectionCell, for: indexPath) as? ErrorCollectionViewCell
            
            cell?.fillData(titleString: self.errorDescription)
            
            return cell!
        }
        
        let cell:ProductCollectionViewCell? = self.collectionView.dequeueReusableCell(withReuseIdentifier: identifireProductCollectionCell, for: indexPath) as? ProductCollectionViewCell
        
        let product = self.products[indexPath.row]
        cell?.fillData(product: product)
        
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(!self.checkEmptyDataSource()){
            let product = self.products[indexPath.row]
            self.delegate?.showProduct(fromController: self, withProduct: product)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(self.checkEmptyDataSource()){
            return CGSize(width: self.boxView.frame.size.width, height: self.boxView.frame.height - 64)
        }
        
        let cellWidth = (self.boxView.frame.size.width / 2) - 12
        let cellHeight = cellWidth + 8 + 21 + 8 + 21 + 8
        return CGSize(width: cellWidth, height: cellHeight)
        
    }
    
    //MARK:- check empty data source
    private func checkEmptyDataSource() ->Bool{
        if(self.products.count == 0){
            return true
        }
        return false
    }
}
