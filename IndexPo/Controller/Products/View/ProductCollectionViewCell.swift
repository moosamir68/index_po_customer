//
//  VVProductCollectionViewCell.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/11/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet var boxView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var badgeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.productNameLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.productPriceLabel.font = UIUtility.normalFontAutoWithPlusSize()
        
        self.productPriceLabel.textAlignment = .center
        self.productNameLabel.textAlignment = .center
        
        self.productPriceLabel.text = ""
        self.productNameLabel.text = ""
        self.imageView.image = #imageLiteral(resourceName: "loading")
        
        self.boxView.backgroundColor = .white
        self.imageView.backgroundColor = .white
        self.boxView.layer.borderWidth = 0.5
        self.boxView.layer.borderColor = UIUtility.sormaeiColor().withAlphaComponent(0.5).cgColor
        self.boxView.setAutomaticDirection()
        
    }

    //MARK:- fill data
    func fillData(product:Product){
        
        self.badgeImageView.image = #imageLiteral(resourceName: "attention").withRenderingMode(.alwaysTemplate)
        self.badgeImageView.tintColor = UIUtility.badgePriceColor()
        
        if(product.photoURLs != nil && product.photoURLs?.count != 0){
            let url = URL(string: (product.photoURLs?.first)!)
            self.imageView.kf.setImage(with: url)
        }else if(product.imageUrl != nil){
            let url = URL(string: (product.imageUrl)!)
            self.imageView.kf.setImage(with: url)
        }else{
            self.imageView.image = #imageLiteral(resourceName: "loading")
        }
    }
}
