//
//  ViewController.swift
//  CombineApp1
//
//  Created by Mac on 01.11.2019.
//  Copyright © 2019 Lammax. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notification = Notification.Name("NotificationL")
        let center = NotificationCenter.default
        
        let observer = center.addObserver(forName: notification, object: nil, queue: OperationQueue()) { (notification) in
            print("Notification received")
        }
        
        center.post(name: notification, object: nil)
        
        center.removeObserver(notification)
        
    }
    

}

