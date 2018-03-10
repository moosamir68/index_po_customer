//
//  SelectableMenu.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/3/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit
import SnapKit

protocol SelectableMenuDelegate {
    func userDidTapOnSelectableMenu()
}

class SelectableMenu: UIView {
    @IBOutlet var boxView: UIView!
    @IBOutlet var indicatorImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var containerView: UIView!
    
    var delegate:SelectableMenuDelegate?
    
    var titleString:String = ""
    var titleFont:UIFont = UIFont.systemFont(ofSize: 14.0)
    
    init(title:String = "", font:UIFont = UIFont.systemFont(ofSize: 14.0)) {
        super.init(frame: .zero)
        self.initUI()
        
        self.titleFont = font
        self.titleString = title
        
        self.titleLabel.text = title
        self.titleLabel.font = self.titleFont
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:- initUI
    func initUI(){
        let bundle = Bundle(for: type(of: self))
        let view = bundle.loadNibNamed("SelectableMenu", owner: self, options: nil)?.first as! UIView
        addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.cornerRadius = 5.0
        self.containerView.layer.borderColor = UIUtility.sormaeiColor().cgColor
        self.containerView.layer.masksToBounds = true
        
        self.containerView.setAutomaticDirection()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SelectableMenu.userDidTapOnSelectableMenu))
        self.boxView.addGestureRecognizer(tapGesture)
        self.boxView.isUserInteractionEnabled = true
    }
    
    func fillData(title:String = ""){
        
    }
    
    //MARK:- user did tap
    @objc private func userDidTapOnSelectableMenu(){
        self.delegate?.userDidTapOnSelectableMenu()
    }
}
