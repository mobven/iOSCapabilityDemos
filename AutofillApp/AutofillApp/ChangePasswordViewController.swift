//
//  ChangePasswordViewController.swift
//  AutofillApp
//
//  Created by Emin Çelikkan on 19.04.2022.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet var changePasswordButton: UIButton!
    @IBOutlet var confirmNewPasswordTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var userNameTextField: UITextField!
    override func viewDidLoad() {   
        super.viewDidLoad()
        let gestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        userNameTextField.textContentType = .username
        passwordTextField.textContentType = .newPassword
        confirmNewPasswordTextField.textContentType = .newPassword
        userNameTextField.text = UserDefaults.standard.string(forKey: "username")
        
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func changePassword(_ sender: Any) {
        if passwordTextField.text == confirmNewPasswordTextField.text {
            UserDefaults.standard.setValue(passwordTextField.text, forKey: "password")
            navigationController?.popViewController(animated: true)
        } else {
            let alertController = UIAlertController(title: "Error", message: "New Password and Confirm Password Fields are not matching", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: .none)
            alertController.addAction(alertAction)
            present(alertController, animated: true)
        }
    }
}
