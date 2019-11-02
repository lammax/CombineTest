//
//  ViewController.swift
//  CombineApp1
//
//  Created by Mac on 01.11.2019.
//  Copyright © 2019 Lammax. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController {

    @IBOutlet weak var verifyCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notification = Notification.Name("NotificationL")
        let center = NotificationCenter.default
        
        let observer = center.addObserver(forName: notification, object: nil, queue: OperationQueue()) { (notification) in
            print("Notification received")
        }
        
        center.post(name: notification, object: nil)
        
        center.removeObserver(notification)
        
        if #available(iOS 12.0, *) {
            self.verifyCodeTextField.textContentType = .oneTimeCode
            self.verifyCodeTextField.keyboardType = .numberPad
        }
        
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        let messageVC = MFMessageComposeViewController()
        messageVC.body = "Verification code: 12345";
        messageVC.recipients = ["89024672586"]
        messageVC.messageComposeDelegate = self
        self.present(messageVC, animated: true, completion: nil)
    }
    
    
    
}

extension ViewController: MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case .cancelled:
            print("Message was cancelled")
            dismiss(animated: true, completion: nil)
        case .failed:
            print("Message failed")
            dismiss(animated: true, completion: nil)
        case .sent:
            print("Message was sent")
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
}
