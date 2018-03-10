//
//  CartTableViewCell.swift
//  iOSShopBase
//
//  Created by Moosa Mir on 2/6/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var body: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(cartItem:CartItem){
        self.count.text = String(format: "Count = %d", cartItem.count)
        self.message.text = cartItem.message
        self.body.text = cartItem.body
    }
}
