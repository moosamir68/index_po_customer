//
//  ProductTableViewCell.swift
//  iOSShopBase
//
//  Created by Moosa Mir on 2/7/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var NameEnglishLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- fill data
    func fillData(product:Product){
        self.priceLabel.text = String(format:" price %d", product.price)
        self.nameLabel.text = product.name
        self.NameEnglishLabel.text = product.nameEn
    }
}
