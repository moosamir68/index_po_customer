//
//  BrowseBanner.swift
//  IndexPo
//
//  Created by Moosa Mir on 3/13/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class BrowseBanner: BrowseObject {
    var image:String = ""
    var title:String = ""
    var link:String = ""
    
    override init() {
        super.init()
    }
    
    override init(dictionary:NSDictionary) {
        super.init(dictionary: dictionary)
        
        if(dictionary["bannerItem"] != nil){
            if let subDic:NSDictionary = dictionary["bannerItem"] as? NSDictionary{
                
                if(subDic["image"] != nil){
                    if let image:String = subDic["image"] as? String{
                        self.image = image
                    }
                }
                
                if(subDic["title"] != nil){
                    if let title:String = subDic["title"] as? String{
                        self.title = title
                    }
                }
                
                if(subDic["link"] != nil){
                    if let link:String = subDic["link"] as? String{
                        self.link = link
                    }
                }
            }
        }
    }
}
