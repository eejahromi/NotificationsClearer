//
//  AppDelegate.swift
//  ClearNotificationsDemo
//
//  Created by Ehsan Jahromi on 12/26/16.
//  Copyright © 2016 Ehsan Jahromi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
        let tabbarController = self.window?.rootViewController as? UITabBarController
        let viewControllers: [UIViewController] = (tabbarController?.viewControllers)!
        var badgeCount: Int = 0
        for viewController in viewControllers {
            if viewController.tabBarItem.badgeValue == nil {
                continue
            }
            badgeCount += Int(viewController.tabBarItem.badgeValue!)!
        }
        UIApplication.shared.applicationIconBadgeNumber = badgeCount
    }


    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

