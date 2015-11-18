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
    
    @IBOutlet weak private var secureButton: UIButton!
    @IBOutlet weak private var memorableButton: UIButton!
    @IBOutlet weak private var copyButton: UIButton!
    
    @IBOutlet weak var whyNavigationButton: UIButton!
    @IBOutlet weak var howNavigationButton: UIButton!
    
    private var passwordLength: Int = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurePasswordLabels()
        self.configureButtons()
    }
    
    private func configurePasswordLabels() -> Void {
        self.generatedPasswordLabel.text = " "
        self.labelDenotingGeneratedPassword.hidden = true
    }
    
    private func configureButtons() -> Void {
        self.configureCopyButton()
        self.addBorders()
        self.configureNavigationButtons()
    }
    
    private func configureCopyButton() -> Void {
        self.copyButton.enabled = false
        self.copyButton.hidden = true
        self.addButtonBorder(self.copyButton)
    }
    
    private func addBorders() -> Void {
        self.addButtonBorder(self.secureButton)
        self.addButtonBorder(self.memorableButton)
    }
    
    private func addButtonBorder(button: UIButton) -> Void {
        button.layer.borderColor = UIColor.greenColor().CGColor
        button.layer.borderWidth = 0.5
    }
    
    private func configureNavigationButtons() {
        self.configureNavigationButtonLabel(self.whyNavigationButton)
        self.configureNavigationButtonLabel(self.howNavigationButton)
    }
    
    private func configureNavigationButtonLabel(button: UIButton) -> Void {
        button.titleLabel!.numberOfLines = 0
        button.titleLabel!.adjustsFontSizeToFitWidth = true
        button.titleLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping
    }
    
    @IBAction func copyButtonPushed(sender: UIButton) {
        let stringToCopy = self.generatedPasswordLabel.text
        if(self.stringIsCopyable(stringToCopy!)) {
            copyPasswordToClipboard(stringToCopy!)
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
    
    private func copyPasswordToClipboard(stringToCopy:String) -> Void {
        let pasteBoard = UIPasteboard.generalPasteboard()
        pasteBoard.string = stringToCopy
        presentCopiedAlert()
    }
    
    private func presentCopiedAlert() -> Void {
        var alertController:UIAlertController = createAlertController("Copied", message: "Copied Password to Clipboard!")
        alertController = addCopyAlertControllerAction("Dismiss", alertController: alertController)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func createAlertController(title:String, message:String) -> UIAlertController {
        let style = UIAlertControllerStyle.Alert
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        return alertController
    }
    
    private func addCopyAlertControllerAction(title:String, alertController:UIAlertController)->UIAlertController {
        let style = UIAlertActionStyle.Default
        alertController.addAction(UIAlertAction(title: title, style: style, handler: nil))
        return alertController
    }
    
    @IBAction private func secureButtonPushed() -> Void {
        self.makeElementsAppear()
        let secure = SecurePassword(length: self.passwordLength)
        self.generatedPasswordLabel.text = secure.getRandomPassword()
    }
    
    @IBAction private func memorableButtonPushed() -> Void {
        self.makeElementsAppear()
        let memorableGenerator = MemorablePassword(length: self.passwordLength, wordGenerator: RandomWord())
        self.checkForNetworkError(memorableGenerator.getRandomWords(), memorableGenerator: memorableGenerator)
    }
    
    private func makeElementsAppear() -> Void {
        self.copyButton.enabled = true
        self.copyButton.hidden = false
        self.labelDenotingGeneratedPassword.hidden = false
    }
    
    private func checkForNetworkError(password:String, memorableGenerator:MemorablePassword) -> Void {
        if(memorableGenerator.checkForNetworkError()) {
            self.presentErrorAlert()
        } else {
            self.generatedPasswordLabel.text = password
        }
    }
    
    private func presentErrorAlert() -> Void {
        var alertController = createAlertController("Error", message: "Sorry, there was an error fetching your password!")
        alertController = addErrorAlertControllerAction("Dismiss", alertController: alertController)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func addErrorAlertControllerAction(title:String, alertController:UIAlertController) -> UIAlertController{
        let style = UIAlertActionStyle.Default
        let handler = {(alert: UIAlertAction!) in self.viewDidLoad()}
        alertController.addAction(UIAlertAction(title: title, style: style, handler: handler))
        return alertController
    }

}

