//
//  Service.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/4/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit
import CoreLocation
import Localize_Swift
import Toaster
import MMRequest

class Service: NSObject {
    
    static let sharedInstanse:Service = Service()
    
    let locationManager = CLLocationManager()
    var lastUpdatedLocation: CLLocationCoordinate2D?
    let tokenManager = TokenManager()
    
    //property
    let httpRequest:HttpManager = HttpManager.sharedInstanse
    
    //MARK:- lgout
    func logoutUser() ->Bool{
        let userDetaults = UserDefault()
        _ = userDetaults.userLogOut()
        
        return true
    }
    
    //MARK:- login and info user
    func sendPhoneNumber(phoneNumber:String = "", callback:@escaping (_ error:MMError?) ->Void){
        let request = httpRequest.createAPIRequestWithAccessToken(accessToken: nil)
        
        request.path = "seller/submit_mobile/"
        request.method = "POST"
        request.contentType = "application/json"
        (request.content as! NSMutableDictionary).setValue(phoneNumber, forKey: "mobile")
        
        request.send { (response, error) in
            if error != nil{
                callback(error)
                return
            }
            
            if response?.statusCode != 201{
                callback(MMError(response: response))
                return
            }
            
            let data:NSDictionary? = response?.content as? NSDictionary
            if (data?["confirmationCode"]) != nil {
                if let confirmationCode:Int = data?["confirmationCode"] as? Int{
                    DispatchQueue.main.async {
                        let toast = Toast(text: String(format:"%@ = %d", "Contormation Code", confirmationCode))
                        print(String(format:"%@ = %d", "Contormation Code", confirmationCode))
                        toast.show()
                    }
                    
                    callback(nil)
                    return
                }
                callback(MMError(title: "Error".localized()))
                return
            }
            callback(MMError(title: "Error".localized()))
            return
        }
    }
    
    func sendVerificationCode(verificationCode:String = "", phoneNumber:String = "", callback:@escaping (_ error:MMError?) ->Void){
        let request = httpRequest.createAPIRequestWithAccessToken(accessToken: nil)
        
        request.path = "seller/submit_confirmation_code/"
        request.method = "POST"
        request.contentType = "application/json"
        (request.content as! NSMutableDictionary).setValue(phoneNumber, forKey: "mobile")
        (request.content as! NSMutableDictionary).setValue(Int(verificationCode), forKey: "confirmationCode")
        
        request.send { (response, error) in
            if error != nil{
                callback(error)
                return
            }
            
            if response?.statusCode != 200{
                callback(MMError(response: response))
                return
            }
            
            let data:NSDictionary? = response?.content as? NSDictionary
            if (data?["accessToken"]) != nil {
                if let accessToken:String = data?["accessToken"] as? String{
                    print(String(format:"%@ = %@", "accessToken", accessToken))
                    
                    let tokenManager = TokenManager()
                    _ = tokenManager.saveToken(token: accessToken)
                    callback(nil)
                    return
                }
                callback(MMError(title: "Error".localized()))
                return
            }
            callback(MMError(title: "Error".localized()))
            return
        }
    }
    
    func getUserInfo(withReloadDataFromServer reloadData:Bool = true, callback:@escaping (_ account:Account? ,_ error:MMError?) ->Void){
        
        let userDefaults = UserDefault()
        let account = userDefaults.getUser()
        if(account != nil){
            callback(account, nil)
        }
        
        if(reloadData || account == nil){
            let token = TokenManager().getToken()
            
            let request = httpRequest.createAPIRequestWithAccessToken(accessToken: token as NSString!)
            
            request.path = "seller/info/"
            request.method = "GET"
            
            request.send { (response, error) in
                if error != nil{
                    callback(nil, error)
                    return
                }
                
                if response?.statusCode != 200{
                    callback(nil, MMError(response: response))
                    return
                }
                
                let data:NSDictionary? = response?.content as? NSDictionary
                
                let account:Account? = Account(dictionary: data)
                if(account != nil){
                    _ = userDefaults.saveUser(user: account)
                    callback(account, nil)
                    return
                }
                
                callback(nil, MMError(title: "Error".localized()))
                return
            }
        }
    }
    
    //MARK:- register
    func registerUser(registerAccount:Account?, callback:@escaping (_ error:MMError?) ->Void){
        let token = TokenManager().getToken()
        
        let request = httpRequest.createAPIRequestWithAccessToken(accessToken: token as NSString!)
        
        request.path = "seller/register/"
        request.method = "POST"
        
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.contentType = "multipart/form-data; boundary=\(boundary)" as NSString
        
        let userDictionary:NSMutableDictionary? = NSMutableDictionary()
        userDictionary?.setValue(registerAccount?.firstName, forKey: "name")
        userDictionary?.setValue(registerAccount?.lastName, forKey: "family")
        userDictionary?.setValue(registerAccount?.telegram, forKey: "telegram")
        userDictionary?.setValue(registerAccount?.shopName, forKey: "shopName")
        userDictionary?.setValue(registerAccount?.shopPhone, forKey: "shopPhone")
        userDictionary?.setValue(registerAccount?.shopAddress, forKey: "shopAddress")
        if(registerAccount?.location != nil){
            userDictionary?.setValue([registerAccount?.location?.latitude, registerAccount?.location?.longitude], forKey: "location")
        }
        userDictionary?.setValue(registerAccount?.subCategories, forKey: "subCategories")
        userDictionary?.setValue(registerAccount?.categoryID, forKey: "categoryID")
        
        
        var imageUserData:NSData? = UIImageJPEGRepresentation((registerAccount?.image)!, 1)! as NSData
        var imageUserSize: Int = (imageUserData?.length)! / 1024
        print("size of image in KB: %f ", imageUserSize)
        while imageUserSize > 200 {
            imageUserData = UIImageJPEGRepresentation((registerAccount?.image)!, 0.6)! as NSData
            imageUserSize = (imageUserData?.length)! / 1024
            print("size of image in KB: %f ", imageUserSize)
        }
        
        var imageLicenseData:NSData? = UIImageJPEGRepresentation((registerAccount?.licenseImage)!, 1)! as NSData
        var imageLicenseSize: Int = (imageLicenseData?.length)! / 1024
        print("size of image in KB: %f ", imageLicenseSize)
        while imageLicenseSize > 200 {
            imageLicenseData = UIImageJPEGRepresentation((registerAccount?.licenseImage)!, 0.6)! as NSData
            imageLicenseSize = (imageLicenseData?.length)! / 1024
            print("size of image in KB: %f ", imageLicenseSize)
        }
        
        
        var body = Data()
        
        if(userDictionary != nil){
            let dataString:Data?
            do{
                dataString = try JSONSerialization.data(withJSONObject: userDictionary!, options: [])
            }catch{
                dataString = Data()
            }
            
            let userString = String(data: dataString!, encoding: String.Encoding.utf8)! as NSString
            let userKey = "user"
            
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(userKey)\"\r\n\r\n")
            body.append("\(userString)\r\n")
        }
        
        if(imageUserData != nil){
            let filename = "photo"
            let mimetype = "image/jpeg"
            let key = "photo"
            
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
            body.append("Content-Type: \(mimetype)\r\n\r\n")
            body.append(imageUserData! as Data)
            body.append("\r\n")
        }
        
        if(imageLicenseData != nil){
            let filename = "photo"
            let mimetype = "image/jpeg"
            let key = "licensePhoto"
            
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
            body.append("Content-Type: \(mimetype)\r\n\r\n")
            body.append(imageLicenseData! as Data)
            body.append("\r\n")
        }
        
        body.append("--\(boundary)--\r\n")
        request.body = body as NSData
        
        request.send { (response, error) in
            if error != nil{
                callback(error)
                return
            }
            
            if response?.statusCode != 201{
                callback(MMError(response: response))
                return
            }
            
            let user = UserDefault().getUser()
            user?.sentInfo = true
            _ = UserDefault().saveUser(user: user)
            
            callback(nil)
            return
        }
    }
    
    //MARK:- sepcial offer
    func getSpecialOffers(callback:@escaping (_ favorties:[SpecialOffer]?, _ error:MMError?) ->Void){
        let token = TokenManager().getToken()
        
        let request = httpRequest.createAPIRequestWithAccessToken(accessToken: token as NSString!)
        
        request.path = "specialOffer/mySpecialOffers/"
        request.method = "GET"
        
        request.send { (response, error) in
            if error != nil{
                callback(nil, error)
                return
            }
            
            if response?.statusCode != 200{
                callback(nil, MMError(response: response))
                return
            }
            
            let data:NSDictionary? = response?.content as? NSDictionary
            
            var specialOffers = [SpecialOffer]()
            
            if let array:NSArray = data!["specialOffers"] as? NSArray{
                for specialOfferDic in array {
                    let favorty = SpecialOffer(dictionary: specialOfferDic as! NSDictionary)
                    specialOffers.append(favorty)
                }
                
                callback(specialOffers, nil)
                return
            }
            
            callback(nil, nil)
            return
        }
    }
    
    //Mark:- cart
    func getCartItems(callback:@escaping (_ cartItems:[CartItem]?, _ error:MMError?) ->Void){
        let token = TokenManager().getToken()
        
        let request = httpRequest.createAPIRequestWithAccessToken(accessToken: token as NSString!)
        
        request.path = "seller/buyrequest/"
        request.method = "GET"
        
        request.send { (response, error) in
            var cartItems = [CartItem]()
            for index in 1...5{
                let cartItem = CartItem()
                cartItem.count = index
                cartItem.body = String(format: "Item Body %d", index)
                cartItem.message = String(format: "Item Message %d", index)
                cartItem.product.name = String(format: "product name from cart %d", index)
                cartItems.append(cartItem)
            }
            
            callback(cartItems, nil)
            return
            
            if error != nil{
                callback(nil, error)
                return
            }
            
            if response?.statusCode != 200{
                callback(nil, MMError(response: response))
                return
            }
            
            let data:NSDictionary? = response?.content as? NSDictionary
            
            var cartItems2 = [CartItem]()
            
            if let array:NSArray = data!["buyRequests"] as? NSArray{
                for cartItemDic in array {
                    let cartItem = CartItem(dictionary: cartItemDic as! NSDictionary)
                    cartItems.append(cartItem)
                }
                
                callback(cartItems, nil)
                return
            }
            
            callback(nil, nil)
            return
        }
    }
    
    func addToCart(product:Product, callback:@escaping (_ cartItem:CartItem?, _ error:MMError?) ->Void){
        let token = TokenManager().getToken()
        
        let request = httpRequest.createAPIRequestWithAccessToken(accessToken: token as NSString!)
        
        request.path = "specialOffer/mySpecialOffers/"
        request.method = "POST"
        request.contentType = "application/json"
        
        let content:NSMutableDictionary? = request.content as? NSMutableDictionary
        content?.setValue(product.productId, forKey:"message")
        content?.setValue("", forKey:"description")
        
        request.send { (response, error) in
            if error != nil{
                callback(nil, error)
                return
            }
            
            if response?.statusCode != 201{
                callback(nil, MMError(response: response))
                return
            }
            
            let data:NSDictionary? = response?.content as? NSDictionary
            
            let cartItem = CartItem(dictionary: data!)
            callback(cartItem, nil)
            return
        }
    }
    
    func removeFromCart(cartItem:CartItem, callback:@escaping (_ error:MMError?) ->Void){
        let token = TokenManager().getToken()
        
        let request = httpRequest.createAPIRequestWithAccessToken(accessToken: token as NSString!)
        
        request.path = String(format:"%@%@%@", "specialOffer/", cartItem.requestId, "/") as NSString
        request.method = "DELETE"
        
        request.send { (response, error) in
            if error != nil{
                callback(error)
                return
            }
            
            if response?.statusCode != 200{
                callback(MMError(response: response))
                return
            }
            
            callback(nil)
            return
        }
    }
    
    //MARK:- browse
    func getToolBarMenuBrowse(callback:@escaping (_ items:[MainToolBar]?, _ error:MMError?) ->Void){
        let token = TokenManager().getToken()
        
        let request = httpRequest.createAPIRequestWithAccessToken(accessToken: token as NSString!)
        
        request.baseURL = "www.mocky.io/v2"
        request.path = "5aa6a11e3100005c3be71720"
        request.method = "GET"
        
        request.send { (response, error) in
            
            if error != nil{
                callback(nil, error)
                return
            }
            
            if response?.statusCode != 200{
                callback(nil, MMError(response: response))
                return
            }
            
            var items = [MainToolBar]()
            if let array:NSArray = response?.content as? NSArray{
                for productDic in array {
                    let item = MainToolBar(dictionary: productDic as! NSDictionary)
                    items.append(item)
                }
                
                callback(items, nil)
                return
            }
            
            callback(nil, nil)
            return
        }
    }
    //MARK:- product
    func browseProducts(searchObject:SearchParameters, callback:@escaping (_ products:[Product]?, _ error:MMError?) ->Void){
        let token = TokenManager().getToken()
        
        let request = httpRequest.createAPIRequestWithAccessToken(accessToken: token as NSString!)
        
        request.path = "product/search/"
        request.method = "GET"
        
        request.send { (response, error) in
            
            if error != nil{
                callback(nil, error)
                return
            }
            
            if response?.statusCode != 200{
                callback(nil, MMError(response: response))
                return
            }
            
            var products = [Product]()
            let dic = response?.content as! NSDictionary
            if let array:NSArray = dic["products"] as? NSArray{
                for productDic in array {
                    let product = Product(dictionary: productDic as! NSDictionary)
                    products.append(product)
                }
                
                callback(products, nil)
                return
            }
            
            callback(nil, nil)
            return
        }
    }
    
    func getProduct(searchObject:SearchParameters, callback:@escaping (_ products:Product?, _ error:MMError?) ->Void){
        let token = TokenManager().getToken()
        
        let request = httpRequest.createAPIRequestWithAccessToken(accessToken: token as NSString!)
        
        request.path = "seller/product/"
        request.method = "GET"
        
        request.queryParams?.setValue(searchObject.categoryId, forKey: "subCategory")
        
        request.send { (response, error) in
            if error != nil{
                callback(nil, error)
                return
            }
            
            if response?.statusCode != 200{
                callback(nil, MMError(response: response))
                return
            }
            
            var products = [Product]()
            
            if let array:NSArray = response?.content as? NSArray{
                for productDic in array {
                    let product = Product(dictionary: productDic as! NSDictionary)
                    products.append(product)
                }
                
                callback(products.first, nil)
                return
            }
            
            callback(nil, nil)
            return
        }
    }
    
    //MARK:- get configuration
    //MARK:- get colors
    func getColors(reloadData:Bool = false, callback:@escaping (_ colors:[Color]?, _ error:MMError?) ->Void){
        
        let userDefaults = UserDefault()
        let colors = userDefaults.getColors()
        if(colors != nil){
            callback(colors, nil)
        }
        
        if(reloadData || colors == nil){
            
            let token = TokenManager().getToken()
            
            let request = httpRequest.createAPIRequestWithAccessToken(accessToken: token as NSString!)
            
            request.path = "product/color/"
            request.method = "GET"
            
            request.send { (response, error) in
                if error != nil{
                    callback(nil, error)
                    return
                }
                
                if response?.statusCode != 200{
                    callback(nil, MMError(response: response))
                    return
                }
                
                var colors:[Color]? = [Color]()
                if let array:NSArray = response?.content as? NSArray{
                    for colorDic in array {
                        let color = Color(dictionary: colorDic as! NSDictionary)
                        colors?.append(color)
                    }
                    
                    userDefaults.saveColors(colors: colors)
                    callback(colors, nil)
                    return
                }
                
                callback(nil, nil)
                return
            }
        }
    }
    
    //MARK:- notification
    func updateUserDeviceToken(deviceToken: String) {
        
        let userDefaults = UserDefault()
        userDefaults.saveNotificationToken(token: deviceToken)
    }
    
    func sendNotificationTokenToServer(){
        let userDefault = UserDefault()
        let account = userDefault.getUser()
        if(account != nil && (account?.sentInfo)!){
            let notificationToken = userDefault.getNotificationToken()
            if(notificationToken != nil){
                
                let token = TokenManager().getToken()
                let request = httpRequest.createAPIRequestWithAccessToken(accessToken: token as NSString!)
                
                request.path = "seller/info/"
                request.method = "PATCH"
                request.contentType = "application/json"
                
                let content:NSMutableDictionary? = request.content as? NSMutableDictionary
                content?.setValue(notificationToken, forKey:"fcmID")
                
                request.send { (response, error) in
                    if error != nil{
                        return
                    }
                    
                    if response?.statusCode != 200{
                        return
                    }
                    
                    userDefault.sendSuccfullyNotificationToken()
                    return
                }
            }
            
        }
    }
}

