//
//  InputShowImage.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/4/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit

class InputShowImage: UIView {
    @IBOutlet var boxView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var containerView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(frame: .zero)
        self.initUI()
    }
    
    //MARK:- initUI
    func initUI(){
        let bundle = Bundle(for: type(of: self))
        let view = bundle.loadNibNamed("InputShowImage", owner: self, options: nil)?.first as! UIView
        addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
//        self.imageView.layer.cornerRadius = 5.0
//        self.imageView.layer.borderWidth = 1.0
//        self.imageView.layer.borderColor = UIColor.lightGray.cgColor
    }
}
