//
//  ImagePlayerViewController.swift
//  IndexPo
//
//  Created by Moosa Mir on 3/10/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

protocol ImagePlayerDelegate {
    func userDidTapOnImage(on product:Product)
}

import UIKit

class ImagePlayerViewController: UIViewController {

    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var delegate:ImagePlayerDelegate?
    var product:Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:- initUI
    private func initUI(){
        self.boxView.setAutomaticDirection()
        let tapGustureOnImage = UITapGestureRecognizer(target: self, action: #selector(ImagePlayerViewController.userDidTapOnImageView))
        self.imageView.addGestureRecognizer(tapGustureOnImage)
        self.imageView.isUserInteractionEnabled = true
    }
    
    //MARK:- fill data
    func fillData(product:Product){
        let url = URL(string: product.imageUrl!)
        self.imageView.kf.setImage(with: url)
    }

    //MARK:- user did tap
    @objc private func userDidTapOnImageView(){
        self.delegate?.userDidTapOnImage(on: self.product!)
    }
}
