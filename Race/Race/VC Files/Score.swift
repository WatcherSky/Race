//
//  Score.swift
//  Race
//
//  Created by Владимир on 19.06.2021.
//

import Foundation

class Score: Codable {
    var date = ""
    var score = 0

    init(date: String, score: Int) {
        self.date = date
        self.score = score
    }
}
