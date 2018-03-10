//
//  SelectableInputImage.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/4/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit

protocol SelectableInputImageDelegate {
    func userDidTapOnSelectableInputImage()
}

class SelectableInputImage: UIView {
    @IBOutlet var boxView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var containerView: UIView!
    
    var delegate:SelectableInputImageDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    init(title:String = "", font:UIFont = UIFont.systemFont(ofSize: 14.0), image:UIImage = #imageLiteral(resourceName: "PlusBox")) {
        super.init(frame: .zero)
        self.initUI()
        
        self.imageView.image = image
        self.titleLabel.text = title
        self.titleLabel.font = font
    }
    
    //MARK:- initUI
    func initUI(){
        let bundle = Bundle(for: type(of: self))
        let view = bundle.loadNibNamed("SelectableInputImage", owner: self, options: nil)?.first as! UIView
        addSubview(view)
        
        view.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        self.containerView.setAutomaticDirection()
        self.titleLabel.setAutomaticAlignment()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SelectableInputImage.userDidTapOnSelectImage))
        self.boxView.addGestureRecognizer(tapGesture)
        self.boxView.isUserInteractionEnabled = true
    }
    
    @objc private func userDidTapOnSelectImage(){
        self.delegate?.userDidTapOnSelectableInputImage()
    }
}
