//
//  HomeViewController.swift
//  ClearNotificationsDemo
//
//  Created by Ehsan Jahromi on 12/26/16.
//  Copyright © 2016 Ehsan Jahromi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch self.tabBarController!.selectedIndex {
            case 1:
                self.title = "Messages"
            case 2:
                self.title = "Notifications"
            default:
                self.title = "Home"
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.stepper.value = 0.0
    }

    @IBAction func updateBadgeCount(_ sender: UIStepper) {
        self.navigationController?.tabBarItem.badgeValue = String(Int(sender.value))
    }

}
