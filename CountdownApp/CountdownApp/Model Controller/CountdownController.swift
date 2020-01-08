//
//  CountdownController.swift
//  CountdownApp
//
//  Created by Michael on 1/5/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation

protocol CountdownDelegate: AnyObject {
    func countdownUpdate(date: Date)
}

class CountdownController {
    
    var countdowns: [Countdown] = [Countdown(eventName: "Wedding", date: Date().addingTimeInterval(160000), time: Date())]
    
    weak var delegate: CountdownDelegate?
    
    var timer: Timer?
    
    var eventDate: Date?
    
    var remainingTimeInterval: TimeInterval {
        if let eventDate = eventDate {
            let timeRemaining = eventDate.timeIntervalSinceNow
            return timeRemaining
        } else {
            return 0
        }
    }
    
    func getEventDate(countdown: Countdown) -> Date {
        let date = countdown.date
        let time = countdown.time ?? Date()
        let eventTimeInterval = date.timeIntervalSinceNow + time.timeIntervalSinceNow
        let eventDate = Date().addingTimeInterval(eventTimeInterval)
        return eventDate
    }
    
    func createCountdown(name: String, date: Date, time: Date?) {
        let countdown = Countdown(eventName: name, date: date, time: time)
        countdowns.append(countdown)
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: updateTimer(timer:))
    }
    
    func deleteCountdown(countdown: Countdown) {
        guard let countdown = countdowns.firstIndex(of: countdown) else { return }
        countdowns.remove(at: countdown)
    }
    
    func updateTimer(timer: Timer) {
        let now = Date()
        guard let eventDate = eventDate else { return }
        if now <= eventDate {
            delegate?.countdownUpdate(date: eventDate)
        }
    }
}
