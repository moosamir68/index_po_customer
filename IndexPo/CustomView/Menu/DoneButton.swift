//
//  DoneButton.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/4/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit

protocol DoneButtonDelegate {
    func userDidTapOnDoneButton()
}

class DoneButton: UIView {
    @IBOutlet var boxView: UIView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var doneButton: UIButton!
    
    var delegate:DoneButtonDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(title:String = "", font:UIFont = UIFont.systemFont(ofSize: 0.0)) {
        super.init(frame: .zero)
        self.initUI()
        
        self.doneButton.setTitle(title, for: .normal)
        self.doneButton.titleLabel?.font = font
    }
    
    //MARK: - initUI
    func initUI(){
        let bundle = Bundle(for: type(of: self))
        let view = bundle.loadNibNamed("DoneButton", owner: self, options: nil)?.first as! UIView
        addSubview(view)
        
        view.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        self.doneButton.layer.cornerRadius = 5.0
        self.doneButton.backgroundColor = UIUtility.sormaeiColor()
        self.doneButton.setTitleColor(.white, for: .normal)
    }
    @IBAction func userDidTapOnDoneButton(_ sender: UIButton) {
        self.delegate?.userDidTapOnDoneButton()
    }
}
