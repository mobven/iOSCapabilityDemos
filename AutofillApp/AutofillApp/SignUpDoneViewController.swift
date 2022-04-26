//
//  SignUpDoneViewController.swift
//  AutofillApp
//
//  Created by Emin Çelikkan on 21.04.2022.
//

import UIKit

class SignUpDoneViewController: UIViewController {

    @IBOutlet var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func routeToLogin(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
