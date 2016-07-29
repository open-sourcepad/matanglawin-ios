//
//  AppDelegate.swift
//  LaF
//
//  Created by Rodel Medina on 7/29/16.
//  Copyright © 2016 Rodel Medina. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var currentUser: UserDM = UserDM();
    
    lazy var homeController: HomeViewController = {
        var ctrl = HomeViewController()
        ctrl.title = "Feeds"
        return ctrl
    }()

    lazy var homeNavigation: UINavigationController = {
        var ctrl = UINavigationController()
        ctrl.title = "Feeds"
        return ctrl
    }()


    lazy var mainTabBar: UITabBarController = {
        var ctrl = UITabBarController()
        ctrl.tabBar.tintColor = Constants.Colors.colorThemeLightGray;
        ctrl.tabBar.barTintColor = Constants.Colors.colorTheme;
        ctrl.tabBar.hidden = true;
        return ctrl
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        homeNavigation.viewControllers    = [homeController]
        mainTabBar.viewControllers = [homeNavigation]

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        if let window = window {
            window.rootViewController = mainTabBar
            window.makeKeyAndVisible()
        }

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }


}