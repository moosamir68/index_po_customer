//
//  BrowseShowingItem.swift
//  IndexPo
//
//  Created by Moosa Mir on 3/13/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class BrowseShowingItem: NSObject {
    
    var image:String = ""
    var name:String = ""
    var price:Int = 0
    var fancyCount:Int = 0
    var shortDetails:String = ""
    
    init(dictionary:NSDictionary) {
        if(dictionary["image"] != nil){
            if let image:String = dictionary["image"] as? String{
                self.image = image
            }
        }
        
        if(dictionary["name"] != nil){
            if let name:String = dictionary["name"] as? String{
                self.name = name
            }
        }
        
        if(dictionary["price"] != nil){
            if let price:Int = dictionary["price"] as? Int{
                self.price = price
            }
        }
        
        if(dictionary["fancy_count"] != nil){
            if let fancyCount:Int = dictionary["fancy_count"] as? Int{
                self.fancyCount = fancyCount
            }
        }
        
        if(dictionary["short_details"] != nil){
            if let shortDetails:String = dictionary["short_details"] as? String{
                self.shortDetails = shortDetails
            }
        }
    }
}
