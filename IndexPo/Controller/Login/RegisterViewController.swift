//
//  RegisterViewController.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/5/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit
import Toaster
import TOCropViewController
import MMPhotoLibrary

protocol RegisterDelegate {
    
}

class RegisterViewController: MasterViewController, DoneButtonDelegate, SelectableInputImageDelegate {
    @IBOutlet var boxViewMarginTop: NSLayoutConstraint!
    
    var delegate:RegisterDelegate?
    
    var firstNameView:InputView = InputView()
    var lastNameView:InputView = InputView()
    var telegramView:InputView = InputView()
    var doneButton:DoneButton = DoneButton()
    var imageView:InputShowImage = InputShowImage()
    var contentHeight:CGFloat = 0.0
    
    var account:Account? = Account()
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.showKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.hideKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.userDidTapOnView))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(RegisterViewController.userDidTapOnView))
        self.boxView.addGestureRecognizer(tapGesture)
        self.boxView.addGestureRecognizer(panGesture)
        self.boxView.isUserInteractionEnabled = true
        
        let heightDegault:CGFloat = 52.0
        self.imageView = InputShowImage()
        self.imageView.imageView.image = #imageLiteral(resourceName: "loading")
        
        let tapGestureOnImageView = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.userDidTapOnImageVIew))
        self.imageView.addGestureRecognizer(tapGestureOnImageView)
        self.imageView.isUserInteractionEnabled = true
        
        let selectableImageButton = SelectableInputImage(title: "Select avatar Image".localized(), font: UIUtility.normalFontAutoWithPlusSize(), image: #imageLiteral(resourceName: "PlusBox"))
        selectableImageButton.delegate = self
        self.firstNameView = InputView(placeHolder: "First Name".localized(), font: UIUtility.normalFontAutoWithPlusSize(increaseSize: 1.0))
        self.lastNameView = InputView(placeHolder: "Last Name".localized(), font: UIUtility.normalFontAutoWithPlusSize(increaseSize: 1.0))
        self.telegramView = InputView(placeHolder: "ID Telegram".localized(), font: UIUtility.normalFontAutoWithPlusSize(increaseSize: 1.0))
        
        let curentUser = UserDefault().getUser()
        var phoneNumber = ""
        if(curentUser != nil){
            phoneNumber = (curentUser?.phoneNumber)!
        }
        
        let showPhoneNumber = ShowPhoneNumber(title: "Phone Number".localized(), value: phoneNumber, fontTitle: UIUtility.normalFontAutoWithPlusSize(increaseSize: 0.0), fontValue: UIUtility.normalFontAutoWithPlusSize(increaseSize: 1.0))
        
        self.doneButton = DoneButton(title: "Done".localized(), font: UIUtility.normalFontAutoWithPlusSize())
        self.doneButton.delegate = self
        
        self.boxView.addSubview(self.imageView)
        self.boxView.addSubview(selectableImageButton)
        self.boxView.addSubview(self.firstNameView)
        self.boxView.addSubview(self.lastNameView)
        self.boxView.addSubview(self.telegramView)
        self.boxView.addSubview(showPhoneNumber)
        self.boxView.addSubview(self.doneButton)
        
        self.imageView.imageView.contentMode = .scaleAspectFit
        self.imageView.snp.makeConstraints { (make) in
            make.top.equalTo(24.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(112.0)
        }
        
        self.contentHeight = self.contentHeight + 24.0 + 112.0
        
        selectableImageButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(heightDegault)
        }
        self.contentHeight = self.contentHeight + heightDegault
        
        self.firstNameView.snp.makeConstraints { (make) in
            make.top.equalTo(selectableImageButton.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(heightDegault)
        }
        self.contentHeight = self.contentHeight + heightDegault
        
        self.lastNameView.snp.makeConstraints { (make) in
            make.top.equalTo(self.firstNameView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(heightDegault)
        }
        self.contentHeight = self.contentHeight + heightDegault
        
        self.telegramView.snp.makeConstraints { (make) in
            make.top.equalTo(self.lastNameView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(heightDegault)
        }
        self.contentHeight = self.contentHeight + heightDegault
        
        showPhoneNumber.snp.makeConstraints { (make) in
            make.top.equalTo(self.telegramView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(68)
        }
        self.contentHeight = self.contentHeight + 68.0
        
        doneButton.snp.makeConstraints { (make) in
            make.top.equalTo(showPhoneNumber.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(heightDegault)
        }
        self.contentHeight = self.contentHeight + heightDegault
        
    }
    
    //MARK:- done button delegate
    func userDidTapOnDoneButton() {
        self.userDidTapOnView()
        let (checkValidateData, titleError) = self.checkValidateData()
        if(checkValidateData){
            
            self.account?.firstName = self.firstNameView.textField.text
            self.account?.lastName = self.lastNameView.textField.text
            self.account?.telegram = self.telegramView.textField.text
        }else{
            let toast = Toast(text: titleError)
            toast.show()
            return
        }
    }
    
    //MARK:- internal method
    private func checkValidateData() ->(Bool, String){
        if(self.firstNameView.textField.text == nil || self.firstNameView.textField.text == ""){
            return (false, "Please complete first name".localized())
        }
        
        if(self.lastNameView.textField.text == nil || self.lastNameView.textField.text == ""){
            return (false, "Please complete Last name".localized())
        }
        
        if(self.telegramView.textField.text == nil || self.telegramView.textField.text == ""){
            return (false, "Please complete ID Telegram".localized())
        }
        
        if(self.account?.image == nil){
            return (false, "Please select avatar".localized())
        }
        
        return (true, "")
    }
    
    @objc private func userDidTapOnView(){
        self.firstNameView.textField.resignFirstResponder()
        self.lastNameView.textField.resignFirstResponder()
        self.telegramView.textField.resignFirstResponder()
    }
    
    @objc private func userDidTapOnImageVIew() {
        
    }
    
    //MARK:- selectable show sutton delegate
    func userDidTapOnSelectableInputImage() {
        
    }
    
    //MARK:- Notification keyboard
    @objc private func showKeyboard(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("Keyboard heihgt pn type description for new post", keyboardSize.height)
            let spaceToBottom = self.view.frame.size.height - self.contentHeight
            var marginBottom = keyboardSize.height - spaceToBottom
            if(marginBottom < 0){
                marginBottom = 0.0
            }
            self.boxViewMarginTop.constant = -1 * marginBottom
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc private func hideKeyboard(notification: NSNotification){
        self.boxViewMarginTop.constant = 0.0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
}
