//
//  BaseViewController.swift
//  WeatherDemo
//
//  Created by Ali Jaber on 4/19/18.
//  Copyright © 2018 Ali Jaber. All rights reserved.
//

import UIKit
import SVProgressHUD
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: DisplayAlert
    //sending a title and a message to this function, will display an alert with these two strings
    func displayAlert(title: String, message: String)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }

    // MARK: showloader
    func showLoader()  {
        SVProgressHUD.show()
    }
    // MARK: hideloader
    func hideLoader()  {
        SVProgressHUD.dismiss()
    }

    // MARK:dismiss keyboard when screen touched
    // when touching the screen, keyboard dismisses
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

   
}
