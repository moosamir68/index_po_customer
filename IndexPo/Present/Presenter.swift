//
//  Presenter.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/3/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit
import Localize_Swift
import TOCropViewController
import MMPersianDatePicker
import MMAlert
import MMPhotoLibrary

class Presenter: NSObject, ProfileDelegate, SpecialOffersDelegate, LoadingDelegate, SumbitPhoneNumberDelegate, SubmitVerificationCodeDelegate, RegisterDelegate, ProductsDelegate, SpecialOfferDelegate, ProductDelegate, CartDelegate, HomeDelegate, BrowseDelegate{
    
    var mainTabBarController: MainTabBarController?
    var loadingViewController: LoadingViewController?
    
    override init() {
        super.init()
    }
    
    //MARK:- loading delegate
    func showHomeControllerFromLoading(fromController: LoadingViewController?) {
        self.mainTabBarController = self.mainTabBarViewControllerWithItems()
        fromController?.present(self.mainTabBarController!, animated: true, completion: {
            
        })
    }
    
    func showPhoneNumberController(fromController: LoadingViewController?) {
        let controller = self.createPhoneNumberController()
        controller.navigationTitle = "Phone Number".localized()
        controller.delegate = self
        
        let navigationController = MainNavigationController(rootController: controller, showNavigationBar: false)
        fromController?.present(navigationController, animated: true, completion: {
            
        })
    }
    
    func showGetUserInformationControllerFromLoading(fromController: LoadingViewController?) {
        let controller = self.createRegisterController()
        controller.navigationTitle = "Register".localized()
        controller.delegate = self
        let navigationController = MainNavigationController(rootController: controller, showNavigationBar: false)
        fromController?.present(navigationController, animated: true, completion: {
            
        })
    }
    
    //MARK:- Loading page controller
    func createLoadingViewController() ->LoadingViewController?{
        self.loadingViewController = LoadingViewController()
        self.loadingViewController?.delegate = self
        return self.loadingViewController
    }
    
    //MARK:- Main Tabbar view controller
    private func mainTabBarViewControllerWithItems() -> MainTabBarController {
        
        let tabBarVC = MainTabBarController()
        
        let arrayOfVC: [UIViewController]? = self.createViewControllersMainTabBar()
        
        tabBarVC.viewControllers = arrayOfVC
        tabBarVC.selectedIndex = DEFAULT_INDEX_TABBAR
        
        return tabBarVC
    }
    
    //MARK:- Main Tabbar view controller
    private func createViewControllersMainTabBar() -> [UIViewController]? {
        
        var arrayOfVC: [UIViewController] = []
        var tag = 0
        
        //Home
        let navigationVCHome = MainNavigationController(rootController: self.createHomeController())
        let tabbarItemHome = UITabBarItem(title: "Home".localized(), image: #imageLiteral(resourceName: "request_list"), selectedImage: nil)
        navigationVCHome.tabBarItem = tabbarItemHome
        arrayOfVC.append(navigationVCHome)
        
        //Browse
        tag = tag + 1
        let navigationVCBrowse = MainNavigationController(rootController: self.createBrowseController())
        let tabbarItemBrowse = UITabBarItem(title: "Browse".localized(), image: #imageLiteral(resourceName: "request_list"), selectedImage: nil)
        tabbarItemBrowse.tag = tag
        navigationVCBrowse.tabBarItem = tabbarItemBrowse
        arrayOfVC.append(navigationVCBrowse)
        
        //Cart
        tag = tag + 1
        let navigationVCCart = MainNavigationController(rootController: self.createCartController())
        let tabbarItemCart = UITabBarItem(title: "Cart".localized(), image: #imageLiteral(resourceName: "request_list"), selectedImage: nil)
        tabbarItemCart.tag = tag
        navigationVCCart.tabBarItem = tabbarItemCart
        arrayOfVC.append(navigationVCCart)
        
        //SpecialOffer
        tag = tag + 1
        let navigationVCFav = MainNavigationController(rootController: self.createSpecialOffersController())
        let tabbarItemFav = UITabBarItem(title: "Special Offer".localized(), image: #imageLiteral(resourceName: "request_list"), selectedImage: nil)
        navigationVCFav.tabBarItem = tabbarItemFav
        arrayOfVC.append(navigationVCFav)
        
        //Profile
        tag = tag + 1
        let navigationVCProfile = MainNavigationController(rootController: self.createProfileController())
        let tabbarItemProfile = UITabBarItem(title: "Profile".localized(), image: #imageLiteral(resourceName: "person"), selectedImage: nil)
        tabbarItemProfile.tag = tag
        navigationVCProfile.tabBarItem = tabbarItemProfile
        arrayOfVC.append(navigationVCProfile)
        
        return arrayOfVC
    }
    
    private func createHomeController() ->HomeViewController{
        let controller = HomeViewController()
        controller.navigationTitle = "Home".localized()
        controller.delegate = self
        return controller
    }
    
    private func createBrowseController() ->BrowseViewController{
        let controller = BrowseViewController()
        controller.navigationTitle = "Browse".localized()
        controller.delegate = self
        return controller
    }
    
    private func createCartController() ->CartViewController{
        let controller = CartViewController()
        controller.navigationTitle = "Cart".localized()
        controller.delegate = self
        return controller
    }
    
    
    private func createProfileController() ->ProfileViewController{
        let controller = ProfileViewController()
        controller.navigationTitle = "Profile".localized()
        controller.delegate = self
        return controller
    }
    
    private func createSpecialOffersController() ->SpecialOffersViewController{
        let controller = SpecialOffersViewController()
        controller.navigationTitle = "Special Offer".localized()
        controller.delegate = self
        return controller
    }
    
    private func createPhoneNumberController() ->SumbitPhoneNumberViewController{
        let controller = SumbitPhoneNumberViewController()
        return controller
    }
    
    private func createCodeVerificationController() ->SubmitVerificationCodeViewController{
        let controller = SubmitVerificationCodeViewController()
        return controller
    }
    
    private func createRegisterController() ->RegisterViewController{
        let controller = RegisterViewController()
        return controller
    }
    
    private func createProductsController() ->ProductsViewController{
        let controller = ProductsViewController()
        return controller
    }
    
    private func createAlertController() -> MMAlertSheetViewController{
        let controller = MMAlertSheetViewController()
        return controller
    }
    
    private func createCameraCaptureController() -> MMCameraCaptureViewController? {
        let controller = MMCameraCaptureViewController()
        return controller
    }
    
    private func createPhotosCollectionControllerInternal() -> MMPhotosViewController? {
        let controller = MMPhotosViewController()
        return controller
    }
    
    private func createAlertAlertController() -> MMAlertAlertViewController?{
        let controller  = MMAlertAlertViewController()
        return controller
    }
    
    private func createSpecialOfferController() -> SpecialOfferViewController?{
        let controller  = SpecialOfferViewController()
        return controller
    }
    
    private func createProductController() -> ProductViewController{
        let controller  = ProductViewController()
        return controller
    }
    
    private func createAlertMultipleSelectController() -> MMAlertSheetMultipleSelectViewController?{
        let controller  = MMAlertSheetMultipleSelectViewController()
        return controller
    }
    
    private func createCalenderController(withDefaultDate date:MMSimpleDate?) -> MMCalenderViewController?{
        let nowDate = Date()
        let calender = Calendar(identifier: .persian)
        let year = calender.component(.year, from: nowDate)
        let month = calender.component(.month, from: nowDate)
        let day = calender.component(.day, from: nowDate)
        
        let minDate = MMSimpleDate(year: year, month: month, day: day)
        let maxDate = MMSimpleDate(year: year + 25, month: 12, day: 31)
        var defaultDate = minDate.mutableCopy() as! MMSimpleDate
        if(date != nil){
            defaultDate = date!
        }
        
        let controller  = MMCalenderViewController(minDate: minDate, maxDate: maxDate, defaultDate: defaultDate)
        return controller
    }
    
    //MARK:- Submit Phone Number delegate
    func showSubmitVerificationCodeController(fromController: SumbitPhoneNumberViewController?, phoneNumber: String) {
        let controller = self.createCodeVerificationController()
        controller.delegate = self
        controller.phoneNumber = phoneNumber
        fromController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK:- submit verification code delegate
    func showHomeController(fromController: SubmitVerificationCodeViewController?) {
        fromController?.navigationController?.dismiss(animated: true, completion: {
            
        })
    }
    
    func showGetUserInformationController(fromController: SubmitVerificationCodeViewController?) {
        let controller = self.createRegisterController()
        controller.delegate = self
        fromController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func backToChangePhoneNumber(fromController: SubmitVerificationCodeViewController?) {
        fromController?.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- products delegate
    func showProduct(fromController: ProductsViewController?, withProduct product: Product?) {
        let controller = self.createProductController()
        controller.delegate = self
        controller.product = product
        fromController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK:- profile delegate
    func successFullySignOut() {
        self.mainTabBarController?.dismiss(animated: true, completion: {
            
        })
    }
    
    func showDialogLogout(fromController: ProfileViewController?, title: String?, content: String?) {
        let controller = self.createAlertAlertController()
        controller?.delegate = fromController
        controller?.titleHeader = title
        controller?.titleContent = content
        controller?.okTitle = "OK".localized()
        controller?.cancelTitle = "Cancel".localized()
        controller?.fontHeader = UIUtility.boldFontAutoWithPlusSize(increaseSize: 2.0)
        controller?.fontContent = UIUtility.normalFontAutoWithPlusSize(increaseSize: 1.0)
        controller?.fontButtons = UIUtility.normalFontAutoWithPlusSize()
        controller?.contentAlignment = UIUtility.getAutoAlignment()
        
        controller?.transitioningDelegate = fromController?.navigationController?.transitioningDelegate
        fromController?.navigationController?.present(controller!, animated: true, completion: {
            
        })
    }
    
    func dismissDialogLogout(controller: MMAlertAlertViewController?, complition: @escaping () -> Void) {
        controller?.dismiss(animated: true, completion: {
            complition()
        })
    }
    
    func showDialogLanguage(fromController: ProfileViewController?, elements:[MMAlert]) {
        let controller = self.createAlertController()
        controller.elements = elements
        controller.delegate = fromController

        controller.transitioningDelegate = fromController?.navigationController?.transitioningDelegate
        fromController?.navigationController?.present(controller, animated: true, completion: {
            
        })
    }
    
    func dismissDialogLanguage(fromController: MMAlertSheetViewController?, complition: @escaping () -> Void) {
        fromController?.dismiss(animated: true, completion: {
            complition()
        })
    }
    
    func succssfulyChangeLanguage() {
        self.mainTabBarController?.dismiss(animated: true, completion: {
            
        })
    }
    
    func successFullyChnageSubCategories() {
        self.mainTabBarController?.dismiss(animated: true, completion: {
            
        })
    }
    
    //MARK:- special offers delegate
    func showSpecialOfferFrom(fromController: SpecialOffersViewController?, specialOffer: SpecialOffer?) {
        let controller = self.createSpecialOfferController()
        
        controller?.delegate = self
        controller?.specialOffer = specialOffer
        
        fromController?.navigationController?.pushViewController(controller!, animated: true)
    }
    
    //MARK:- product delegate
    
    func dismissProductController(fromController: ProductViewController?) {
        fromController?.navigationController?.popViewController(animated: true)
    }
    
    func showDialogColor(fromController: ProductViewController?, elements: [MMAlert]) {
        
        let controller = self.createAlertController()
        controller.delegate = fromController
        controller.elements = elements
        
        controller.transitioningDelegate = fromController?.navigationController?.transitioningDelegate
        fromController?.navigationController?.present(controller, animated: true, completion: {
            
        })
    }
    
    func dismissDialogColor(fromController: MMAlertSheetViewController?) {
        fromController?.dismiss(animated: true, completion: {
            
        })
    }
    
    //MARK:- browse delegate
    func showProductFromBrowse(from: BrowseViewController, itemSelected item: Product) {
        let controller = self.createProductController()
        controller.delegate = self
        controller.product = item
        from.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK:- cart delegata
    func showProductFromCartController(from: CartViewController, item: Product) {
        let controller = self.createProductController()
        controller.delegate = self
        controller.product = item
        from.navigationController?.pushViewController(controller, animated: true)
    }
}
