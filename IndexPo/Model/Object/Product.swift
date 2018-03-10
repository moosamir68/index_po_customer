//
//  Product.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/10/17.
//  Copyright © 2017 Noxel. All rights reserved.
//
import UIKit

class Product: BaseObject {
    var productId:String = ""
    var name:String? = ""
    var guaranteeName:String? = ""
    var price:Int = 0
    var currency:Int = 0
    var photoURLs:[String]? = [String]()
    var properties:[String]? = [String]()
    var status:Bool = false
    var nameEn:String? = ""
    var digikId:String? = ""
    var colors:[String]? = [String]()
    var minPrice:Int = 0
    var maxPrice:Int = 0
    var existStatus:Bool = false
    var colorName:String? = ""
    var imageUrl:String?
    
    init(dictionary:NSDictionary){
        super.init()
        
        if (dictionary["id"]) != nil {
            if let id:String = dictionary.object(forKey: "id") as? String{
                self.productId = id
            }
        }
        
        if (dictionary["name"]) != nil {
            if let name:String = dictionary.object(forKey: "name") as? String{
                self.name = name
            }
        }
        
        if (dictionary["guarantee"]) != nil {
            if let guarantee:String = dictionary.object(forKey: "guarantee") as? String{
                self.guaranteeName = guarantee
            }
        }
        
        if (dictionary["price"]) != nil {
            if let price:Int = dictionary.object(forKey: "price") as? Int{
                self.price = price
            }
        }
        
        if (dictionary["currency"]) != nil {
            if let currency:Int = dictionary.object(forKey: "currency") as? Int{
                self.currency = currency
            }
        }
        
        if (dictionary["photoURLs"]) != nil {
            if let photoURLs:[String] = dictionary.object(forKey: "photoURLs") as? [String]{
                self.photoURLs = photoURLs
            }
        }
        
        if (dictionary["properties"]) != nil {
            if let properties:[String] = dictionary.object(forKey: "properties") as? [String]{
                self.properties = properties
            }
        }
        
        if (dictionary["status"]) != nil {
            if let status:Bool = dictionary.object(forKey: "status") as? Bool{
                self.status = status
            }
        }
        
        if (dictionary["name_en"]) != nil {
            if let nameEn:String = dictionary.object(forKey: "name_en") as? String{
                self.nameEn = nameEn
            }
        }
        
        if (dictionary["digik_id"]) != nil {
            if let digikId:String = dictionary.object(forKey: "digik_id") as? String{
                self.digikId = digikId
            }
        }
        
        if (dictionary["colors"]) != nil {
            if let colors:[String] = dictionary.object(forKey: "colors") as? [String]{
                self.colors = colors
            }
        }
        
        if (dictionary["min_price"]) != nil {
            if let minPrice:Int = dictionary.object(forKey: "min_price") as? Int{
                self.minPrice = minPrice
            }
        }
        
        if (dictionary["max_price"]) != nil {
            if let maxPrice:Int = dictionary.object(forKey: "max_price") as? Int{
                self.maxPrice = maxPrice
            }
        }
        
        if (dictionary["exist_status"]) != nil {
            if let existStatus:Bool = dictionary.object(forKey: "exist_status") as? Bool{
                self.status = existStatus
            }
        }
        
        if (dictionary["image_path"]) != nil {
            if let imageUrl:String = dictionary.object(forKey: "image_path") as? String{
                self.imageUrl = imageUrl
            }
        }
        
    }
    
    override init() {
        super.init()
    }
}
