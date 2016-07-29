////
////  UserController.swift
////  parishfind-ios
////
////  Created by Ayra Panganiban on 11/11/15.
////  Copyright © 2015 sourcepad. All rights reserved.
////
//
//import UIKit
//import Alamofire
//
//private var singleton: UserController?
//
//class UserController: NSObject {
//    var delegate: AnyObject?
//    var activeUser: UserDM?
//    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//    
//    //MARK: - Private methods
//    private class func getInstance() -> UserController {
//        if singleton == nil {
//            return UserController()
//        }
//        return singleton!
//    }
//    
//    //MARK: - Public class methods
//    // Sign up social network
//    class func signUpSocial(user: UserDM, delegate: AnyObject) {
//        let controller = self.getInstance()
//        controller.delegate = delegate
//        controller.signUpSocial(user)
//    }
//
//    //MARK: - Request methods
//    // Sign up/sign in user via social network
//    private func signUpSocial(user: UserDM) {
//        
//        let params = [
//            "user[name]": user.name!,
//            "user[email]": user.email!,
//            "user[facebook_id]": user.facebook_id!,
//        ]
//        
//        // Show network indicator
//        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
//        
//        let manager = Alamofire.Manager.sharedInstance
//        manager.request(.POST, Constants.API.domain + Constants.API.domain, parameters: params, encoding: .URL)
//            .responseJSON(options: NSJSONReadingOptions.AllowFragments, completionHandler: { (request, response, result) -> Void in
//                print("\(request)\n\(params)")
//                
//                switch result {
//                case .Success(let data):
//                    self.delegate!.userController!(self, didFinishSignUpSocialWithResponse: data, hasEmail:(user.email! != ""))
//                    
//                case .Failure(_, let error as NSError):
//                    self.delegate!.userController!(self, didFailSignUpSocialWithError: error)
//                    
//                default: ()
//                }
//                // Hide network indicator
//                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//            })
//    }
//
////MARK: - Delegate
//    protocol UserControllerDelegate: class {
//    // Sign Up Social
//    optional func userController(controller: UserController, didFinishSignUpSocialWithResponse response:AnyObject, hasEmail:Bool)
//    optional func userController(controller: UserController, didFailSignUpSocialWithError error:NSError)
//}
