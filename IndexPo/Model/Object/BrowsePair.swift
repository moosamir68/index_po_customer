//
//  BrowsePair.swift
//  IndexPo
//
//  Created by Moosa Mir on 3/13/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

import UIKit

class BrowsePair: BrowseObject {
    
    var title:String = ""
    var id = ""
    var showingItems = [BrowseShowingItem]()
    
    override init() {
        super.init()
    }
    
    override init(dictionary:NSDictionary) {
        super.init(dictionary: dictionary)
        
        if(dictionary["pairItem"] != nil){
            if let subDic:NSDictionary = dictionary["pairItem"] as? NSDictionary{
                
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
                
                
                if(subDic["showingItems"] != nil){
                    if let showingItemArray:NSArray = subDic["showingItems"] as? NSArray{
                        for showingItemDic in showingItemArray {
                            let showingItem = BrowseShowingItem(dictionary: showingItemDic as! NSDictionary)
                            self.showingItems.append(showingItem)
                        }
                    }
                }
            }
        }
    }
    
}
