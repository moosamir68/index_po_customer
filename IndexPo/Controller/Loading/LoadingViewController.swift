//
//  LoadingViewController.swift
//  Moosamir
//
//  Created by Moosa Mir on 12/3/17.
//  Copyright © 2017 Noxel. All rights reserved.
//
import UIKit
import Toaster
import Localize_Swift
import FirebaseMessaging
import UserNotifications
import NotificationCenter
import UserNotificationsUI
import SwiftyGif

protocol LoadingDelegate {
    func showPhoneNumberController(fromController:LoadingViewController?)
    func showGetUserInformationControllerFromLoading(fromController:LoadingViewController?)
    func showHomeControllerFromLoading(fromController:LoadingViewController?)
}

class LoadingViewController: UIViewController {
    
    @IBOutlet var logo: UIImageView!
    
    var countRequest = 0
    var delegate:LoadingDelegate?
    var countRequestGetCategory = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setUp details
        initUI()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3,
                       animations: {
                        
        }) { (finished) in
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.logo.startAnimatingGif()
        let deadlineTime = DispatchTime.now() + .seconds(5)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.delegate?.showHomeControllerFromLoading(fromController: self)
//            self.getData()

            let defaultUser = UserDefault()
            if(!defaultUser.isSetLanguage()){
                Localize.setCurrentLanguage("fa")
                UserDefaults.standard.set(["fa"], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
//
                defaultUser.setLanguage()
            }
            
            //Toaster Appearance
            ToastView.appearance().font = UIUtility.normalFontAutoWithPlusSize()
            ToastView.appearance().cornerRadius = 5.0
            ToastView.appearance().textInsets = UIEdgeInsets(top: 10.0,
                                                             left: 10.0,
                                                             bottom: 10.0,
                                                             right: 10.0)
            
//            //UITabBarItem
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIUtility.normalFontAutoWithPlusSize(increaseSize: -5.0)],
                                                             for: .normal)

            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIUtility.normalFontAutoWithPlusSize(increaseSize: -4.0)],
                                                             for: .selected)

            UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.font: UIUtility.boldFontAutoWithPlusSize(increaseSize: 3.0)]

            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font:UIUtility.boldFontAutoWithPlusSize(increaseSize: -1)], for: .normal)
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font:UIUtility.boldFontAutoWithPlusSize(increaseSize: -1)], for: .disabled)
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font:UIUtility.boldFontAutoWithPlusSize(increaseSize: -1)], for: UIControlState.highlighted)
            
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.logo.stopAnimatingGif()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- initUI
    func initUI(){
        self.logo.image = nil
        let gifmanager = SwiftyGifManager(memoryLimit:20)
        self.logo.setGifImage(UIImage(gifName: "splash_animation.gif"), manager: gifmanager)
    }
    
    
    private func getData(){
        let defaultUser = UserDefault()
        let user = defaultUser.getUser()
        
        if(user != nil){
            self.countRequest = self.countRequest + 1
            let localCountRequest = self.countRequest
            Service.sharedInstanse.getUserInfo(withReloadDataFromServer: true, callback: { (account, error) in
                if(self.countRequest == localCountRequest){
                    if(error == nil && account != nil){
                        self.countRequest = self.countRequest + 1
                        if(account?.sentInfo)!{
                            self.getCategoriesAndShowHomeController()
                            Messaging.messaging().shouldEstablishDirectChannel = true
                            Service.sharedInstanse.sendNotificationTokenToServer()
                        }else{
                            Messaging.messaging().shouldEstablishDirectChannel = false
                            DispatchQueue.main.async {
                                self.delegate?.showGetUserInformationControllerFromLoading(fromController: self)
                            }
                        }
                    }else{
                        Messaging.messaging().shouldEstablishDirectChannel = false
                        print("Get User Info Error")
                        self.getData()
                    }
                }
            })
        }else{
            self.delegate?.showPhoneNumberController(fromController: self)
        }
    }
    
    //MARK:- get category and show controller
    private func getCategoriesAndShowHomeController (){
        Service.sharedInstanse.getColors(reloadData: true) { (colors, error) in
            
        }
        
        self.delegate?.showHomeControllerFromLoading(fromController: self)
    }
}

