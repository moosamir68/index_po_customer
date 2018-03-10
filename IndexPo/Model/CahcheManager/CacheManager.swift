//
//  CacheManager.swift
//  Artiscovery
//
//  Created by iOSDeveloper on 7/12/17.
//  Copyright © 2017 Artiscovery. All rights reserved.
//

import UIKit

class CacheManager: NSObject {
    
    static let sharedInstance:CacheManager? = CacheManager()
    let fileManager = FileManager.default
    
    override init() {
        super.init()
    }
}
