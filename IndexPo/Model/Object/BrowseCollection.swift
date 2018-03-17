//
//  BrowseCollection.swift
//  IndexPo
//
//  Created by Moosa Mir on 3/13/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class BrowseCollection: BrowseObject {
    
    var images:[String] = [String]()
    var title:String = ""
    var link:String = ""
    var id:String = ""
    
    override init() {
        super.init()
    }
    
    override init(dictionary:NSDictionary) {
        super.init(dictionary: dictionary)
        
        if(dictionary["collectionItem"] != nil){
            if let subDic:NSDictionary = dictionary["collectionItem"] as? NSDictionary{
                
                if(subDic["images"] != nil){
                    if let images:[String] = subDic["images"] as? [String]{
                        for image in images {
                            self.images.append(image)
                        }
                    }
                }
                
                if(subDic["title"] != nil){
                    if let title:String = subDic["title"] as? String{
                        self.title = title
                    }
                }
                
                if(subDic["id"] != nil){
                    if let id:String = subDic["id"] as? String{
                        self.id = id
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
