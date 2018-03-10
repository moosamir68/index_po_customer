//
//  UserDefault.swift
//  Moosa Mir
//
//  Created by iOSDeveloper on 7/12/17.
//  Copyright © 2017 Artiscovery. All rights reserved.
//

let KEY_ACCOUNT = "ACCOUNT_KEY"
let KEY_LANGUAGES = "LANGUAGES_KEY"
let KEY_LANGUAGE = "LANGUAGE_KEY"
let KEY_CATEGORIES = "CATEGORIES_KEY"
let KEY_COLORS = "COLORS_KEY"
let KEY_TIME_OUTS = "TIME_OUTS_KEY"
let KEY_NOTIFICATION_TOKEN = "NOTIFICATION_TOKEN_KEY"
let KEY_SUCCESSFULY_SEND_NOTIFICATION_TOKEN = "SUCCESSFULY_SEND_NOTIFICATION_TOKEN_KEY"

import UIKit

class UserDefault: NSObject {
    
    func saveUser(user:Account?) -> Bool{
        if user != nil{
            let userDefaults = UserDefaults.standard
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: user!)
            userDefaults.set(encodedData, forKey: KEY_ACCOUNT)
            userDefaults.synchronize()
            return true
        }else{
            return false
        }
    }
    
    func getUser() ->Account?{
        let userDefaults = UserDefaults.standard
        let decoded:Data?  = userDefaults.object(forKey: KEY_ACCOUNT) as? Data
        if decoded == nil{
            return nil
        }
        let account:Account? = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as? Account
        if account != nil{
            return account
        }else{
            return nil
        }
    }
    
    func userLogOut() ->Bool{
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: KEY_ACCOUNT)
        userDefaults.removeObject(forKey: KEY_SUCCESSFULY_SEND_NOTIFICATION_TOKEN)
        userDefaults.synchronize()
        return true
    }
    
    //MARK:- cache Language
    func saveLanguages(languagesArray:NSArray?) -> Bool{
        if languagesArray != nil{
            let userDefaults = UserDefaults.standard
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: languagesArray!)
            userDefaults.set(encodedData, forKey: KEY_LANGUAGES)
            userDefaults.synchronize()
            return true
        }else{
            return false
        }
    }
    
    func getLanguages() -> NSArray?{
        let userDefaults = UserDefaults.standard
        let decoded:Data?  = userDefaults.object(forKey: KEY_LANGUAGES) as? Data
        if decoded == nil{
            return nil
        }
        let languagesArray:NSArray? = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as? NSArray
        if languagesArray != nil{
            return languagesArray
        }else{
            return nil
        }
    }
    
    //MARK:- language
    func isSetLanguage() ->Bool{
        let userDefaults = UserDefaults.standard
        let isSetLanguage:Bool = (userDefaults.object(forKey: KEY_LANGUAGE) != nil)
        return isSetLanguage
    }
    
    func setLanguage(){
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: KEY_LANGUAGE)
        userDefaults.synchronize()
    }
    
    //MARK:- colors
    func saveColors(colors:[Color]?){
        if colors != nil{
            let userDefaults = UserDefaults.standard
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: colors!)
            userDefaults.set(encodedData, forKey: KEY_COLORS)
            userDefaults.synchronize()
        }
    }
    
    func getColors() ->[Color]?{
        let userDefaults = UserDefaults.standard
        let decoded:Data?  = userDefaults.object(forKey: KEY_COLORS) as? Data
        if decoded == nil{
            return nil
        }
        let colors:[Color]? = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as? [Color]
        if colors != nil{
            return colors
        }else{
            return nil
        }
    }
    
    //MARK:- notification token
    func saveNotificationToken(token:String){
        let userDefaults = UserDefaults.standard
        userDefaults.set(token, forKey: KEY_NOTIFICATION_TOKEN)
        userDefaults.synchronize()
    }
    
    func getNotificationToken() ->String?{
        let userDefaults = UserDefaults.standard
        let token:String? = userDefaults.object(forKey: KEY_NOTIFICATION_TOKEN) as? String
        if token == nil{
            return nil
        }
        
        return token
    }
    
    func sendSuccfullyNotificationToken(){
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: KEY_SUCCESSFULY_SEND_NOTIFICATION_TOKEN)
        userDefaults.synchronize()
    }
    
    func getSendSuccesfullyNotificationToken() ->Bool{
        let userDefaults = UserDefaults.standard
        let isTokenSaved = userDefaults.bool(forKey: KEY_SUCCESSFULY_SEND_NOTIFICATION_TOKEN)
        return isTokenSaved
    }
}
