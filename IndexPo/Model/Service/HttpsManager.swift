//
//  HttpsManager.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/4/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import MMRequest

class HttpManager: NSObject {
    static let sharedInstanse:HttpManager = HttpManager()
    
    func createAPIRequestWithAccessToken(accessToken:NSString?) ->MMRequest
    {
        let request = MMRequest()
        
        //Esentials
        request.baseURL = "88.99.185.24"
        //Beta
//        request.baseURL = "192.168.0.51:8000"
        request.protocoll = "http"
        
        if accessToken != nil{
            request.headers["Authorization"] = String(format: "token %@", accessToken!)
        }
        
        request.headers["User-Agent"] = MMUserAgent.userAgent()
        
        return request
    }
}
