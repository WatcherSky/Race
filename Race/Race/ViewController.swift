//
//  ViewController.swift
//  Race
//
//  Created by Владимир on 10.04.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction private func startButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Start", bundle: Bundle.main)
        let destinationToStart = storyboard.instantiateViewController(identifier: "StartViewController")
        present(destinationToStart, animated: true, completion: nil)
    }
}
