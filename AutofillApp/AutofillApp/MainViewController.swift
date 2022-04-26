//
//  MainViewController.swift
//  AutofillApp
//
//  Created by Emin Çelikkan on 10.04.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var changePasswordButton: UIButton!
    @IBOutlet weak var situationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func routeToChangePassword(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
