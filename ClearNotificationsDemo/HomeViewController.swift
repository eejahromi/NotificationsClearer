//
//  HomeViewController.swift
//  ClearNotificationsDemo
//
//  Created by Ehsan Jahromi on 12/26/16.
//  Copyright © 2016 Ehsan Jahromi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.tabBarItem.badgeValue = String(1)
    }


}
