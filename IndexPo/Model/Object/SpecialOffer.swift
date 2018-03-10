//
//  SpecialOffer.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/10/17.
//  Copyright © 2017 Noxel. All rights reserved.
//
import UIKit

class SpecialOffer: BaseObject, NSMutableCopying {
    
    func mutableCopy(with zone: NSZone? = nil) -> Any {
        let customObject = SpecialOffer()
        customObject.suggestedPrice = self.suggestedPrice
        customObject.duration = self.duration
        customObject.remainingTime = self.remainingTime
        customObject.expirationTime = self.expirationTime
        customObject.creationDate = self.creationDate
        customObject.specialOfferId = self.specialOfferId
        customObject.product = self.product
        return customObject
    }
    
    var suggestedPrice:Int = 0
    var duration:Int = 0
    var remainingTime:Int = 0
    var expirationTime:Date?
    var creationDate:Date?
    var specialOfferId:String? = ""
    var product:Product?
    
    init(dictionary:NSDictionary){
        super.init()
        
        if (dictionary["suggestedPrice"]) != nil {
            if let suggestedPrice:Int = dictionary.object(forKey: "suggestedPrice") as? Int{
                self.suggestedPrice = suggestedPrice
            }
        }
        
        if (dictionary["id"]) != nil {
            if let id:String = dictionary.object(forKey: "id") as? String{
                self.specialOfferId = id
            }
        }
        
        if (dictionary["duration"]) != nil {
            if let duration:Int = dictionary.object(forKey: "duration") as? Int{
                self.duration = duration
            }
        }
        
        if (dictionary["remainingTime"]) != nil {
            if let remainingTime:Int = dictionary.object(forKey: "remainingTime") as? Int{
                self.remainingTime = remainingTime
            }
        }
        
        if (dictionary["sellerProduct"]) != nil {
            if let product:NSDictionary = dictionary.object(forKey: "sellerProduct") as? NSDictionary{
                self.product = Product(dictionary: product)
            }
        }
        
        if (dictionary["expirationTime"]) != nil {
            if let expirationTime:Date = dictionary.object(forKey: "expirationTime") as? Date{
                self.expirationTime = expirationTime
            }
        }
        
        if (dictionary["creation_date"]) != nil {
            if let creationDate:Date = dictionary.object(forKey: "creation_date") as? Date{
                self.creationDate = creationDate
            }
        }
    }
    
    override init() {
        super.init()
    }
    
}
