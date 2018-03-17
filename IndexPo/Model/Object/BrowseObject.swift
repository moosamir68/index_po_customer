//
//  BrowseCreateObject.swift
//  IndexPo
//
//  Created by Moosa Mir on 3/13/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

enum BrowseObjectType:String{
    case slider = "slider"
    case pair = "pair"
    case banner = "banner"
    case collection = "collection"
}

class BrowseObject: NSObject {
    var type:BrowseObjectType?
    
    override init() {
        super.init()
    }
    
    init(dictionary:NSDictionary) {
        if(dictionary["type"] != nil){
            if let type:String = dictionary["type"] as? String{
                self.type = BrowseObjectType(rawValue: type)
            }
        }
    }
    
    static func createCurrentObject(dictionary:NSDictionary) ->BrowseObject?{
        let baseObject = BrowseObject(dictionary: dictionary)
        
        
        switch baseObject.type?.rawValue {
        case BrowseObjectType.slider.rawValue?:
            let object = BrowseSlider(dictionary:dictionary)
            return object
            
        case BrowseObjectType.pair.rawValue?:
            let object = BrowsePair(dictionary:dictionary)
            return object
            
        case BrowseObjectType.banner.rawValue?:
            let object = BrowseBanner(dictionary:dictionary)
            return object
            
        case BrowseObjectType.collection.rawValue?:
            let object = BrowseCollection(dictionary:dictionary)
            return object
            
        default:
            break;
        }
        return nil
    }
}
