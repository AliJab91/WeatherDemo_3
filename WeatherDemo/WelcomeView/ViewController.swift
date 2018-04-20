//
//  ViewController.swift
//  WeatherDemo
//
//  Created by Ali Jaber on 4/19/18.
//  Copyright © 2018 Ali Jaber. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    @IBOutlet weak var usersNameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }
    // MARK: Setup Textfield Delegate
    // setting the delegate for this function to be able to access the delegate methods of the UITextfield
    func setupTextField() {
        usersNameTextField.delegate = self
    }

    //check if user has entered his name, go to second view if yes, else, display a message to him and return
     // MARK: Next button+userDefaultSaving
    @IBAction func nextButtonPressed(_ sender: Any) {
        if usersNameTextField.text == "" {
            self.displayAlert(title: "Empty name", message: "Please set your name to be able to continue")
            return
        } else {
            UserDefaults.standard.set(usersNameTextField.text, forKey: "usersName")
            self.performSegue(withIdentifier: "goToWeatherSegue", sender: nil)
        }
    }
    

}
 //add to keyboard a return button to dismiss the keyboard
extension ViewController: UITextFieldDelegate {
    // MARK: add return Button to keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

