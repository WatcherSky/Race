//  ViewController.swift
//  Race
//
//  Created by Владимир on 10.04.2021.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction private func startButton(_ sender: UIButton) {
        let viewController = StartViewController.instantiate()
        present(viewController, animated: true, completion: nil)
    }
    @IBAction private func settingsButton(_ sender: UIButton) {
        let viewController = Settings.instantiate()
        present(viewController, animated: true, completion: nil)
    }

    @IBAction private func recordsButton(_ sender: UIButton) {
        let viewController = RecordsViewController.instantiate()
        present(viewController, animated: true, completion: nil)
    }
}
