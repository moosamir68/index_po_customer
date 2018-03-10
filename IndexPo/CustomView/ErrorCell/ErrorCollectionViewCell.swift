//
//  ErrorCollectionViewCell.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/11/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit

class ErrorCollectionViewCell: UICollectionViewCell {
    @IBOutlet var boxView: UIView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.titleLabel.font = UIUtility.normalFontAutoWithPlusSize()
    }
    
    //MARK:- fillData
    func fillData(titleString:String? = ""){
        self.titleLabel.text = titleString
    }

}
