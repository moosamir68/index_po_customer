//
//  BrowseCategory.swift
//  IndexPo
//
//  Created by Moosa Mir on 3/13/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class BrowseCategory: NSObject {
    var title:String = ""
    var id = ""
    var image:String = ""
    
    init(dictionary:NSDictionary) {
        
        if(dictionary["title"] != nil){
            if let title:String = dictionary["title"] as? String{
                self.title = title
            }
        }
        
        if(dictionary["id"] != nil){
            if let id:String = dictionary["id"] as? String{
                self.id = id
            }
        }
        
        if(dictionary["image"] != nil){
            if let image:String = dictionary["image"] as? String{
                self.image = image
            }
        }
    }
}
