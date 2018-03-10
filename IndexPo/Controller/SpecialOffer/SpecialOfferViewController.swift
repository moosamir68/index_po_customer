//
//  SpecialOfferViewController.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/18/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit
import Font_Awesome_Swift
import Toaster

protocol SpecialOfferDelegate {

}

class SpecialOfferViewController: MasterViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var cancelOfferButton: UIButton!
    @IBOutlet var increaseTimeButton: UIButton!
    @IBOutlet var timeRemainLabel: UILabel!
    @IBOutlet var esentialPriceLabel: UILabel!
    @IBOutlet var alertImageView: UIImageView!
    @IBOutlet var alertTitleLabel: UILabel!
    @IBOutlet var productNameConstraintMarginTop: NSLayoutConstraint!
    @IBOutlet var remainTimeConstraintWidth: NSLayoutConstraint!
    
    var specialOffer:SpecialOffer?
    var delegate:SpecialOfferDelegate?
    var timer:Timer?
    var showAlert:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startTimerProgress()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.stopProgress()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- initUI
    override func initUI(){
        let shareButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(SpecialOfferViewController.userDidTapOnShareButton))
        shareButton.setFAIcon(icon: .FAShareAlt, iconSize: 25)
        self.navigationItem.rightBarButtonItem = shareButton
        
        
        self.imageView.image = #imageLiteral(resourceName: "loading")
        
        self.cancelOfferButton.layer.cornerRadius = 2.0
        self.cancelOfferButton.backgroundColor = UIUtility.germezColor()
        self.cancelOfferButton.setTitleColor(.white, for: .normal)
        self.cancelOfferButton.setTitle("Cancel Offer".localized(), for: .normal)
        self.cancelOfferButton.titleLabel?.font = UIUtility.boldFontAutoWithPlusSize()
        
        self.increaseTimeButton.layer.cornerRadius = 2.0
        self.increaseTimeButton.backgroundColor = UIUtility.sormaeiColor()
        self.increaseTimeButton.setTitleColor(.white, for: .normal)
        self.increaseTimeButton.setTitle("Increase Time".localized(), for: .normal)
        self.increaseTimeButton.titleLabel?.font = UIUtility.boldFontAutoWithPlusSize()
        
        self.productNameLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.productPriceLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.esentialPriceLabel.font = UIUtility.normalFontAutoWithPlusSize()
        
        if(self.specialOffer?.product != nil){
            
            let titlePrice = "Price:".localized()
            let toman = "Toman".localized()
            let titleProductName = "Product Name:".localized()
            
            self.productNameLabel.text = String(format:"%@ %@", titleProductName, (self.specialOffer?.product?.name)!)
            self.productPriceLabel.text = String(format:"%@ %@ %@", titlePrice, (self.specialOffer?.suggestedPrice.formattedWithSeparator)!, toman)
            
            
            if(self.specialOffer?.product?.photoURLs != nil && self.specialOffer?.product?.photoURLs?.count != 0){
                let url = URL(string: (self.specialOffer?.product?.photoURLs?.first)!)
                self.imageView.kf.setImage(with: url)
            }
        }
        
        self.timeRemainLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.alertTitleLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.timeRemainLabel.textColor = .white
        self.esentialPriceLabel.textColor = .lightGray
        self.alertTitleLabel.textColor = UIUtility.germezColor()
        self.timeRemainLabel.text = "00:00:00"
        self.alertImageView.image = #imageLiteral(resourceName: "attention")
        self.alertTitleLabel.text = "Less than one other day is valid".localized()
        self.productNameConstraintMarginTop.constant = 8.0
        self.alertImageView.isHidden = true
        self.alertTitleLabel.isHidden = true
        self.showAlert = false
        
        self.timeRemainLabel.backgroundColor = UIUtility.sormaeiColor().withAlphaComponent(0.5)
        self.timeRemainLabel.textColor = .white
        self.timeRemainLabel.layer.cornerRadius = 12
        self.timeRemainLabel.layer.masksToBounds = true
        
        self.boxView.setAutomaticDirection()
        
    }
    
    //MARK:- timer
    private func fillTime() ->(validate:Bool, timeString:String){
        var day:Int = 0
        var hour:Int = 0
        var min:Int = 0
        var sec:Int = 0
        
        if(self.specialOffer != nil){
            var remainTime:Int = (self.specialOffer?.remainingTime)!
            
            if(remainTime <= 0){
                self.showAlertBadge()
                return (false, "00:00:00")
            }else{
                
                if(remainTime >= 86400){
                    day = remainTime / 86400
                    remainTime = remainTime % 86400
                }
                
                if(remainTime >= 3600){
                    hour = remainTime / 3600
                    remainTime = remainTime % 3600
                }
                
                if(remainTime >= 60){
                    min = remainTime / 60
                    remainTime = remainTime % 60
                }
                
                if(remainTime >= 0){
                    sec = remainTime
                }
            }
            
            if(day > 0){
                self.hideAlertBadge()
                let timeString = String(format:"%d:%02d:%02d:%02d", day, hour, min, sec)
                return (true, timeString)
            }else{
                self.showAlertBadge()
                let timeString = String(format:"%02d:%02d:%02d", hour, min, sec)
                return (true, timeString)
            }
        }else{
            self.showAlertBadge()
            return (false, "00:00:00")
        }
    }
    
    func startTimerProgress() {
        OperationQueue.main.addOperation {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (_) in
                let (_ , timeString) = (self?.fillTime())!
                self?.timeRemainLabel.text = timeString
                self?.specialOffer?.remainingTime = (self?.specialOffer?.remainingTime)! - 1
                self?.remainTimeConstraintWidth.constant = (self?.timeRemainLabel.intrinsicContentSize.width)! + 24
            })
        }
    }
    
    func stopProgress(){
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func showAlertBadge(){
        if(!self.showAlert){
            self.alertImageView.isHidden = false
            self.alertTitleLabel.isHidden = false
            self.productNameConstraintMarginTop.constant = 37.0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            self.showAlert = true
        }
    }
    
    func hideAlertBadge(){
        if(self.showAlert){
            self.alertImageView.isHidden = true
            self.alertTitleLabel.isHidden = true
            self.productNameConstraintMarginTop.constant = 8.0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            self.showAlert = false
        }
    }
    
    //MARK:- user did tap on share
    @objc private func userDidTapOnShareButton(){
        
    }
}
