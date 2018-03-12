//
//  MediaViewController.swift
//  IndexPo
//
//  Created by Moosa Mir on 3/10/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class VideoPlayerViewController: UIViewController {

    @IBOutlet var boxView: UIView!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var soundButton: UIButton!
    
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
        self.playButton.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.playButton.layer.cornerRadius = 32.0
        self.playButton.layer.masksToBounds = true
        
        self.soundButton.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.soundButton.layer.cornerRadius = 16.0
        self.soundButton.layer.masksToBounds = true
    }

    //MARK:- fill data
    func fillData(product:Product){
        
    }
}
