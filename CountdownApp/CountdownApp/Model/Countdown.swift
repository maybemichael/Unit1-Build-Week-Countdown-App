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

//class SortingByDate {
//    var sortedByDate: Bool = true
//}
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
    case sortByDate
    case sortByName
    
    var description: String {
        switch self {
        case .sortByDate:
            return "Sort By Date"
        case .sortByName:
            return "Sort By Name"
        }
    }
}

