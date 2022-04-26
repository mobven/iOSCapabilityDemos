//
//  CredentialProviderViewController.swift
//  autofill
//
//  Created by Emin Çelikkan on 10.04.2022.
//

import AuthenticationServices
import UIKit

class CredentialProviderViewController: ASCredentialProviderViewController, UITableViewDelegate, UITableViewDataSource {
    var passwordList : [ASPasswordCredential] = []
    
    

    @IBOutlet weak var tableView: UITableView!
    /*
     Prepare your UI to list available credentials for the user to choose from. The items in
     'serviceIdentifiers' describe the service the user is logging in to, so your extension can
     prioritize the most relevant credentials in the list.
    */
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepareCredentialList(for serviceIdentifiers: [ASCredentialServiceIdentifier]) {
        
        let testPassword = ASPasswordCredential(user: "testuser", password: "testpassword")
        let testPassword2 = ASPasswordCredential(user: "testuser2", password: "testpassword2")
        let testPassword3 = ASPasswordCredential(user: "testuser3", password: "testpassword3")
        let testPassword4 = ASPasswordCredential(user: "testuser4", password: "testpassword4")
        passwordList = [testPassword,testPassword2,testPassword3,testPassword4]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        passwordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "passwordscell", for: indexPath) as! PasswordsTableViewCell
        cell.usernameLabel.text = passwordList[indexPath.row].user
        cell.passwordLabel.text = passwordList[indexPath.row].password
        return cell
    }

    override func provideCredentialWithoutUserInteraction(for credentialIdentity: ASPasswordCredentialIdentity) {
        let databaseIsUnlocked = true
        if (databaseIsUnlocked) {
            let passwordCredential = ASPasswordCredential(user: "emin", password: "123123")
            self.extensionContext.completeRequest(withSelectedCredential: passwordCredential, completionHandler: nil)
        } else {
            self.extensionContext.cancelRequest(withError: NSError(domain: ASExtensionErrorDomain, code:ASExtensionError.userInteractionRequired.rawValue))
        }
    }
    

    

    override func prepareInterfaceToProvideCredential(for credentialIdentity: ASPasswordCredentialIdentity) {
    }
    

    @IBAction func cancel(_ sender: AnyObject?) {
        self.extensionContext.cancelRequest(withError: NSError(domain: ASExtensionErrorDomain, code: ASExtensionError.userCanceled.rawValue))
    }

    @IBAction func passwordSelected(_ sender: AnyObject?) {
        let passwordCredential = ASPasswordCredential(user: "emin", password: "123123")
        self.extensionContext.completeRequest(withSelectedCredential: passwordCredential, completionHandler: nil)
    }

}
