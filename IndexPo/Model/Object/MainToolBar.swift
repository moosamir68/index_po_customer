//
//  MainToolBar.swift
//  IndexPo
//
//  Created by Moosa Mir on 3/12/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

enum mainToolBarType:Int {
    case home = 1
    case categories = 2
    case grid = 3
    case collections = 4
    case gif = 5
}

struct MainToolBar {
    var title:String = ""
    var type:Int = 1
    var url:String = ""
    
    init(dictionary:NSDictionary){
        
        if (dictionary["title"]) != nil {
            if let title:String = dictionary.object(forKey: "title") as? String{
                self.title = title
            }
        }
        
        if (dictionary["type"]) != nil {
            if let type:Int = dictionary.object(forKey: "type") as? Int{
                self.type = type
            }
        }
        
        if (dictionary["url"]) != nil {
            if let url:String = dictionary.object(forKey: "url") as? String{
                self.url = url
            }
        }
    }
}
