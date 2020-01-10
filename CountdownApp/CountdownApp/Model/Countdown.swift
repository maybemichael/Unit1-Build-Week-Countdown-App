//
//  Countdown.swift
//  CountdownApp
//
//  Created by Michael on 1/5/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation

struct Countdown: Equatable, Codable {
    var eventName: String
    var date: Date
}

enum SettingsOptions: Int, Equatable, Codable, CaseIterable, CustomStringConvertible {
    case sortCountdowns
    case formatCountdowns

    var description: String {
        switch self {
        case .sortCountdowns:
            return "Sort Countdowns"
        case .formatCountdowns:
            return "Format Countdowns"
        }
    }
}

enum SortingOptions: Int, Equatable, Codable, CaseIterable, CustomStringConvertible {
    case sortByName
    case sortByDate
    
    var description: String {
        switch self {
        case .sortByName:
            return "Sort By Name"
        case .sortByDate:
            return "Sort By Date"
        }
    }
}

class Sorting {
    var sortByName = false
    var sortByDate = false
}
