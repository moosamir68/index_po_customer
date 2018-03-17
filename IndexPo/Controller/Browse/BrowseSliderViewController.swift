//
//  BrowseSliderViewController.swift
//  IndexPo
//
//  Created by Moosa Mir on 3/12/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class BrowseSliderViewController: BrowseMasterViewController {
    var sliderObject = BrowseSlider()
    
    @IBOutlet var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- initui
    internal override func initUI(){
        let contentWidth = UIScreen.main.bounds.size.width * CGFloat(self.sliderObject.images.count)
        self.scrollView.contentSize = CGSize(width: contentWidth, height: 0)
        
        for image in self.sliderObject.images{
            let lastChild = self.childViewControllers.last
            let imageViewController = BrowseImageViewController()
            imageViewController.imageUrlString = image
            self.addChildViewController(imageViewController)
            self.scrollView.addSubview(imageViewController.view)
            imageViewController.didMove(toParentViewController: self)
            imageViewController.view.snp.makeConstraints { (make) in
                make.width.equalTo(self.scrollView.snp.width)
                if(lastChild != nil){
                    make.leading.equalTo((lastChild?.view.snp.trailing)!)
                }else{
                    make.leading.equalTo(self.scrollView.snp.leading)
                }
                make.top.equalTo(self.scrollView.snp.top)
                make.height.equalTo(self.scrollView.snp.height)
            }
        }
    }

}
