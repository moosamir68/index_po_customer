//
//  VVExtentions.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/3/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit
import Localize_Swift
import MMMaterialDesignSpinner

class Extentions: NSObject {
    
}

//MARK: - Button
extension UIButton {
    
    func setAutomaticAlignment(){
        let language = Localize.currentLanguage()
        if language == "fa"{
            self.contentHorizontalAlignment = .right
        }else{
            self.contentHorizontalAlignment = .left
        }
    }
    
    func startLoading() {
        self.isUserInteractionEnabled = false
        let indicatorFrame = CGRect(x: 0.0,
                                    y: 0.0,
                                    width: self.bounds.height * 0.6,
                                    height: self.bounds.height * 0.6)
        let indicator = MMMaterialDesignSpinner(frame: indicatorFrame)
        indicator.lineWidth = 2.0
        indicator.tintColor = self.titleLabel?.textColor
        
        
        self.addSubview(indicator)
        indicator.frame = CGRect(x: (self.bounds.size.width / 2.0) - (indicatorFrame.size.width / 2.0),
                                 y: (self.bounds.size.height / 2.0) - (indicatorFrame.size.height / 2.0),
                                 width: indicatorFrame.height,
                                 height: indicatorFrame.height)
        
        indicator.alpha = 0.0
        indicator.startAnimating()
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        
                        self.setTitleColor(.clear,
                                           for: .normal)
                        indicator.alpha = 1.0
                        
        }) { (finished: Bool) in
            
            
        }
        
    }
    
    func stopAnimation() {
        
        self.isUserInteractionEnabled = true
        self.setTitleColor(.white,
                           for: .normal)
        for tmpView in self.subviews {
            
            if tmpView.isKind(of: MMMaterialDesignSpinner.classForCoder()) {
                
                
                tmpView.removeFromSuperview()
                
                
            }
            
        }
        
    }
}

extension UIView{
    func setAutomaticDirection(){
        let language = Localize.currentLanguage()
        if language == "fa"{
            self.semanticContentAttribute = .forceRightToLeft
        }else{
            self.semanticContentAttribute = .forceLeftToRight
        }
    }
    
    func setLeftDirection(){
        self.semanticContentAttribute = .forceLeftToRight
    }
    
    func makeFade() {
        self.alpha = 0.0
    }
    
    func fadeIn() {
        self.alpha = 1.0
        self.transform = .identity
    }
    
}

extension UITextField{
    func setAutomaticAlignment(){
        let language = Localize.currentLanguage()
        if language == "fa"{
            self.textAlignment = .right
        }else{
            self.textAlignment = .left
        }
    }
}

extension UILabel{
    func setAutomaticAlignment(){
        let language = Localize.currentLanguage()
        if language == "fa"{
            self.textAlignment = .right
            }else{
                self.textAlignment = .left
            }
        }
        
        func setAutomaticAlignmentReverse(){
            let language = Localize.currentLanguage()
            if language == "fa"{
                self.textAlignment = .left
            }else{
                self.textAlignment = .right
            }
        }
}

extension UITextView{
    func setAutomaticAlignment(){
        let language = Localize.currentLanguage()
        if language == "fa"{
            self.textAlignment = .right
        }else{
            self.textAlignment = .left
        }
    }
    
    func setAutomaticAlignmentReverse(){
        let language = Localize.currentLanguage()
        if language == "fa"{
            self.textAlignment = .left
        }else{
            self.textAlignment = .right
        }
    }
}

extension Data {
    
    /// Append string to NSMutableData
    ///
    /// Rather than littering my code with calls to `dataUsingEncoding` to convert strings to NSData, and then add that data to the NSMutableData, this wraps it in a nice convenient little extension to NSMutableData. This converts using UTF-8.
    ///
    /// - parameter string:       The string to be added to the `NSMutableData`.
    
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ",".localized()
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension BinaryInteger {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}

extension String {
    func addTomanToPrice(title:String) ->String {
        return String(format:"%@ %@", self, title)
    }
    
    func hexStringToUIColor() -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension Double {
    func getDateString() ->String{
        let date = Date(timeIntervalSince1970: self)
        let calender = Calendar(identifier: .persian)
        let year = calender.component(.year, from: date)
        let month = calender.component(.month, from: date)
        let day = calender.component(.day, from: date)
        return String(format:"%d/%d/%d", year, month, day)
    }
}
