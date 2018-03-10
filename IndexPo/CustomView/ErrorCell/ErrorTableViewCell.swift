//
//  ErrorTableViewCell.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/10/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit

class ErrorTableViewCell: UITableViewCell {
    @IBOutlet var boxView: UIView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.titleLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.separatorInset = UIEdgeInsets(top: 0, left: self.boxView.frame.width, bottom: 0, right: 0)
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- fill data
    func fillData(title:String? = ""){
        self.titleLabel.text = title
    }
}
