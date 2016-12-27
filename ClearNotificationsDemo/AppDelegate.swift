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
    
    enum Tabs: Int {
        case home = 0
        case messages = 1
        case notifications = 2
    }
    
    enum ShortcutItemTypes: String {
        case clear = "com.ehsanjahromi.clear"
        case messages = "com.ehsanjahromi.messages"
        case notifications = "com.ehsanjahromi.notifications"
    }


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
        let clearShortcutItem = UIApplicationShortcutItem(type: ShortcutItemTypes.clear.rawValue,
                                                     localizedTitle: "Clear Notifications",
                                                     localizedSubtitle: nil,
                                                     icon: UIApplicationShortcutIcon(templateImageName: "x_clear"),
                                                     userInfo: nil)
        
        let messagesShortcutItem = UIApplicationShortcutItem(type: ShortcutItemTypes.messages.rawValue,
                                                     localizedTitle: "Messages",
                                                     localizedSubtitle: nil,
                                                     icon: UIApplicationShortcutIcon(templateImageName: "x_comment"),
                                                     userInfo: nil)
        
        let notificationsShortcutItem = UIApplicationShortcutItem(type: ShortcutItemTypes.notifications.rawValue,
                                                             localizedTitle: "Notifications",
                                                             localizedSubtitle: nil,
                                                             icon: UIApplicationShortcutIcon(templateImageName: "x_wave"),
                                                             userInfo: nil)
        
        UIApplication.shared.shortcutItems = [clearShortcutItem,messagesShortcutItem,notificationsShortcutItem]
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        let tabbarController = self.window?.rootViewController as? UITabBarController
        
        if shortcutItem.type == ShortcutItemTypes.clear.rawValue {
            UIApplication.shared.applicationIconBadgeNumber = 0
            
            let viewControllers: [UIViewController] = (tabbarController?.viewControllers)!
            for viewController in viewControllers {
                if viewController.tabBarItem.badgeValue != nil {
                    viewController.tabBarItem.badgeValue = nil
                }
                
            }
        } else if shortcutItem.type == ShortcutItemTypes.messages.rawValue {
            tabbarController?.selectedIndex = Tabs.messages.rawValue
        } else if shortcutItem.type == ShortcutItemTypes.notifications.rawValue {
            tabbarController?.selectedIndex = Tabs.notifications.rawValue
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

