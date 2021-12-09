//  StartViewController.swift
//  Race
//
//  Created by Владимир on 10.04.2021.
//

import GameplayKit
import UIKit

class StartViewController: UIViewController {
    private var timeInterval = 0.04
    lazy var firstTimerController = creatingTimers()
    lazy var secondTimerController = creatingTimers()
    private var spaceshipColor = ["ic_redSpaceship", "ic_blueSpaceship", "ic_blackSpaceship", "ic_purpleSpaceship"]
    private var spaceshipIndex = UserDefaults.standard.integer(forKey: "spaceshipIndex")
    private var intersectionIndicator = false
    private var heightToDisappearForStone: CGFloat = 0
    lazy var chosenSpaceship = chooseSpaceship()
    private var score = 0 {
        didSet {
            scoreOutlet.text = "Score: \(score)"
            scoreOutlet.text = " \(NSLocalizedString("score", comment: "")) \(score) "
        }
    }
    private var timeIntervalControl = Timer()
    private var secondTimeIntervalControl = Timer()
    private var timerStones = Timer()
    private let endGameTap = UITapGestureRecognizer()
    private let date = Date()
    private let dateFormatter = DateFormatter()
    private var dateToString = ""
    @IBOutlet private weak var scoreOutlet: UILabel!
    @IBOutlet private weak var spaceshipOutlet: UIButton!
    @IBOutlet private weak var leftSpaceStone: UIImageView!
    @IBOutlet private weak var rightSpaceStone: UIImageView!
    @IBOutlet private weak var spaceImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        scoreOutlet.text = NSLocalizedString("scoreStart", comment: "")
        spaceshipOutlet.setImage(chosenSpaceship, for: UIControl.State.normal)

        setDisappearingOfStones()
        setupSwipes()
        dateFormatterSetup()
        endGameTapSetup()
        timerSetups()
    }

    private func setDisappearingOfStones() {
        heightToDisappearForStone = view.frame.height
    }

    private func dateFormatterSetup() {
        dateFormatter.dateFormat = "MMM d, HH:mm, ss"
        dateToString = dateFormatter.string(from: date)
    }

    private func endGameTapSetup() {
        endGameTap.addTarget(self, action: #selector(endTap))
        endGameTap.isEnabled = false
        view.addGestureRecognizer(endGameTap)
    }

    private func timerSetups() {
        timeIntervalControl = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(controlTimer), userInfo: nil, repeats: true)

        secondTimeIntervalControl = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(secondControlTimer), userInfo: nil, repeats: true)
    }

    private func setupSwipes() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftMoveSwipe))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        view.isUserInteractionEnabled = true

        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightMoveSwipe))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        view.isUserInteractionEnabled = true
    }
    @objc private func leftMoveSwipe(_ sender: UISwipeGestureRecognizer) {
        if spaceshipOutlet.frame.origin.x == 290 {
            spaceshipOutlet.frame.origin.x = 150
        } else if spaceshipOutlet.frame.origin.x == 150 {
            spaceshipOutlet.frame.origin.x = 10
        } else {
            spaceshipOutlet.frame.origin.x = 10
        }
    }
    @objc private func rightMoveSwipe(_ sender: UISwipeGestureRecognizer) {
        if spaceshipOutlet.frame.origin.x == 10 {
            spaceshipOutlet.frame.origin.x = 150
        } else if spaceshipOutlet.frame.origin.x == 150 {
            spaceshipOutlet.frame.origin.x = 290
        } else {
            spaceshipOutlet.frame.origin.x = 290
        }
    }
    @objc private func stonesAnimation() {
        movingStones(stone: leftSpaceStone)
        endgame()
        movingStones(stone: rightSpaceStone)
        endgame()
    }

    private func chooseSpaceship() -> UIImage? {
        let chosenImage = spaceshipColor[spaceshipIndex]
        if let setImage = UIImage(named: chosenImage) {
            return setImage
        } else {
            return nil
        }
    }
    private func movingStones(stone: UIImageView) {
        stone.frame = CGRect(x: stone.frame.origin.x, y: stone.frame.origin.y + 1, width: stone.frame.size.width, height: stone.frame.size.height)
        if stone.frame.origin.y == heightToDisappearForStone {
            stone.frame.origin.y = 0
            let setRandom = Int.random(in: 1...3)
            switch setRandom {
            case 1:
                stone.frame.origin.x = 10
            case 2:
                stone.frame.origin.x = 150
            default:
                stone.frame.origin.x = 290
            }
            score += 1
        }
        intersectionIndicator = stone.frame.intersects(spaceshipOutlet.frame)
    }
    private func endgame() {
        if intersectionIndicator {
            endGameTap.isEnabled = true
            timerStones.invalidate()
            secondTimeIntervalControl.invalidate()
            guard let documentDirectoryPath = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
                return
            }
            var folderPath = documentDirectoryPath
            folderPath.appendPathComponent("Score")
            let path = folderPath
            try? FileManager.default.createDirectory(at: path, withIntermediateDirectories: false, attributes: nil)
            let result = Score(date: dateToString, score: score)
            let data = try? JSONEncoder().encode(result)
            let dataPath = folderPath.appendingPathComponent("\(dateToString).json")
            FileManager.default.createFile(atPath: dataPath.path, contents: data, attributes: nil)
        }
    }
    @objc private func endTap(sender: UITapGestureRecognizer) {
        let viewController = ViewController.instantiateMainVC()
        present(viewController, animated: true, completion: nil)
    }
    private func creatingTimers() -> Timer {
        timerStones = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(stonesAnimation), userInfo: nil, repeats: true)
        return timerStones
    }
    @objc private func controlTimer() {
        timeInterval /= 1.05
        let controller = 1
        repeat {
            firstTimerController.invalidate()
            secondTimerController = creatingTimers()
        } while controller == 0
    }
    @objc private func secondControlTimer() {
        timeInterval /= 1.1
        let controller = 1
        repeat {
            secondTimerController.invalidate()
            firstTimerController = creatingTimers()
        } while controller == 0
    }
}
