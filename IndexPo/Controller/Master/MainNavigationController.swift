//
//  MainNavigationController.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/3/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate, UIViewControllerTransitioningDelegate {
    
    var rootViewController:UIViewController?
    var transitionController:Transition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.semanticContentAttribute = .forceLeftToRight
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isUserInteractionEnabled = true
        self.view.isUserInteractionEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isUserInteractionEnabled = false
        self.view.isUserInteractionEnabled = false
    }
    
    init(rootController:UIViewController?, showNavigationBar:Bool = true) {
        super.init(rootViewController: rootController!)
        
        self.rootViewController = rootController
        self.transitionController = Transition(navigationController: self)
        self.delegate = self.transitionController
        
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.barTintColor = UIUtility.navigationBarColor()
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        self.navigationBar.isTranslucent = false
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        
        if(!showNavigationBar){
            self.navigationBar.isHidden = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil,
                   bundle: nibBundleOrNil)
    }
}
