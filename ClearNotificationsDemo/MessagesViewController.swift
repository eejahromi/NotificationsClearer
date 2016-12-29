//
//  MessagesViewController.swift
//  ClearNotificationsDemo
//
//  Created by Ehsan Jahromi on 12/26/16.
//  Copyright © 2016 Ehsan Jahromi. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Messages"
        self.navigationController?.tabBarItem.badgeValue = String(1)
    }
    


}
