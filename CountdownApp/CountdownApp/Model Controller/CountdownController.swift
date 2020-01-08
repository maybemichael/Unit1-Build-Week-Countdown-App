//
//  CountdownController.swift
//  CountdownApp
//
//  Created by Michael on 1/5/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation

class CountdownController {
    
    var countdowns: [Countdown] = []
    
    weak var delegate: CountdownDelegate?
    
    var timer: Timer?
    
    var eventDate: Date?
    
    var eventTime: TimeInterval = 0
    
    var remainingTimeInterval: TimeInterval {
        var timeRemaining: TimeInterval = 0
        if let eventDate = eventDate {
            timeRemaining = eventDate.timeIntervalSinceNow
        }
        return timeRemaining
    }
    
    func getEventDate(countdown: Countdown) -> Date {
        let date = countdown.date
        let time = countdown.time ?? Date()
        let countdownTime = date.timeIntervalSinceNow + time.timeIntervalSinceNow
        let countdownDate = Date().addingTimeInterval(countdownTime)
        return countdownDate
        
    }
    
    func createCountdown(name: String, date: Date, time: Date?) {
        let countdown = Countdown(eventName: name, date: date, time: time)
        countdowns.append(countdown)
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: updateTimer(timer:))
        saveToPersistentStore()
    }
    
    func deleteCountdown(countdown: Countdown) {
        guard let countdownToRemove = countdowns.firstIndex(of: countdown) else { return }
        countdowns.remove(at: countdownToRemove)
        timer?.invalidate()
        saveToPersistentStore()
    }
    
    func updateTimer(timer: Timer) {
        let now = Date()
        if let eventDate = eventDate {
            if now <= eventDate {
                delegate?.countdownUpdate(time: remainingTimeInterval)
            }
        }
    }
    
    var countdownURL: URL? {
        let fileManager = FileManager.default
        
        guard let documentDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let countdownsURL = documentDir.appendingPathComponent("Countdowns.plist")
        
        return countdownsURL
    }
    
    func saveToPersistentStore() {
        guard let countdownsURL = countdownURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            
            let countdownsData = try encoder.encode(countdowns)
            
            try countdownsData.write(to: countdownsURL)
        } catch {
            print("Error saving data: \(error).")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let countdownsURL = countdownURL else { return }
            
            let countdownsData = try Data(contentsOf: countdownsURL)
            
            let decoder = PropertyListDecoder()
            
            let countdownsArray = try decoder.decode([Countdown].self, from: countdownsData)
            
            self.countdowns = countdownsArray
        } catch {
            print("Error loading data from plist: \(error).")
        }
    }
}
