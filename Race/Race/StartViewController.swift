//  StartViewController.swift
//  Race
//
//  Created by Владимир on 10.04.2021.
//

import UIKit

class StartViewController: UIViewController {
    private var intersectionIndicator = false
    private var heightToDisappearForSpace: CGFloat = 900
    private var heightToDisappearForStone: CGFloat = 780
    @IBOutlet weak var ourSpaceshipOutlet: UIButton!
    @IBOutlet weak var upSpaceImage: UIImageView!
    @IBOutlet weak var thirdSpaceImage: UIImageView!
    @IBOutlet weak var secondSpaceImage: UIImageView!
    @IBOutlet weak var spaceshipOutlet: UIButton!
    @IBOutlet weak var leftSpaceStone: UIImageView!
    @IBOutlet weak var midSpaceStone: UIImageView!
    @IBOutlet weak var rightSpaceStone: UIImageView!
    @IBOutlet weak var spaceImage: UIImageView!

    override func viewDidLoad() {
    super.viewDidLoad()

    let timerSpace = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(spaceAnimation), userInfo: nil, repeats: true)

    let timerStones = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(stonesAnimation), userInfo: nil, repeats: true)
}

    @IBAction private func leftMoveSwipe(_ sender: UISwipeGestureRecognizer) {
        if spaceshipOutlet.frame.origin.x == 300 {
            spaceshipOutlet.frame.origin.x = 150
        } else if spaceshipOutlet.frame.origin.x == 150 {
            spaceshipOutlet.frame.origin.x = 10
        } else {
            spaceshipOutlet.frame.origin.x = 10
        }
    }
    @IBAction private func rightMoveSwipe(_ sender: UISwipeGestureRecognizer) {
        if spaceshipOutlet.frame.origin.x == 10 {
            spaceshipOutlet.frame.origin.x = 150
        } else if spaceshipOutlet.frame.origin.x == 150 {
            spaceshipOutlet.frame.origin.x = 300
        } else {
            spaceshipOutlet.frame.origin.x = 300
        }
    }

    @objc private func spaceAnimation() {
    upSpaceImage.frame = CGRect(x: upSpaceImage.frame.origin.x, y: upSpaceImage.frame.origin.y + 1, width: upSpaceImage.frame.size.width, height: upSpaceImage.frame.size.height)
        if upSpaceImage.frame.origin.y == heightToDisappearForSpace {
            upSpaceImage.frame.origin.y = 0
        }
    spaceImage.frame = CGRect(x: spaceImage.frame.origin.x, y: spaceImage.frame.origin.y + 1, width: spaceImage.frame.size.width, height: spaceImage.frame.size.height)
        if spaceImage.frame.origin.y == heightToDisappearForSpace {
            spaceImage.frame.origin.y = 0
        }

    secondSpaceImage.frame = CGRect(x: secondSpaceImage.frame.origin.x, y: secondSpaceImage.frame.origin.y + 1, width: secondSpaceImage.frame.size.width, height: secondSpaceImage.frame.size.height)
        if secondSpaceImage.frame.origin.y == heightToDisappearForSpace {
            secondSpaceImage.frame.origin.y = 0
}

    thirdSpaceImage.frame = CGRect(x: thirdSpaceImage.frame.origin.x, y: thirdSpaceImage.frame.origin.y + 1, width: thirdSpaceImage.frame.size.width, height: thirdSpaceImage.frame.size.height)
        if thirdSpaceImage.frame.origin.y == heightToDisappearForSpace {
            thirdSpaceImage.frame.origin.y = 0
        }
        }
    @objc private func stonesAnimation() {
        leftSpaceStone.frame = CGRect(x: leftSpaceStone.frame.origin.x, y: leftSpaceStone.frame.origin.y + 1, width: leftSpaceStone.frame.size.width, height: leftSpaceStone.frame.size.height)
        if leftSpaceStone.frame.origin.y == heightToDisappearForStone {
            leftSpaceStone.frame.origin.y = 0
        }
        intersectionIndicator = leftSpaceStone.frame.intersects(ourSpaceshipOutlet.frame)
    if intersectionIndicator {
        let viewController = ViewController.instantiateMainVC()
        present(viewController, animated: true, completion: nil)
        }
    midSpaceStone.frame = CGRect(x: midSpaceStone.frame.origin.x, y: midSpaceStone.frame.origin.y + 1, width: midSpaceStone.frame.size.width, height: midSpaceStone.frame.size.height)
    if midSpaceStone.frame.origin.y == heightToDisappearForStone {
        midSpaceStone.frame.origin.y = 0
    }
        intersectionIndicator = midSpaceStone.frame.intersects(ourSpaceshipOutlet.frame)
        if intersectionIndicator {
            let viewController = ViewController.instantiateMainVC()
            present(viewController, animated: true, completion: nil)
            }
        rightSpaceStone.frame = CGRect(x: rightSpaceStone.frame.origin.x, y: rightSpaceStone.frame.origin.y + 1, width: rightSpaceStone.frame.size.width, height: rightSpaceStone.frame.size.height)
    if rightSpaceStone.frame.origin.y == heightToDisappearForStone {
        rightSpaceStone.frame.origin.y = 0
    }
        intersectionIndicator = rightSpaceStone.frame.intersects(ourSpaceshipOutlet.frame)
        if intersectionIndicator {
            let viewController = ViewController.instantiateMainVC()
            present(viewController, animated: true, completion: nil)
            }
    }
}
