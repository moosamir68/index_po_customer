//
//  BrowsePairCollectionViewCell.swift
//  IndexPo
//
//  Created by Moosa Mir on 3/14/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class BrowseShowingCollectionViewCell: UICollectionViewCell {

    var pairItem:BrowseShowingItem?
    
    @IBOutlet var showingItemImegeView: UIImageView!
    @IBOutlet var showingItemName: UILabel!
    @IBOutlet var showingItemPrice: UILabel!
    @IBOutlet var showingItemDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillData(showingItem:BrowseShowingItem){
        self.showingItemName.text = showingItem.name
        self.showingItemPrice.text = "\(showingItem.price)"
        self.showingItemDescription.text = showingItem.shortDetails
        let url = URL(string: showingItem.image)
        self.showingItemImegeView.kf.setImage(with: url)
    }
}
