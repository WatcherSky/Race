//  StartViewController.swift
//  Race
//
//  Created by Владимир on 10.04.2021.
//

import UIKit

class StartViewController: UIViewController {
    private var spaceshipColor = ["ic_redSpaceship", "ic_blueSpaceship", "ic_blackSpaceship", "ic_purpleSpaceship"]
    private var spaceshipIndex = UserDefaults.standard.integer(forKey: "spaceshipIndex")
    private var intersectionIndicator = false
    private var heightToDisappearForSpace: CGFloat = 900
    private var heightToDisappearForStone: CGFloat = 780
    lazy var chosenSpaceship = chooseSpaceship()
    private var score = 0 {
        didSet {
            scoreOutlet.text = "Score: \(score)"
        }
    }
    var timerSpace = Timer()
    var timerStones = Timer()
    private let endGameTap = UITapGestureRecognizer()
    private let date = Date()
    private let dateFormatter = DateFormatter()
    private var dateToString = ""
    @IBOutlet weak var scoreOutlet: UILabel!
    @IBOutlet weak var upSpaceImage: UIImageView!
    @IBOutlet weak var thirdSpaceImage: UIImageView!
    @IBOutlet weak var secondSpaceImage: UIImageView!
    @IBOutlet weak var spaceshipOutlet: UIButton!
    @IBOutlet weak var leftSpaceStone: UIImageView!
    @IBOutlet weak var midSpaceStone: UIImageView!
    @IBOutlet weak var rightSpaceStone: UIImageView!
    @IBOutlet weak var spaceImage: UIImageView!
    @IBOutlet weak var fourthSpaceImage: UIImageView!

    override func viewDidLoad() {
    super.viewDidLoad()
        dateFormatter.dateFormat = "MMM d, HH:mm, ss"
        dateToString = dateFormatter.string(from: date)
        endGameTap.addTarget(self, action: #selector(endTap))
        endGameTap.isEnabled = false
        view.addGestureRecognizer(endGameTap)

        spaceshipOutlet.setImage(chosenSpaceship, for: UIControl.State.normal)

        timerSpace = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(spaceAnimation), userInfo: nil, repeats: true)
        timerStones = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(stonesAnimation), userInfo: nil, repeats: true)
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
    movingSpace(space: fourthSpaceImage)
}
    @objc private func stonesAnimation() {
    movingStones(stone: leftSpaceStone)
    endgame()
    movingStones(stone: midSpaceStone)
    endgame()
    movingStones(stone: rightSpaceStone)
    endgame()
}

    func chooseSpaceship() -> UIImage {
        let chosenImage = spaceshipColor[spaceshipIndex]
        let setImage = UIImage(named: chosenImage)
        return setImage!
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
            score += 1
        }
        intersectionIndicator = stone.frame.intersects(spaceshipOutlet.frame)
}
    func endgame() {
        if intersectionIndicator {
            endGameTap.isEnabled = true
            timerSpace.invalidate()
            timerStones.invalidate()
            let documentDirectoryPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            var folderPath = documentDirectoryPath
            folderPath.appendPathComponent("Score")
            let path = folderPath
            try? FileManager.default.createDirectory(at: path, withIntermediateDirectories: false, attributes: nil)
            let result = Score(date: dateToString, score: score)
            let data = try? JSONEncoder().encode(result)
            let dataPath = folderPath.appendingPathComponent("\(dateToString).json")
            FileManager.default.createFile(atPath: dataPath.path, contents: data, attributes: nil)
            print(result.date)
            print(result.score)
        }
}

    @objc func endTap(sender: UITapGestureRecognizer) {
        let viewController = ViewController.instantiateMainVC()
        present(viewController, animated: true, completion: nil)
}
}
