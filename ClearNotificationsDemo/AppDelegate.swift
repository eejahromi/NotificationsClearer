//
//  AppDelegate.swift
//  ClearNotificationsDemo
//
//  Created by Ehsan Jahromi on 12/26/16.
//  Copyright © 2016 Ehsan Jahromi. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupUserNotifications()
        createShortcutItems()
        
        return true
    }
    
    private func setupUserNotifications() {
        let notification = UNUserNotificationCenter.current()
        let options = UNAuthorizationOptions.badge
        notification.requestAuthorization(options: options, completionHandler: { (bool,error) in
            if bool == false {
                print("User permissions not granted.")
            }
        })
    }

    private func createShortcutItems() {
        let clearShortcutItem = UIApplicationShortcutItem(type: "com.ehsanjahromi.clear",
                                                     localizedTitle: "Clear Notifications",
                                                     localizedSubtitle: nil,
                                                     icon: UIApplicationShortcutIcon(templateImageName: "x_clear"),
                                                     userInfo: nil)
        
        let messagesShortcutItem = UIApplicationShortcutItem(type: "com.ehsanjahromi.messages",
                                                     localizedTitle: "Messages",
                                                     localizedSubtitle: nil,
                                                     icon: UIApplicationShortcutIcon(templateImageName: "x_comment"),
                                                     userInfo: nil)
        
        let notificationsShortcutItem = UIApplicationShortcutItem(type: "com.ehsanjahromi.messages",
                                                             localizedTitle: "Notifications",
                                                             localizedSubtitle: nil,
                                                             icon: UIApplicationShortcutIcon(templateImageName: "x_wave"),
                                                             userInfo: nil)
        
        UIApplication.shared.shortcutItems = [clearShortcutItem,messagesShortcutItem,notificationsShortcutItem]
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        if shortcutItem.type == "com.ehsanjahromi.clear" {
            
        }
        
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

