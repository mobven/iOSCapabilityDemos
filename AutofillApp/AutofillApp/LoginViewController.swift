//
//  ViewController.swift
//  AutofillApp
//
//  Created by Emin Çelikkan on 10.04.2022.
//

import UIKit
import AuthenticationServices

class LoginViewController: ASCredentialProviderViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var hidePasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        userNameTextField.textContentType = .username
        passwordTextField.textContentType = .password
        
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        view.resignFirstResponder()
        view.endEditing(true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        let defaultUserName = UserDefaults.standard.string(forKey: "username")
        let defaultPassword = UserDefaults.standard.string(forKey: "password")
        if userNameTextField.text == defaultUserName && passwordTextField.text == defaultPassword {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVc = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            navigationController?.pushViewController(mainVc,
                                                     animated: true)
        } else {
            let alert = UIAlertController(title: "Wrong ID or Password", message: "Try Again", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true)
        }
    }
    @IBAction func hidePassword(_ sender: Any) {
        if hidePasswordButton.isSelected {
            hidePasswordButton.isSelected = false
            passwordTextField.isSecureTextEntry = false
        } else {
            hidePasswordButton.isSelected = true
            passwordTextField.isSecureTextEntry = true
            
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


