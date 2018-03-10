//
//  SpecialOffersCollectionViewCell.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/10/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit

class SpecialOffersCollectionViewCell: UICollectionViewCell {
    @IBOutlet var boxView: UIView!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var timeerLabel: UILabel!
    @IBOutlet var alertImageView: UIImageView!
    @IBOutlet var timeBox: UIView!
    
    var specialOffer = SpecialOffer()
    var timer:Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.priceLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.productNameLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.timeerLabel.font = UIUtility.normalFontAutoWithPlusSize()
        
        self.priceLabel.textAlignment = .center
        self.productNameLabel.textAlignment = .center
        self.timeerLabel.textAlignment = .center
        
        self.priceLabel.text = ""
        self.productNameLabel.text = ""
        self.timeerLabel.text = "00:00:00"
        self.productImageView.image = #imageLiteral(resourceName: "loading")
        
        self.priceLabel.adjustsFontSizeToFitWidth = true
        self.productNameLabel.adjustsFontSizeToFitWidth = false
        self.timeerLabel.adjustsFontSizeToFitWidth = true
        
        self.timeerLabel.textColor = .white
        self.timeBox.backgroundColor = UIUtility.sormaeiColor().withAlphaComponent(0.5)
        self.boxView.backgroundColor = .white
        self.boxView.setAutomaticDirection()
        self.timeBox.setAutomaticDirection()
        
        self.boxView.layer.borderColor = UIUtility.sormaeiColor().withAlphaComponent(0.5).cgColor
        self.boxView.layer.borderWidth = 0.5
        
        self.startTimerProgress()
    }

    //MARK:- fill data
    func fillData(specialOffer:SpecialOffer){
        self.specialOffer = specialOffer
        
        self.productNameLabel.text = specialOffer.product?.name
        
        self.priceLabel.text = self.specialOffer.suggestedPrice.formattedWithSeparator.addTomanToPrice(title:"Toman".localized())
        let (_, _) = self.fillTime()
        
        if(self.specialOffer.product?.photoURLs?.count != 0){
            let url = URL(string: (self.specialOffer.product?.photoURLs?.first)!)
            self.productImageView.kf.setImage(with: url)
        }else if(self.specialOffer.product?.imageUrl != nil){
            let url = URL(string: (self.specialOffer.product?.imageUrl)!)
            self.productImageView.kf.setImage(with: url)
        }else{
            self.productImageView.image = #imageLiteral(resourceName: "loading")
        }
    }
    
    private func fillTime() ->(validate:Bool, timeString:String){
        var day:Int = 0
        var hour:Int = 0
        var min:Int = 0
        var sec:Int = 0
        
        var remainTime:Int = self.specialOffer.remainingTime
        
        if(remainTime <= 0){
            self.alertImageView.image = #imageLiteral(resourceName: "watch").withRenderingMode(.alwaysTemplate)
            self.alertImageView.tintColor = UIUtility.badgeTimmerColor()
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
            self.alertImageView.image = nil
            let timeString = String(format:"%d:%02d:%02d:%02d", day, hour, min, sec)
            return (true, timeString)
        }else{
            self.alertImageView.image = #imageLiteral(resourceName: "watch").withRenderingMode(.alwaysTemplate)
            self.alertImageView.tintColor = UIUtility.badgeTimmerColor()
            let timeString = String(format:"%02d:%02d:%02d", hour, min, sec)
            return (true, timeString)
        }
    }
    
    func startTimerProgress() {
        OperationQueue.main.addOperation {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (_) in
                let (_ , timeString) = (self?.fillTime())!
                self?.timeerLabel.text = timeString
                self?.specialOffer.remainingTime = (self?.specialOffer.remainingTime)! - 1
            })
        }
    }
    
    func stopProgress(){
        self.timer?.invalidate()
        self.timer = nil
    }
}
