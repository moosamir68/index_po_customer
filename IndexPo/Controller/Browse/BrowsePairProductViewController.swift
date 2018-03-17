//
//  BrowsePairProductViewController.swift
//  IndexPo
//
//  Created by Moosa Mir on 3/12/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit
import KTCenterFlowLayout

class BrowsePairProductViewController: BrowseMasterViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageViewFirst: UIImageView!
    @IBOutlet var imageViewSecound: UIImageView!
    
    var pairItem:BrowsePair?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initUI()
        self.fillData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- initUI
    override func initUI() {
        let tapGestureOnFirstImageView = UITapGestureRecognizer(target: self, action: #selector(BrowsePairProductViewController.userDidTapOnFirstImageView))
        self.imageViewFirst.addGestureRecognizer(tapGestureOnFirstImageView)
        let tapGestureOnSecoundImageView = UITapGestureRecognizer(target: self, action: #selector(BrowsePairProductViewController.userDidTapOnFirstImageView))
        self.imageViewSecound.addGestureRecognizer(tapGestureOnSecoundImageView)
        
        self.imageViewFirst.isUserInteractionEnabled = true
        self.imageViewSecound.isUserInteractionEnabled = true
    }
    
    //MARK:- fill data
    func fillData(){
        let urlFirstImage = URL(string: ((self.pairItem?.showingItems.first)?.image)!)
        let urlSecoundImage = URL(string: ((self.pairItem?.showingItems.last)?.image)!)
        self.imageViewFirst.kf.setImage(with: urlFirstImage)
        self.imageViewSecound.kf.setImage(with: urlSecoundImage)
        self.titleLabel.text = self.pairItem?.title
    }
    
    //Intenarl method
    @objc private func userDidTapOnFirstImageView(){
        
    }
    
    @objc private func userDidTapOnSecoundImageView(){
        
    }
}
