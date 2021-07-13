//
//  RecordsViewController.swift
//  Race
//
//  Created by Владимир on 08.07.2021.
//

import UIKit

class RecordsViewController: UIViewController {
    private var arrayOfResult = [String]()
    private var newArrayOfResult = [String]()
    private var scores: [Score] = []
    private var sortedScore: [Score] = []
    private var deleteValueStore = 0
    private var deleteValueJSON = 0

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")

        let documentDirectoryPath = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        guard var folderPath = documentDirectoryPath else {
            return
        }
        folderPath.appendPathComponent("Score")
        let file = try? FileManager.default.contentsOfDirectory(atPath: folderPath.path)
        guard let arrayOfResult = file else {
            return
        }
        for data in 0..<arrayOfResult.count {
            newArrayOfResult.append(arrayOfResult[data])
            if newArrayOfResult[data] == ".DS_Store" {
                deleteValueStore = data
            }
            if newArrayOfResult[data] == ".json" {
                deleteValueJSON = data
            }
        }
        if newArrayOfResult[deleteValueStore] == ".DS_Store" {
            let index = deleteValueStore
            newArrayOfResult.remove(at: index)
        }
        if newArrayOfResult[deleteValueJSON] == ".json" {
            let index = deleteValueJSON
            newArrayOfResult.remove(at: index)
        }
        for data in 0..<newArrayOfResult.count {
            let dataPath = folderPath.appendingPathComponent("\(newArrayOfResult[data])")
            guard let newData = FileManager.default.contents(atPath: dataPath.path) else {
                return
            }
            if let resultOfRace = try? JSONDecoder().decode(Score.self, from: newData) {
                scores.append(resultOfRace)
            }
        }
        sortedScore = sortedArray(array: scores)
    }
    @IBAction private func backButton(_ sender: UIButton) {
        let viewController = ViewController.instantiateMainVC()
        present(viewController, animated: true, completion: nil)
    }
    func sortedArray(array: [Score]) -> [Score] {
        let sortedArrayScore = array.sorted { (s1: Score, s2: Score) -> Bool in
            return s1.score > s2.score
        }
        while sortedScore.count > 20 {
            sortedScore.removeLast()
        }
        return sortedArrayScore
    }
}

extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedScore.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = "\(sortedScore[indexPath.row])"
        return cell
    }
}
