//
//  Transition.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/3/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit
import MMPersianDatePicker
import MMAlert

class Transition: NSObject {
    var interactiveTransitionCustom:UIPercentDrivenInteractiveTransition?
    var navigationController:MainNavigationController?
    var animator:UIViewPropertyAnimator?
    
    override init() {
        super.init()
    }
    
    init(navigationController:MainNavigationController?){
        super.init()
        self.navigationController = navigationController
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.delegate = self
        self.navigationController?.transitioningDelegate = self
//        self.gestureSetForRootController()
    }
    
    //MARK:- gesture set
//    func gestureSetForPushController(toController:UIViewController?, fromController:UIViewController?){
//        if((toController?.isKind(of: ASListSelectViewController.classForCoder()))!){
//            let screenPanGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesturePushRight(gesture:)))
//            toController?.view.addGestureRecognizer(screenPanGesture)
//        }else if(((toController?.isKind(of: ASArtViewController.classForCoder()))!) && ((fromController?.isKind(of: ASAccountViewController.classForCoder()))!)){
//            //            let screenPanGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesturePushRightAndBottom(gesture:)))
//            //            toController?.view.addGestureRecognizer(screenPanGesture)
//        }
//    }
    
//    func gestureSetForRootController(){
//        if((self.navigationController?.rootViewController?.isKind(of: ASSearchFilterCollectionViewController.classForCoder()))! || (self.navigationController?.rootViewController?.isKind(of: ASCameraViewController.classForCoder()))! || (self.navigationController?.rootViewController?.isKind(of: ASUploadArtStepOneViewController.classForCoder()))! || (self.navigationController?.rootViewController?.isKind(of: ASLoginViewController.classForCoder()))! || (self.navigationController?.rootViewController?.isKind(of: ASRegisterViewController.classForCoder()))! || (self.navigationController?.rootViewController?.isKind(of: ASNewPostViewController.classForCoder()))! || (self.navigationController?.rootViewController?.isKind(of: ASCartTableViewController.classForCoder()))!){
//            let screenPanGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureModal(gesture:)))
//            self.navigationController?.view.addGestureRecognizer(screenPanGesture)
//        }
//    }
    
    //MARK:- pan gesture
    @objc private func panGestureModal(gesture:UIPanGestureRecognizer){
        var progress = gesture.translation(in: self.navigationController?.view).y
        progress = progress  / (self.navigationController?.view.bounds.size.height)!
        progress = min(max(0.0, progress), 1.0)
        switch gesture.state {
        case .began:
            self.interactiveTransitionCustom = UIPercentDrivenInteractiveTransition()
            self.navigationController?.dismiss(animated: true, completion: nil)
        case .changed:
            self.interactiveTransitionCustom?.update(progress)
        case .cancelled,.ended:
            if(progress > 0.4){
                self.interactiveTransitionCustom?.finish()
            }else{
                self.interactiveTransitionCustom?.cancel()
            }
            self.interactiveTransitionCustom = nil
        default:
            self.interactiveTransitionCustom = UIPercentDrivenInteractiveTransition()
            self.navigationController?.dismiss(animated: true, completion: nil)
            self.interactiveTransitionCustom = nil
        }
    }
    
    @objc private func panGesturePushRight(gesture:UIPanGestureRecognizer){
        var progress = gesture.translation(in: self.navigationController?.view).x
        progress = progress  / (self.navigationController?.view.bounds.size.width)!
        progress = min(max(0.0, progress), 1.0)
        switch gesture.state {
        case .began:
            self.interactiveTransitionCustom = UIPercentDrivenInteractiveTransition()
            self.navigationController?.rootViewController?.navigationController?.popViewController(animated: true)
        case .changed:
            self.interactiveTransitionCustom?.update(progress)
        case .cancelled,.ended:
            if(progress > 0.4){
                self.interactiveTransitionCustom?.finish()
            }else{
                self.interactiveTransitionCustom?.cancel()
            }
            self.interactiveTransitionCustom = nil
        default:
            self.interactiveTransitionCustom = UIPercentDrivenInteractiveTransition()
            self.navigationController?.rootViewController?.navigationController?.popViewController(animated: true)
            self.interactiveTransitionCustom = nil
        }
    }
    
    @objc private func panGesturePushRightAndBottom(gesture:UIPanGestureRecognizer){
        var progressX = gesture.translation(in: self.navigationController?.view).x
        var progressY = gesture.translation(in: self.navigationController?.view).y
        
        progressX = progressX  / (self.navigationController?.view.bounds.size.width)!
        progressX = min(max(0.0, progressX), 1.0)
        
        progressY = progressY  / (self.navigationController?.view.bounds.size.height)!
        progressY = min(max(0.0, progressY), 1.0)
        
        let progress = max(progressY, progressX)
        
        switch gesture.state {
        case .began:
            self.interactiveTransitionCustom = UIPercentDrivenInteractiveTransition()
            self.navigationController?.rootViewController?.navigationController?.popViewController(animated: true)
        case .changed:
            self.interactiveTransitionCustom?.update(progress)
        case .cancelled,.ended:
            if(progress > 0.4){
                self.interactiveTransitionCustom?.finish()
            }else{
                self.interactiveTransitionCustom?.update(0)
                self.interactiveTransitionCustom?.cancel()
            }
            self.interactiveTransitionCustom = nil
        default:
            self.interactiveTransitionCustom = UIPercentDrivenInteractiveTransition()
            self.navigationController?.rootViewController?.navigationController?.popViewController(animated: true)
            self.interactiveTransitionCustom = nil
        }
    }
}

extension Transition:UINavigationControllerDelegate{
    //MARK:- navigationcontroller delegate
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        if(operation == .push){
            //set gesture for view tovc
//            self.gestureSetForPushController(toController: toVC, fromController: fromVC)
        }
//        if fromVC.isKind(of: UITableViewController.classForCoder()) && toVC.isKind(of: ASListSelectViewController.classForCoder()) {
//            return ASAnimationFromTableViewControllerToListSelected()
//        }else if fromVC.isKind(of: ASListSelectViewController.classForCoder()) && toVC.isKind(of: UITableViewController.classForCoder()) {
//            return ASAnimationFromListSelectToTableViewController()
//        }else if fromVC.isKind(of: ASAccountViewController.classForCoder()) && toVC.isKind(of: ASArtViewController.classForCoder()) && !(toVC as! ASArtViewController).isShowUser {
//            //            return ASAnimationFromArtCollectionViewToArtController()
//            return nil
//        }else if fromVC.isKind(of: ASArtViewController.classForCoder()) && toVC.isKind(of: ASAccountViewController.classForCoder()) && !(fromVC as! ASArtViewController).isShowUser  && !(fromVC as! ASArtViewController).isDeleteThisArt{
//            //            return ASAnimationFromArtControllerToArtCollectionView()
//            return nil
//        }
        
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) ->
        UIViewControllerInteractiveTransitioning? {
//            if(self.navigationController?.rootViewController?.isKind(of: ASCameraViewController.classForCoder()))!{
//                return UIPercentDrivenInteractiveTransition()
//            }else if(animationController.isKind(of: ASAnimationFromListSelectToTableViewController.classForCoder())){
//                return self.interactiveTransitionCustom
//            }else if(animationController.isKind(of: ASAnimationFromArtControllerToArtCollectionView.classForCoder())){
//                return self.interactiveTransitionCustom
//            }else{
//                return nil
//            }
            return nil
    }
}

extension Transition:UIGestureRecognizerDelegate{
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension Transition:UIViewControllerTransitioningDelegate{
    //MARK:- transition Delegate
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) ->
        UIViewControllerInteractiveTransitioning? {
            print("interaction dismiss")
            return self.interactiveTransitionCustom
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("animation dismiss")
        if(dismissed.isKind(of: MMAlertSheetViewController.classForCoder())){
            return AnimationFromAlertSheetControllerToController()
        }else if(dismissed.isKind(of: MMAlertAlertViewController.classForCoder())){
            return AnimationFromAlertAlertControllerToFromController()
        }else if(dismissed.isKind(of: MMAlertAlertJustAlertViewController.classForCoder())){
            return AnimationFromAlertJustAlertControllerToFromController()
        }else if(dismissed.isKind(of: MMAlertSheetMultipleSelectViewController.classForCoder())){
            return AnimationFromAlertSheetMultipleSelectControllerToController()
        }else if(dismissed.isKind(of: MMCalenderViewController.classForCoder())){
            return AnimationFromCalenderControllerToController()
        }
        return nil
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if(presented.isKind(of: MMAlertSheetViewController.classForCoder())){
            return AnimationFromControllerToAlertSheetController()
        }else if(presented.isKind(of: MMAlertAlertViewController.classForCoder())){
            return AnimationFromControllerToAlertAlertController()
        }else if(presented.isKind(of: MMAlertAlertJustAlertViewController.classForCoder())){
            return AnimationFromControllerToAlertJustAlertController()
        }else if(presented.isKind(of: MMAlertSheetMultipleSelectViewController.classForCoder())){
            return AnimationFromControllerToAlertSheetMultipleSelectController()
        }else if(presented.isKind(of: MMCalenderViewController.classForCoder())){
            return AnimationFromControllerToCalenderController()
        }
        
        return nil
    }
}

extension Transition: UIViewControllerInteractiveTransitioning {
    
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
        // Create our helper object to manage the transition for the given transitionContext.
        //        transitionDriver = AssetTransitionDriver(operation: operation, context: transitionContext, panGestureRecognizer: panGestureRecognizer)
        self.animator = UIViewPropertyAnimator()
    }
    
    var wantsInteractiveStart: Bool {
        
        // Determines whether the transition begins in an interactive state
        return true
    }
}

extension Transition: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {}
    
    func animationEnded(_ transitionCompleted: Bool) {
        // Clean up our helper object and any additional state
        animator = nil
        //        initiallyInteractive = false
        //        operation = .none
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // The transition driver (helper object), creates the UIViewPropertyAnimator (transitionAnimator)
        // to be used for this transition. It must live the lifetime of the transitionContext.
        //        return (transitionDriver?.transitionAnimator)!
        return self.animator!
    }
}
