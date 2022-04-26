//
//  ViewController.swift
//  Demo Clip
//
//  Created by Rashid Ramazanov on 4/5/22.
//

import UIKit
import StoreKit

class ViewController: UIViewController {

    @IBOutlet var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: .init("app_clip_id"), object: nil, queue: nil) { [weak self] notification in
            guard let id = notification.object as? String else { return }
            self?.label.text = id
        }
    }

    @IBAction func install() {
        guard let scene = view.window?.windowScene else { return }
        let configuration = SKOverlay.AppClipConfiguration(position: .bottom)
        let overlay = SKOverlay(configuration: configuration)
        overlay.present(in: scene)
    }

}
