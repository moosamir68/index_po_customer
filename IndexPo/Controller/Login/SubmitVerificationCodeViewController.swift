//
//  SubmitVerificationCodeViewController.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/4/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit
import Toaster

protocol SubmitVerificationCodeDelegate {
    func showGetUserInformationController(fromController:SubmitVerificationCodeViewController?)
    func showHomeController(fromController:SubmitVerificationCodeViewController?)
    func backToChangePhoneNumber(fromController:SubmitVerificationCodeViewController?)
}

class SubmitVerificationCodeViewController: MasterViewController {
    @IBOutlet var inputCodeTextFeild: UITextField!
    @IBOutlet var inputCodeBoxView: UIView!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var boxViewMarginBottom: NSLayoutConstraint!
    @IBOutlet var changePhoneNumberButton: UIButton!
    
    var delegate:SubmitVerificationCodeDelegate?
    var phoneNumber:String = ""
    var countRequest = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:- initUI
    override func initUI(){
        self.inputCodeTextFeild.font = UIUtility.normalFontAutoWithPlusSize()
        self.inputCodeTextFeild.keyboardType = .decimalPad
        self.inputCodeTextFeild.placeholder = "Enter Recived Code".localized()
        
        self.inputCodeBoxView.layer.masksToBounds = true
        self.inputCodeBoxView.layer.borderWidth = 1.0
        self.inputCodeBoxView.layer.borderColor = UIUtility.sormaeiColor().cgColor
        self.inputCodeBoxView.layer.cornerRadius = 5.0
        
        self.doneButton.layer.cornerRadius = 5.0
        self.doneButton.layer.masksToBounds = true
        self.doneButton.backgroundColor = UIUtility.sormaeiColor()
        self.doneButton.setTitleColor(.white, for: .normal)
        self.doneButton.setTitle("Done".localized(), for: .normal)
        self.doneButton.titleLabel?.font = UIUtility.normalFontAutoWithPlusSize()
        
        self.changePhoneNumberButton.setTitle("Change Phone Number".localized(), for: .normal)
        self.changePhoneNumberButton.titleLabel?.font = UIUtility.normalFontAutoWithPlusSize()
        
        let tapZGesture = UITapGestureRecognizer(target: self, action: #selector(SubmitVerificationCodeViewController.userDidTapOnView))
        self.boxView.addGestureRecognizer(tapZGesture)
        self.boxView.isUserInteractionEnabled = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(SubmitVerificationCodeViewController.userDidTapOnView))
        self.boxView.addGestureRecognizer(panGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SubmitVerificationCodeViewController.showKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SubmitVerificationCodeViewController.hideKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //MARK:- interlan method
    @IBAction func userDidTapOnDoneButton(_ sender: UIButton) {
        self.inputCodeTextFeild.resignFirstResponder()
        if(self.checkValidateData()){
            self.doneButton.startLoading()
            let code = self.inputCodeTextFeild.text
            Service.sharedInstanse.sendVerificationCode(verificationCode: code!, phoneNumber: self.phoneNumber, callback: { (error) in
                DispatchQueue.main.async {
                    if(error == nil){
                        self.getUserInfoAndManageNavigation()
                    }else{
                        self.doneButton.stopAnimation()
                        let toast = Toast(text: error?.errorDescription)
                        toast.show()
                        return
                    }
                }
            })
        }else{
            self.inputCodeTextFeild.resignFirstResponder()
            let toast = Toast(text: "Please enter phone number".localized())
            toast.show()
        }
    }
    
    private func getUserInfoAndManageNavigation(){
        self.countRequest = self.countRequest + 1
        let localCountRequest = self.countRequest
        
        Service.sharedInstanse.getUserInfo(callback: { (account, error) in
            if(self.countRequest == localCountRequest){
                if(error == nil && account != nil){
                    DispatchQueue.main.async {
                        self.doneButton.stopAnimation()
                        if(account?.sentInfo)!{
                            self.countRequest = self.countRequest + 1
                            self.delegate?.showHomeController(fromController: self)
                            return
                        }else{
                            self.countRequest = self.countRequest + 1
                            self.delegate?.showGetUserInformationController(fromController: self)
                            return
                        }
                    }
                }else{
                    self.getUserInfoAndManageNavigation()
                }
            }
        })
    }
    
    private func checkValidateData() ->Bool{
        if(self.inputCodeTextFeild.text == nil || self.inputCodeTextFeild.text == ""){
            return false
        }
        
        return true
    }
    
    @objc private func userDidTapOnView(){
        self.inputCodeTextFeild.resignFirstResponder()
    }
    

    @IBAction func userDidTapOnChangePhoenNumber(_ sender: Any) {
        self.delegate?.backToChangePhoneNumber(fromController: self)
    }
    
    //MARK:- Notification keyboard
    @objc private func showKeyboard(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("Keyboard heihgt pn type description for new post", keyboardSize.height)
            self.boxViewMarginBottom.constant = -1.0 * keyboardSize.height
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc private func hideKeyboard(notification: NSNotification){
        self.boxViewMarginBottom.constant = 0.0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }

}
