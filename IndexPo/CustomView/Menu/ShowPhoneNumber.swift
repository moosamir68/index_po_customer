//
//  ShowPhoneNumber.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/5/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit

class ShowPhoneNumber: UIView {
    @IBOutlet var boxView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(title:String = "", value:String = "", fontTitle:UIFont = UIFont.systemFont(ofSize: 0.0), fontValue:UIFont = UIFont.systemFont(ofSize: 0.0)) {
        super.init(frame: .zero)
        self.initUI()
        
        self.titleLabel.font = fontTitle
        self.valueLabel.font = fontValue
        self.titleLabel.text = title
        self.valueLabel.text = value
    }
    
    //MARK: - initUI
    func initUI(){
        let bundle = Bundle(for: type(of: self))
        let view = bundle.loadNibNamed("ShowPhoneNumber", owner: self, options: nil)?.first as! UIView
        addSubview(view)
        
        view.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        self.titleLabel.textColor = .lightGray
        self.valueLabel.textColor = .black
    }

}
