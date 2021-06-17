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
    movingSpace(space: upSpaceImage)
    movingSpace(space: spaceImage)
    movingSpace(space: secondSpaceImage)
    movingSpace(space: thirdSpaceImage)
    }
    @objc private func stonesAnimation() {
    movingStones(stone: leftSpaceStone)
    endgame()
    movingStones(stone: midSpaceStone)
    endgame()
    movingStones(stone: rightSpaceStone)
    endgame()
    movingStones(stone: imgView)
    endgame()
    }

    func movingSpace(space: UIImageView) {
        space.frame = CGRect(x: space.frame.origin.x, y: space.frame.origin.y + 1, width: space.frame.size.width, height: space.frame.size.height)
            if space.frame.origin.y == heightToDisappearForSpace {
                space.frame.origin.y = 0
            }
    }
    func movingStones(stone: UIImageView) {
        stone.frame = CGRect(x: stone.frame.origin.x, y: stone.frame.origin.y + 1, width: stone.frame.size.width, height: stone.frame.size.height)
        if stone.frame.origin.y == heightToDisappearForStone {
            stone.frame.origin.y = 0
        }
            intersectionIndicator = stone.frame.intersects(ourSpaceshipOutlet.frame)
        }
    func endgame() {
        if intersectionIndicator {
            let viewController = ViewController.instantiateMainVC()
            present(viewController, animated: true, completion: nil)
    }
    }
}
