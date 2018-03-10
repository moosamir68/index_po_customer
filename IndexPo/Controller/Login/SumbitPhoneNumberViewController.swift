//
//  SumbitPhoneNumberViewController.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/4/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit
import Toaster

protocol SumbitPhoneNumberDelegate {
    func showSubmitVerificationCodeController(fromController:SumbitPhoneNumberViewController?, phoneNumber:String)
}

class SumbitPhoneNumberViewController: MasterViewController {
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var phoneNumberBoxView: UIView!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var boxViewMarginBottom: NSLayoutConstraint!
    
    var delegate:SumbitPhoneNumberDelegate?
    
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
        self.phoneNumberTextField.font = UIUtility.normalFontAutoWithPlusSize()
        self.phoneNumberTextField.keyboardType = UIKeyboardType.phonePad
        self.phoneNumberTextField.placeholder = "Please Enter Phone Number".localized()
        
        self.phoneNumberBoxView.layer.cornerRadius = 5.0
        self.phoneNumberBoxView.layer.borderColor = UIUtility.sormaeiColor().cgColor
        self.phoneNumberBoxView.layer.borderWidth = 1
        self.phoneNumberBoxView.layer.masksToBounds = true
        
        self.doneButton.layer.cornerRadius = 5.0
        self.doneButton.layer.masksToBounds = true
        self.doneButton.backgroundColor = UIUtility.sormaeiColor()
        self.doneButton.setTitleColor(.white, for: .normal)
        self.doneButton.setTitle("Done".localized(), for: .normal)
        self.doneButton.titleLabel?.font = UIUtility.normalFontAutoWithPlusSize()
        
        let tapZGesture = UITapGestureRecognizer(target: self, action: #selector(SumbitPhoneNumberViewController.userDidTapOnView))
        self.boxView.addGestureRecognizer(tapZGesture)
        self.boxView.isUserInteractionEnabled = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(SumbitPhoneNumberViewController.userDidTapOnView))
        self.boxView.addGestureRecognizer(panGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SumbitPhoneNumberViewController.showKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SumbitPhoneNumberViewController.hideKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    //MARK:- interlan method
    @IBAction func userDidTapOnDoneButton(_ sender: UIButton) {
        self.phoneNumberTextField.resignFirstResponder()
        if(self.checkValidateData()){
            self.doneButton.startLoading()
            let phoneNumber = self.phoneNumberTextField.text
            Service.sharedInstanse.sendPhoneNumber(phoneNumber: phoneNumber!, callback: { (error) in
                DispatchQueue.main.async {
                    self.doneButton.stopAnimation()
                    if(error == nil){
                        self.delegate?.showSubmitVerificationCodeController(fromController: self, phoneNumber: phoneNumber!)
                        return
                    }else{
                        let toast = Toast(text: error?.errorDescription)
                        toast.show()
                        return
                    }
                }
            })
        }else{
            self.phoneNumberTextField.resignFirstResponder()
            let toast = Toast(text: "Please enter phone number".localized())
            toast.show()
        }
    }
    
    private func checkValidateData() ->Bool{
        if(self.phoneNumberTextField.text == nil || self.phoneNumberTextField.text == ""){
            return false
        }
        
        return true
    }
    
    @objc private func userDidTapOnView(){
        self.phoneNumberTextField.resignFirstResponder()
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
