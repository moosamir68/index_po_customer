//
//  InputView.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/4/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit
import SnapKit

class InputView: UIView {
    @IBOutlet var boxView: UIView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var containerView: UIView!
    
    init(placeHolder:String = "", font:UIFont = UIFont.systemFont(ofSize: 14.0)) {
        super.init(frame: .zero)
        self.initUI()
        
        self.textField.placeholder = placeHolder
        self.textField.font = font
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:- initUI
    func initUI(){
        let bundle = Bundle(for: type(of: self))
        
        let view = bundle.loadNibNamed("InputView", owner: self, options: nil)?.first as! UIView
        addSubview(view)
        
        view.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        self.containerView.layer.cornerRadius = 5.0
        self.containerView.layer.borderWidth = 1.0
        self.containerView.layer.borderColor = UIUtility.sormaeiColor().cgColor
        self.containerView.layer.masksToBounds = true
    }
}
