//
//  CartItem.swift
//  iOSShopBase
//
//  Created by Moosa Mir on 2/6/18.
//  Copyright © 2018 Noxel. All rights reserved.
//
import UIKit

class CartItem: BaseObject {
    
    var requestId:String = ""
    var offerCount:Int = 0
    var count:Int = 0
    var descriptionRequest:String = ""
    var color:Color?
    var date:Date?
    var body:String? = ""
    var message:String? = ""
    var product = Product()
    
    init(dictionary:NSDictionary){
        super.init()
        
        if (dictionary["id"]) != nil {
            if let id:String = dictionary.object(forKey: "id") as? String{
                self.requestId = id
            }
        }
        
        if (dictionary["color"]) != nil {
            if let colorDic:NSDictionary = dictionary.object(forKey: "color") as? NSDictionary{
                self.color = Color(dictionary: colorDic)
            }
        }
        
        if (dictionary["description"]) != nil {
            if let description:String = dictionary.object(forKey: "description") as? String{
                self.descriptionRequest = description
            }
        }
        
        if (dictionary["offerCount"]) != nil {
            if let offerCount:Int = dictionary.object(forKey: "offerCount") as? Int{
                self.offerCount = offerCount
            }
        }
        
        if (dictionary["count"]) != nil {
            if let count:Int = dictionary.object(forKey: "count") as? Int{
                self.count = count
            }
        }
    }
    
    override init() {
        super.init()
    }
}
