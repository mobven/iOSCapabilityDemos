//
//  SignUpViewController.swift
//  AutofillApp
//
//  Created by Emin Çelikkan on 11.04.2022.
//

import UIKit
import AuthenticationServices

class SignUpViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        userNameTextField.textContentType = .username
        passwordTextField.textContentType = .newPassword
        passwordTextField.passwordRules = .init(descriptor: "minlength: 32; required: lower; required: upper; required: digit; required: [&]; required: [-]; required: [.]; required: [_];")
       
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func completeButtonTapped(_ sender: Any) {
        guard let password = passwordTextField.text, isValid(password) else {
            showAlert()
            return
        }
        let store = ASCredentialIdentityStore.shared
        let credential = ASPasswordCredentialIdentity(
            serviceIdentifier: ASCredentialServiceIdentifier(identifier: "www.mobven.com", type: .domain),
            user: userNameTextField.text ?? "",
            recordIdentifier: "my_reference_to_the_password_data"
        )
        UserDefaults.standard.setValue(self.userNameTextField.text, forKey: "username")
        UserDefaults.standard.setValue(self.passwordTextField.text, forKey: "password")
        
        
        store.getState { state in
            if state.isEnabled {
                store.saveCredentialIdentities([credential]) { bool, error in
                    if let error = error {
                        print(error)
                    } else {
                        
                    }
                }
            } else {
                // User should allow the app to autofill passwords from the settings.
            }
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpDoneVC = storyboard.instantiateViewController(withIdentifier: "SignUpDoneViewController") as! SignUpDoneViewController
        signUpDoneVC.modalPresentationStyle = .overFullScreen
        signUpDoneVC.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(signUpDoneVC, animated: true)
    }
    
    private func showAlert() {
        // TODO: show alert
        let alertController = UIAlertController(
            title: "Password isn't strong enough",
            message: "Please use 32 Digit long password which containst &.-_ special characters and at lease one lower, one upper letter and one number",
            preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: .none)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    func isValid(_ password: String) -> Bool {
        // Regex ile kiyasla
        // aA$ [32]
        let passwordPattern =
        // At least 8 characters
        #"(?=.{32,})"# +
        
        // At least one capital letter
        #"(?=.*[A-Z])"# +
        
        // At least one lowercase letter
        #"(?=.*[a-z])"# +
        
        // At least one digit
        #"(?=.*\d)"# +
        
        // At least one special character
        #"(?=.*[ &._-])"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [passwordPattern])
        return password.range(of: passwordPattern, options: .regularExpression) != nil
    }
    
}
