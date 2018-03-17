//
//  BrowseSlider.swift
//  IndexPo
//
//  Created by Moosa Mir on 3/13/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class BrowseSlider:BrowseObject {
    var images:[String] = [String]()
    
    override init() {
        super.init()
    }
    
    override init(dictionary:NSDictionary) {
        super.init(dictionary: dictionary)
        
        if(dictionary["sliderItem"] != nil){
            if let subDic:NSDictionary = dictionary["sliderItem"] as? NSDictionary{
                if(subDic["images"] != nil){
                    if let imageArray:NSArray = subDic["images"] as? NSArray{
                        for imageUrl in imageArray {
                            self.images.append(imageUrl as! String)
                        }
                    }
                }
            }
        }
    }
}
