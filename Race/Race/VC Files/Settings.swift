//
//  Settings.swift
//  Race
//
//  Created by Владимир on 18.06.2021.
//

import Foundation
import UIKit

class Settings: UIViewController {
    @IBOutlet var settingsSpaceships: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
}
    @IBAction private func chooseSpaceship(_ sender: UIButton) {
        if let spaceshipNumber = settingsSpaceships.lastIndex(of: sender) {
        UserDefaults.standard.setValue(spaceshipNumber, forKey: "spaceshipIndex")
        }
}
    @IBAction private func backButton(_ sender: UIButton) {
        let viewController = ViewController.instantiateMainVC()
        present(viewController, animated: true, completion: nil)
    }
}
