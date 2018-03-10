//
//  ProfileViewController.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/3/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit
import KRProgressHUD
import Localize_Swift
import MMAlert

protocol ProfileDelegate {
    func successFullySignOut()
    func showDialogLogout(fromController:ProfileViewController?, title:String?, content:String?)
    func dismissDialogLogout(controller:MMAlertAlertViewController?, complition:@escaping () ->Void)
    func showDialogLanguage(fromController:ProfileViewController?, elements:[MMAlert])
    func dismissDialogLanguage(fromController:MMAlertSheetViewController?, complition:@escaping () ->Void)
    
    func succssfulyChangeLanguage()

    func successFullyChnageSubCategories()
}

class ProfileViewController: MasterViewController, AlertAlertDelegate, AlertSheetDelegate {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var userNameBoxView: UIView!
    @IBOutlet var userPhoneBoxView: UIView!
    @IBOutlet var userTelegramBoxView: UIView!
    
    @IBOutlet var lineUnderUserInfoBoxView: UIView!
    
    @IBOutlet var shopNameBoxView: UIView!
    @IBOutlet var shopPhoneBoxView: UIView!
    @IBOutlet var shopAddressBoxView: UIView!
    
    @IBOutlet var lineUnderShopInfoBoxView: UIView!
    
    @IBOutlet var changeSubCategoryBoxView: UIView!
    @IBOutlet var changeLanguageBoxView: UIView!
    @IBOutlet var exitBoxView: UIView!
    
    @IBOutlet var userNameImageView: UIImageView!
    @IBOutlet var userPhoneImageView: UIImageView!
    @IBOutlet var userTelegramImageView: UIImageView!
    
    @IBOutlet var shopNameImageView: UIImageView!
    @IBOutlet var shopPhoneImageView: UIImageView!
    @IBOutlet var shopAddressImageView: UIImageView!
    
    @IBOutlet var changeSubCategoryImageView: UIImageView!
    @IBOutlet var changeLanguageImageView: UIImageView!
    @IBOutlet var exitImageView: UIImageView!
    
    @IBOutlet var userNameValueLabel: UILabel!
    @IBOutlet var userPhoneValueLabel: UILabel!
    @IBOutlet var userTelegramValueLabel: UILabel!
    
    @IBOutlet var shopNameValueLabel: UILabel!
    @IBOutlet var shopPhoneValueLabel: UILabel!
    @IBOutlet var shopAddressValueLabel: UILabel!
    
    @IBOutlet var changeSubCategoryValueLabel: UILabel!
    @IBOutlet var changeLanguageValueLabel: UILabel!
    @IBOutlet var exitValueLabel: UILabel!
    
    var delegate:ProfileDelegate?
    var account:Account? = UserDefault().getUser()
    var elements:[MMAlert]? = [MMAlert]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.account = UserDefault().getUser()
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- initUI
    internal override func initUI(){
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Gift"), style: .plain, target: nil, action: nil)
        
        self.userNameValueLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.userPhoneValueLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.userTelegramValueLabel.font = UIUtility.normalFontAutoWithPlusSize()
        
        self.shopNameValueLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.shopPhoneValueLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.shopAddressValueLabel.font = UIUtility.normalFontAutoWithPlusSize()
        
        self.changeSubCategoryValueLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.changeLanguageValueLabel.font = UIUtility.normalFontWithPlusSize()
        self.exitValueLabel.font = UIUtility.normalFontAutoWithPlusSize()
        
        self.userNameBoxView.setAutomaticDirection()
        self.userPhoneBoxView.setAutomaticDirection()
        self.userTelegramBoxView.setAutomaticDirection()
        
        self.shopNameBoxView.setAutomaticDirection()
        self.shopPhoneBoxView.setAutomaticDirection()
        self.shopAddressBoxView.setAutomaticDirection()
        
        self.changeSubCategoryBoxView.setAutomaticDirection()
        self.changeLanguageBoxView.setAutomaticDirection()
        self.exitBoxView.setAutomaticDirection()
        
        self.userNameValueLabel.setAutomaticAlignment()
        self.userPhoneValueLabel.setAutomaticAlignment()
        self.userTelegramValueLabel.setAutomaticAlignment()
        
        self.shopNameValueLabel.setAutomaticAlignment()
        self.shopPhoneValueLabel.setAutomaticAlignment()
        self.shopAddressValueLabel.setAutomaticAlignment()
        
        self.changeSubCategoryValueLabel.setAutomaticAlignment()
        self.changeLanguageValueLabel.setAutomaticAlignment()
        self.exitValueLabel.setAutomaticAlignment()
        
        self.userNameValueLabel.textColor = .lightGray
        self.userPhoneValueLabel.textColor = .lightGray
        self.userTelegramValueLabel.textColor = .lightGray
        
        self.shopNameValueLabel.textColor = .lightGray
        self.shopPhoneValueLabel.textColor = .lightGray
        self.shopAddressValueLabel.textColor = .lightGray
        
        self.changeSubCategoryValueLabel.textColor = .lightGray
        self.changeLanguageValueLabel.textColor = .lightGray
        self.exitValueLabel.textColor = .lightGray
        
        let tapGestureOnChangeLanguage = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.userDidTapOnChangeLanguage))
        self.changeLanguageBoxView.addGestureRecognizer(tapGestureOnChangeLanguage)
        
        let tapGestureOnExit = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.userDidTapOnExit))
        self.exitBoxView.addGestureRecognizer(tapGestureOnExit)
        
        if(self.account != nil){
            self.userNameValueLabel.text = String(format:"%@ %@","Seller Name:".localized(), (self.account?.firstName)!)
            self.userPhoneValueLabel.text = String(format:"%@ %@","Seller Phone:".localized(), (self.account?.phoneNumber)!)
            self.userTelegramValueLabel.text = String(format:"%@ %@","Seller Telegram ID:".localized(), (self.account?.telegram)!)
            
            self.shopNameValueLabel.text = String(format:"%@ %@","Shop Name:".localized(), (self.account?.shopName)!)
            self.shopPhoneValueLabel.text = String(format:"%@ %@","Shop Phone Number:".localized(), (self.account?.shopPhone)!)
            self.shopAddressValueLabel.text = String(format:"%@ %@","Shop Address:".localized(), (self.account?.shopAddress)!)
            
            self.changeSubCategoryValueLabel.text = String(format:"Change SubCategory".localized())
            self.changeLanguageValueLabel.text = String(format:"Change Language".localized())
            self.exitValueLabel.text = String(format:"Exit".localized())
        }else{
            self.userNameValueLabel.text = String(format:"Seller Name:".localized())
            self.userPhoneValueLabel.text = String(format:"Seller Phone:".localized())
            self.userTelegramValueLabel.text = String(format:"Seller Telegram ID:".localized())
            
            self.shopNameValueLabel.text = String(format:"Shop Name:".localized())
            self.shopPhoneValueLabel.text = String(format:"Shop Phone Number:".localized())
            self.shopAddressValueLabel.text = String(format:"Shop Address:".localized())
            
            self.changeSubCategoryValueLabel.text = String(format:"Change SubCategory".localized())
            self.changeLanguageValueLabel.text = String(format:"Change Language".localized())
            self.exitValueLabel.text = String(format:"Exit".localized())
        }
        
        let curentLanguage = Localize.currentLanguage()
        let english = MMAlert()
        english.title = "English".localized()
        english.image = #imageLiteral(resourceName: "International")
        
        let farsi = MMAlert()
        farsi.title = "Persian".localized()
        farsi.image = #imageLiteral(resourceName: "IranFlag")
        if(curentLanguage == "fa"){
            farsi.isChecked = true
        }else{
            english.isChecked = true
        }
        
        self.elements?.append(english)
        self.elements?.append(farsi)
    }
    
    @objc private func userDidTapOnChangeLanguage(){
        self.delegate?.showDialogLanguage(fromController: self, elements: self.elements!)
    }
    
    @objc private func userDidTapOnExit(){
        self.delegate?.showDialogLogout(fromController: self, title: "Exit".localized(), content: "Are you sure to exit".localized())
    }
    
    //MARK:- alert alert delegate
    func userDidTapOnOkButton(fromController: MMAlertAlertViewController) {
        self.delegate?.dismissDialogLogout(controller: fromController, complition: {
            print("User did tap on Exit")
            KRProgressHUD.show(progressHUDStyle: KRProgressHUDStyle.color(background: UIColor.white, contents: UIUtility.germezColor()), maskType: KRProgressHUDMaskType.black, activityIndicatorStyle: KRProgressHUDActivityIndicatorStyle.color(UIUtility.germezColor(), UIColor.yellow), font: UIUtility.normalFontAutoWithPlusSize(), message: "Logout...".localized(), image: nil, completion: {
                
            })
            
            if(Service.sharedInstanse.logoutUser()){
                DispatchQueue.main.async {
                    KRProgressHUD.dismiss()
                    self.delegate?.successFullySignOut()
                }
            }
        })
    }
    
    func userDidTapOnCancelButton(fromController: MMAlertAlertViewController) {
        self.delegate?.dismissDialogLogout(controller: fromController, complition: {
            
        })
    }
    
    //MARK:- alert delegate
    func userDidTapOnElement(fromController: MMAlertSheetViewController, index: Int, withElements: [MMAlert]) {
        self.delegate?.dismissDialogLanguage(fromController: fromController, complition: {
            if(index == 0){
                self.changeLanguageTo(language: "en")
            }else{
                self.changeLanguageTo(language: "fa")
            }
        })
    }
    
    func userDidTapOnDismissAlertController(fromController: MMAlertSheetViewController) {
        self.delegate?.dismissDialogLanguage(fromController: fromController, complition: {
            
        })
    }
    
    //MARK:- change language
    private func changeLanguageTo(language:String?){
        Localize.setCurrentLanguage(language!)
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        self.delegate?.succssfulyChangeLanguage()
    }
}
