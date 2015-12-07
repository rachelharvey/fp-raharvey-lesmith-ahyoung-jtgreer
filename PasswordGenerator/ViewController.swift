//
//  ViewController.swift
//  PasswordGenerator
//
//  Created by Rachel Harvey on 10/19/15.
//  Copyright © 2015 Rachel Harvey, Lucas Smith, Aaron Young, and Jeffery Greer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak private var labelDenotingGeneratedPassword: UILabel!
    @IBOutlet weak private var generatedPasswordLabel: UILabel!
    
    @IBOutlet weak private var secureButton: BorderedButton!
    @IBOutlet weak private var memorableButton: BorderedButton!
    @IBOutlet weak private var copyButton: CopyButton!
    
    @IBOutlet weak var whyNavigationButton: BorderedButton!
    @IBOutlet weak var howNavigationButton: BorderedButton!
    
    private var passwordLength: Int = 12

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurePasswordLabels()
    }
    
    private func configurePasswordLabels() -> Void {
        self.generatedPasswordLabel.text = " "
        self.labelDenotingGeneratedPassword.hidden = true
    }
    
    @IBAction func copyButtonPushed() -> Void {
        let stringToCopy = self.generatedPasswordLabel.text
        if(self.stringIsCopyable(stringToCopy!)) {
            copyPasswordToClipboard()
        }
    }
    
    private func stringIsCopyable(password: String!) -> Bool {
        if((password != nil) && !stringIsEmpty(password)){
            return true
        } else {
            return false
        }
    }
    
    private func stringIsEmpty(string:String) -> Bool {
        if(string == " "){
            return true
        } else {
            return false
        }
    }
    
    private func copyPasswordToClipboard() -> Void {
        let pasteBoard = UIPasteboard.generalPasteboard()
        pasteBoard.string = self.generatedPasswordLabel.text
        presentCopiedAlert()
    }
    
    private func presentCopiedAlert() -> Void {
        var alertController:UIAlertController = createAlertController("Copied", message: "Copied Password to Clipboard!")
        alertController = self.addAlertControllerAction(isErrorAlert: false, alertController: alertController)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func createAlertController(title:String, message:String) -> UIAlertController {
        let style = UIAlertControllerStyle.Alert
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        return alertController
    }
    
    private func addAlertControllerAction(isErrorAlert isErrorAlert: Bool, alertController:UIAlertController) -> UIAlertController {
        let handler = self.handlerForType(isErrorAlert: isErrorAlert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: handler))
        return alertController
    }
    
    private func handlerForType(isErrorAlert isErrorAlert: Bool) -> ((UIAlertAction!) -> ())! {
        var handler: ((UIAlertAction!) -> ())!
        if(isErrorAlert) {
            handler = {(alert: UIAlertAction!) in self.viewDidLoad()}
        } else {
            handler = nil
        }
        return handler
    }
    
    @IBAction private func secureButtonPushed() -> Void {
        self.showCopyButtonAndPasswordLabel()
        let secureGenerator = SecurePasswordFactory(length: self.passwordLength)
        self.generatedPasswordLabel.text = secureGenerator.getRandomPassword()
    }
    
    @IBAction private func memorableButtonPushed() -> Void {
        self.showCopyButtonAndPasswordLabel()
        let memorableGenerator = MemorablePasswordFactory(length: self.passwordLength, wordGenerator: RandomWordFactory())
        self.checkForNetworkError(memorableGenerator.getRandomWords(), memorableGenerator: memorableGenerator)
    }
    
    private func showCopyButtonAndPasswordLabel() -> Void {
        self.copyButton.showButton()
        self.labelDenotingGeneratedPassword.hidden = false
    }
    
    private func checkForNetworkError(password:String, memorableGenerator:MemorablePasswordFactory) -> Void {
        if(memorableGenerator.checkForNetworkError()) {
            self.presentErrorAlert()
        } else {
            self.generatedPasswordLabel.text = password
        }
    }
    
    private func presentErrorAlert() -> Void {
        var alertController = createAlertController("Error", message: "Sorry, there was an error fetching your password!")
        alertController = self.addAlertControllerAction(isErrorAlert: true, alertController: alertController)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}

