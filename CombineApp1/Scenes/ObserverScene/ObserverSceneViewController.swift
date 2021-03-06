//
//  ObserverSceneViewController.swift
//  CombineApp1
//
//  Created by Mac on 02.11.2019.
//  Copyright (c) 2019 Lammax. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import MessageUI
import Combine

protocol ObserverSceneDisplayLogic: class {
    func displayObserver(viewModel: ObserverScene.Observer.ViewModel)
}



class ObserverSceneViewController: UIViewController {
    var interactor: ObserverSceneBusinessLogic?
    var router: (NSObjectProtocol & ObserverSceneRoutingLogic & ObserverSceneDataPassing)?
    
    private var currentTFTag: Int = 0
    private let datePicker = UIDatePicker()

    @IBOutlet weak var vcTF1: UITextField!
    @IBOutlet weak var vcTF2: UITextField!
    @IBOutlet weak var vcTF3: UITextField!
    @IBOutlet weak var vcTF4: UITextField!
    @IBOutlet weak var dateField: UITextField!
    
    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup
  
    private func setup() {
        
        ObserverSceneConfigurator.sharedInstance.configure(viewController: self)
        
    }
  
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        doOnDidLoad()
    }

    // MARK: Do something

    func doOnDidLoad() {
        
        if #available(iOS 12.0, *) {
            self.vcTF1.textContentType = .oneTimeCode
            self.vcTF1.keyboardType = .numberPad
        }

        self.vcTF1.delegate = self
        self.vcTF2.delegate = self
        self.vcTF3.delegate = self
        self.vcTF4.delegate = self
        
        //MARK: DatePicker
        //TODOL add as subview + animation + programmaticaly
        datePicker.datePickerMode = .dateAndTime
        if let localeID = Locale.preferredLanguages.first {
            datePicker.locale = Locale(identifier: localeID)
        }
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButon = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.setItems([flexSpace,doneButon], animated: true)
        dateField.inputAccessoryView = toolbar
        datePicker.addTarget(self, action: #selector(getDateFromPicker), for: .valueChanged)
        let weekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        let weekLater = Calendar.current.date(byAdding: .day, value: 7, to: Date())
        datePicker.minimumDate = weekAgo
        datePicker.maximumDate = weekLater

        dateField.inputView = datePicker
        
        runObserver()

    }
    
    @objc func doneAction() {
        view.endEditing(true)
    }
    
    @objc func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        dateField.text = formatter.string(from: datePicker.date)
    }
    
    private func fillCodeFields(codeCharacter: String) {
        currentTFTag += 1
        if currentTFTag > 1, let currentTF = view.viewWithTag(currentTFTag) as? UITextField {
            currentTF.text = codeCharacter
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.setActiveTextField(currentTF)
            }
        }
    }
    
    private func setActiveTextField(_ textField: UITextField) {
        let nextTag = textField.tag + 1

        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            print("Finish code entering")
        }
    }
    
    private func runObserver() {
        let request = ObserverScene.Observer.Request()
        interactor?.runObserver(request: request)
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        let messageVC = MFMessageComposeViewController()
               messageVC.body = "Verification code: 1234";
               messageVC.recipients = ["89024672586"]
               messageVC.messageComposeDelegate = self
               self.present(messageVC, animated: true, completion: nil)
    }
}

extension ObserverSceneViewController: MFMessageComposeViewControllerDelegate {
    
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

extension ObserverSceneViewController: ObserverSceneDisplayLogic {
    
    func displayObserver(viewModel: ObserverScene.Observer.ViewModel) {
        print("displayObserver")
    }

}

extension ObserverSceneViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.setActiveTextField(textField)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.tag == 1, string.count > 0 {
            self.fillCodeFields(codeCharacter: string)
        }
        
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        // make sure the result is under 1 character
        return updatedText.count <= 1
    }
}

