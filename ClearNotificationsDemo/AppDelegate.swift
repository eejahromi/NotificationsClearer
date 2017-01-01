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
    var launchedShortcutItem: UIApplicationShortcutItem?
    
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

    func handleShortcutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false
        
        guard let shortCutType = shortcutItem.type as String? else { return false }
        
        let tabbarController = self.window?.rootViewController as? UITabBarController
        
        switch shortCutType {
            case ShortcutItemTypes.messages.rawValue:
                tabbarController?.selectedIndex = Tabs.messages.rawValue
                handled = true
            
            case ShortcutItemTypes.notifications.rawValue:
                tabbarController?.selectedIndex = Tabs.notifications.rawValue
                handled = true
            
            case ShortcutItemTypes.clear.rawValue:
                UIApplication.shared.applicationIconBadgeNumber = 0
            
                let viewControllers: [UIViewController] = (tabbarController?.viewControllers)!
                for viewController in viewControllers {
                    if viewController.tabBarItem.badgeValue != nil {
                        viewController.tabBarItem.badgeValue = nil
                    }
                
                }
                handled = true
            
            default:
                handled = false
        }
        
        return handled
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        var shouldPerformAdditionalDelegateHandling = true
        
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            launchedShortcutItem = shortcutItem
            
            // This will block "performActionForShortcutItem:completionHandler" from being called.
            shouldPerformAdditionalDelegateHandling = false
        }
        
        setupUserNotifications()
        createShortcutItems()
        
        return shouldPerformAdditionalDelegateHandling
    }
    
    private func setupUserNotifications() {
        let notification = UNUserNotificationCenter.current()
        let options = UNAuthorizationOptions.badge
        notification.requestAuthorization(options: options, completionHandler: { (bool,error) in
            if !bool {
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
        UIApplication.shared.shortcutItems = [clearShortcutItem]
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let handledShortcutItem = handleShortcutItem(shortcutItem: shortcutItem)
        
        completionHandler(handledShortcutItem)
        
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

    func applicationDidBecomeActive(_ application: UIApplication) {
        guard let shortcut = launchedShortcutItem else { return }
        
        let _ = handleShortcutItem(shortcutItem: shortcut)
        
        launchedShortcutItem = nil
        
    }




}

