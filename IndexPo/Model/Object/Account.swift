//
//  Account.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/4/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import CoreLocation
import UIKit

class Account: BaseObject, NSCoding {
    var phoneNumber:String = ""
    var firstName:String? = ""
    var lastName:String? = ""
    
    var accountID:String? = ""
    var telegram:String? = ""
    var photoURL:String? = ""
    var shopName:String? = ""
    var shopPhone:String? = ""
    var shopAddress:String? = ""
    var location:CLLocationCoordinate2D? = CLLocationCoordinate2D()
    var licensePhoto:String?
    var subCategories:[String]? = [String]()
    var products:[String]? = [String]()
    var buyRequests:[String]? = [String]()
    var categoryID:String? = ""
    var fcmID:String? = ""
    var sentInfo:Bool = false
    
    var licenseImage:UIImage?
    var image:UIImage?
    
    init(dictionary:NSDictionary?) {
        
        if (dictionary!["mobile"]) != nil {
            if let phoneNumber:String = dictionary!.object(forKey: "mobile") as? String{
                self.phoneNumber = phoneNumber
            }
        }
        
        if (dictionary!["name"]) != nil {
            if let firstName:String = dictionary!.object(forKey: "name") as? String{
                self.firstName = firstName
            }
        }
        
        if (dictionary!["family"]) != nil {
            if let lastName:String = dictionary!.object(forKey: "family") as? String{
                self.lastName = lastName
            }
        }
        
        if (dictionary!["id"]) != nil {
            if let accountID:String = dictionary!.object(forKey: "id") as? String{
                self.accountID = accountID
            }
        }
        
        if (dictionary!["telegram"]) != nil {
            if let telegram:String = dictionary!.object(forKey: "telegram") as? String{
                self.telegram = telegram
            }
        }
        
        if (dictionary!["photoURL"]) != nil {
            if let photoURL:String = dictionary!.object(forKey: "photoURL") as? String{
                self.photoURL = photoURL
            }
        }
        
        if (dictionary!["fcmID"]) != nil {
            if let fcmID:String = dictionary!.object(forKey: "fcmID") as? String{
                self.fcmID = fcmID
            }
        }
        
        if (dictionary!["sentInfo"]) != nil {
            if let sentInfo:Bool = dictionary!.object(forKey: "sentInfo") as? Bool{
                self.sentInfo = sentInfo
            }
        }
        
        if (dictionary!["location"]) != nil {
            if let location:[Double] = dictionary!.object(forKey: "location") as? [Double]{
                self.location = CLLocationCoordinate2D(latitude: location.first!, longitude: location.last!)
            }
        }
        
        if (dictionary!["shopAddress"]) != nil {
            if let shopAddress:String = dictionary!.object(forKey: "shopAddress") as? String{
                self.shopAddress = shopAddress
            }
        }
        
        if (dictionary!["shopPhone"]) != nil {
            if let shopPhone:String = dictionary!.object(forKey: "shopPhone") as? String{
                self.shopPhone = shopPhone
            }
        }
        
        if (dictionary!["shopName"]) != nil {
            if let shopName:String = dictionary!.object(forKey: "shopName") as? String{
                self.shopName = shopName
            }
        }
        
        if (dictionary!["licensePhoto"]) != nil {
            if let licensePhoto:String = dictionary!.object(forKey: "licensePhoto") as? String{
                self.licensePhoto = licensePhoto
            }
        }
        
        if (dictionary!["categoryID"]) != nil {
            if let categoryID:String = dictionary!.object(forKey: "categoryID") as? String{
                self.categoryID = categoryID
            }
        }
        
        if (dictionary!["subCategories"]) != nil {
            if let subCategories:[String] = dictionary!.object(forKey: "subCategories") as? [String]{
                self.subCategories = subCategories
            }
        }
        
        if (dictionary!["buyRequests"]) != nil {
            if let buyRequests:[String] = dictionary!.object(forKey: "buyRequests") as? [String]{
                self.buyRequests = buyRequests
            }
        }
        
        if (dictionary!["products"]) != nil {
            if let products:[String] = dictionary!.object(forKey: "products") as? [String]{
                self.products = products
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        if((aDecoder.decodeObject(forKey: "accountID") as? String) != nil){
            self.accountID = aDecoder.decodeObject(forKey: "accountID") as? String
        }
        
        if((aDecoder.decodeObject(forKey: "firstName") as? String) != nil){
            self.firstName = aDecoder.decodeObject(forKey: "firstName") as? String
        }
        
        if((aDecoder.decodeObject(forKey: "lastName") as? String) != nil){
            self.lastName = aDecoder.decodeObject(forKey: "lastName") as? String
        }
        
        if((aDecoder.decodeObject(forKey: "phoneNumber") as? String) != nil){
            self.phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as! String
        }
        
        if((aDecoder.decodeObject(forKey: "telegram") as? String) != nil){
            self.telegram = aDecoder.decodeObject(forKey: "telegram") as? String
        }
        
        if((aDecoder.decodeObject(forKey: "photoURL") as? String) != nil){
            self.photoURL = aDecoder.decodeObject(forKey: "photoURL") as? String
        }
        
        if((aDecoder.decodeObject(forKey: "fcmID") as? String) != nil){
            self.fcmID = aDecoder.decodeObject(forKey: "fcmID") as? String
        }
        
        if(aDecoder.decodeBool(forKey: "sentInfo")){
            self.sentInfo = aDecoder.decodeBool(forKey: "sentInfo")
        }
        
        if((aDecoder.decodeObject(forKey: "shopName") as? String) != nil){
            self.shopName = aDecoder.decodeObject(forKey: "shopName") as? String
        }
        
        if((aDecoder.decodeObject(forKey: "shopPhone") as? String) != nil){
            self.shopPhone = aDecoder.decodeObject(forKey: "shopPhone") as? String
        }
        
        if((aDecoder.decodeObject(forKey: "shopAddress") as? String) != nil){
            self.shopAddress = aDecoder.decodeObject(forKey: "shopAddress") as? String
        }
        
        if((aDecoder.decodeObject(forKey: "licensePhoto") as? String) != nil){
            self.licensePhoto = aDecoder.decodeObject(forKey: "licensePhoto") as? String
        }
        
        if((aDecoder.decodeObject(forKey: "categoryID") as? String) != nil){
            self.categoryID = aDecoder.decodeObject(forKey: "categoryID") as? String
        }
        
        if((aDecoder.decodeObject(forKey: "locationLat") as? Double) != nil){
            self.location?.latitude = aDecoder.decodeObject(forKey: "locationLat") as! Double
        }
        
        if((aDecoder.decodeObject(forKey: "locationLon") as? Double) != nil){
            self.location?.longitude = aDecoder.decodeObject(forKey: "locationLon") as! Double
        }
        
        if((aDecoder.decodeObject(forKey: "buyRequests") as? [String]) != nil){
            self.buyRequests = aDecoder.decodeObject(forKey: "buyRequests") as? [String]
        }
        
        if((aDecoder.decodeObject(forKey: "products") as? [String]) != nil){
            self.products = aDecoder.decodeObject(forKey: "products") as? [String]
        }
        
        if((aDecoder.decodeObject(forKey: "subCategories") as? [String]) != nil){
            self.subCategories = aDecoder.decodeObject(forKey: "subCategories") as? [String]
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.accountID, forKey: "accountID")
        aCoder.encode(self.firstName, forKey: "firstName")
        aCoder.encode(self.lastName, forKey: "lastName")
        aCoder.encode(self.phoneNumber, forKey: "phoneNumber")
        aCoder.encode(self.telegram, forKey: "telegram")
        aCoder.encode(self.photoURL, forKey: "photoURL")
        aCoder.encode(self.fcmID, forKey: "fcmID")
        aCoder.encode(self.sentInfo, forKey: "sentInfo")
        
        aCoder.encode(self.shopName, forKey: "shopName")
        aCoder.encode(self.shopPhone, forKey: "shopPhone")
        aCoder.encode(self.shopAddress, forKey: "shopAddress")
        aCoder.encode(self.licensePhoto, forKey: "licensePhoto")
        aCoder.encode(self.categoryID, forKey: "categoryID")
        aCoder.encode(self.location?.latitude, forKey: "locationLat")
        aCoder.encode(self.location?.longitude, forKey: "locationLon")
        aCoder.encode(self.buyRequests, forKey: "buyRequests")
        aCoder.encode(self.products, forKey: "products")
        aCoder.encode(self.subCategories, forKey: "subCategories")
    }
    
    override init() {
        super.init()
    }
}
