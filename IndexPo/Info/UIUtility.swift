//
//  UIUtility.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/3/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

let DEFAULT_FONT_NAME_LIGHT = "IRANSansMobileFaNum-Light"
let DEFAULT_FONT_NAME_LIGHT_MULTI_LINE = "IRANSansMobileMultiLineFaNum-Light"
let DEFAULT_FONT_NAME_BOLD = "IRANSansMobileFaNum-Bold"
let DEFAULT_ID_ALL = "0"
let DEFAULT_INDEX_TABBAR = 0

import UIKit
import Localize_Swift

struct UIUtility {
    static func navigationBarColor() ->UIColor{
        return UIColor(displayP3Red:245.0/255.0, green: 211.0/255.0, blue: 40.0/255.0, alpha: 1.000)
    }
    
    static func boldFontAutoWithPlusSize(increaseSize:CGFloat = 0.0) ->UIFont{
        let language = Localize.currentLanguage()
        if(language == "fa"){
            return UIFont(name: DEFAULT_FONT_NAME_BOLD, size: 14.0 + increaseSize)!
        }else{
            return UIFont.boldSystemFont(ofSize:14.0 + increaseSize)
        }
    }
    
    static func normalFontAutoWithPlusSize(increaseSize:CGFloat = 0.0) ->UIFont{
        
        let language = Localize.currentLanguage()
        if(language == "fa"){
            return UIFont(name: DEFAULT_FONT_NAME_LIGHT, size: 14.0 + increaseSize)!
        }else{
            return UIFont.boldSystemFont(ofSize:14.0 + increaseSize)
        }
    }
    
    static func normalFontAutoMultiLineWithPlusSize(increaseSize:CGFloat = 0.0) ->UIFont{
        let language = Localize.currentLanguage()
        if(language == "fa"){
            return UIFont(name: DEFAULT_FONT_NAME_LIGHT_MULTI_LINE, size: 14.0 + increaseSize)!
        }else{
            return UIFont.boldSystemFont(ofSize:14.0 + increaseSize)
        }
    }
    
    static func boldFontWithPlusSize(increaseSize:CGFloat = 0.0) ->UIFont{
        return UIFont(name: DEFAULT_FONT_NAME_BOLD, size: 14.0 + increaseSize)!
    }
    
    static func normalFontWithPlusSize(increaseSize:CGFloat = 0.0) ->UIFont{
        return UIFont(name: DEFAULT_FONT_NAME_LIGHT, size: 14.0 + increaseSize)!
    }
    
    static func defulatButtonColor() ->UIColor{
        return UIColor(displayP3Red:0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.000)
    }
    
    static func colorRootView() ->UIColor{
        return UIColor(displayP3Red:248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1.000)
    }
    
    static func tabBarColor() ->UIColor{
        return UIColor(displayP3Red:245.0/255.0, green: 211.0/255.0, blue: 40.0/255.0, alpha: 1.000)
    }
    
    static func sormaeiColor() ->UIColor{
        return UIColor(displayP3Red:52.0/255.0, green: 74.0/255.0, blue: 99.0/255.0, alpha: 1.000)
    }
    
    static func germezColor() ->UIColor{
        return UIColor(displayP3Red:230.0/255.0, green: 97.0/255.0, blue: 84.0/255.0, alpha: 1.000)
    }
    
    static func badgePriceColor() ->UIColor{
        return UIColor(displayP3Red:255.0/255.0, green: 143.0/255.0, blue: 35.0/255.0, alpha: 1.000)
    }
    
    static func badgeTimmerColor() ->UIColor{
        return UIColor(displayP3Red:255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.000)
    }
    
    static func getAutoAlignment() ->NSTextAlignment
    {
        let currentLanguage = Localize.currentLanguage()
        if(currentLanguage == "fa" || currentLanguage == "ar"){
            return .right
        }else{
            return .left
        }
    }
}

enum GaraunteeType:Int {
    case none = 0
    case with = 1
    case both = 2
}
