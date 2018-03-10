//
//  Color.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 1/20/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class Color: BaseObject, NSCoding {
    var colorId:String?
    var colorTitle:String?
    var colorHex:String?
    
    init(dictionary:NSDictionary){
        super.init()
        
        if (dictionary["id"]) != nil {
            if let id:String = dictionary.object(forKey: "id") as? String{
                self.colorId = id
            }
        }
        
        if (dictionary["title"]) != nil {
            if let title:String = dictionary.object(forKey: "title") as? String{
                self.colorTitle = title
            }
        }
        
        if (dictionary["hex"]) != nil {
            if let colorHex:String = dictionary.object(forKey: "hex") as? String{
                self.colorHex = colorHex
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        if((aDecoder.decodeObject(forKey: "id") as? String) != nil){
            self.colorId = aDecoder.decodeObject(forKey: "id") as? String
        }
        
        if((aDecoder.decodeObject(forKey: "title") as? String) != nil){
            self.colorTitle = aDecoder.decodeObject(forKey: "title") as? String
        }
        
        if((aDecoder.decodeObject(forKey: "hex") as? String) != nil){
            self.colorHex = aDecoder.decodeObject(forKey: "hex") as? String
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.colorId, forKey: "id")
        aCoder.encode(self.colorTitle, forKey: "title")
        aCoder.encode(self.colorHex, forKey: "hex")
    }
    
    override init() {
        super.init()
    }
}
