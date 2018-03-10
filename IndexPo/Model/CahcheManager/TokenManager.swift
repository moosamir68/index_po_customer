//
//  TokenManager.swift
//  Moosa Mir
//
//  Created by iOSDeveloper on 7/12/17.
//  Copyright © 2017 Artiscovery. All rights reserved.
//
let KEY_TOKEN = "TOKEN_KEY"

import UIKit
import KeychainSwift

class TokenManager: NSObject {

    func saveToken(token:String?) ->Bool{
        let keychain = KeychainSwift();
        let sucess = keychain.set(token!, forKey: KEY_TOKEN);
        return sucess;
    }
    
    func getToken() ->String?{
        let keychain = KeychainSwift();
        let token:String? = keychain.get(KEY_TOKEN);
        if(token != nil){
            print("Token = %@", token!)
        }
        return token;
    }
    
    func removeToken() -> Bool{
        let keychain = KeychainSwift();
        let sucess = keychain.delete(KEY_TOKEN);
        return sucess;
    }
}
