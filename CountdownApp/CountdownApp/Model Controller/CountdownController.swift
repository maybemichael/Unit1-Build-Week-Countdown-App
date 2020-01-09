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
    
//    func getEventDate(countdown: Countdown) -> Date {
//        let date = countdown.date
//        let time = countdown.time
//        let components = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: countdown.date, to: countdown.time)
//        let components2 = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: Date(), to: countdown.date)
//        let components3 = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: Date(), to: countdown.time)
//        print("This should be difference between date and time... \(components)")
//        print("This should be difference between date2 and time2... \(components2)")
//        print("This should be difference between date3 and time3... \(components3)")
//        let countdownTime = date.timeIntervalSinceNow + time.timeIntervalSinceNow
//        print("This is the event date... \(countdownTime)")
//        let countdownDate = Date().addingTimeInterval(countdownTime)
//        return countdownDate
//        
//    }
    
    func getEventDate(countdown: Countdown) -> Date {
        let date = countdown.date
        let time = countdown.time
        let components = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: countdown.time, to: countdown.date)
        print("This is the difference between the two dates... \(components)")
        let updatedDate = date.addingTimeInterval(time.timeIntervalSinceNow)
        
        return updatedDate
        
    }
    
//    func getEventDate(date: Date, time: Date) -> Date {
//        var mergedComponents = DateComponents()
//        let calendar = Calendar.current
//        let dateComponents = calendar.dateComponents([.second, .minute, .hour, .day, .month, .year], from: date)
//        let timeComponents = calendar.dateComponents([.second, .minute, .hour], from: time)
//
//        mergedComponents.second = timeComponents.second
//        mergedComponents.minute = timeComponents.minute
//        mergedComponents.hour = timeComponents.hour
//        mergedComponents.day = dateComponents.day
//        mergedComponents.month = dateComponents.month
//        mergedComponents.year = dateComponents.year
//
//        guard let updatedEventDate = calendar.date(from: mergedComponents) else { return date }
//        return updatedEventDate
//    }
    
//    func getEventTimeInterval(countdown: Countdown) -> TimeInterval {
//        let calendar = Calendar.current
//        let mergedComponents = DateComponents()
//        var updatedTimeInterval: TimeInterval = 0
//        guard let time = countdown.time else { return 0}
//        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)
//        let updatedDate = calendar.date(byAdding: timeComponents, to: countdown.date)
//        if let updatedDate = updatedDate?.timeIntervalSinceNow {
//            updatedTimeInterval = updatedDate
//        } else {
//            updatedTimeInterval = countdown.date.timeIntervalSinceNow
//        }
//
//        return updatedTimeInterval
//    }
    
//    func getEventDate(countdown: Countdown) -> Date {
//        let date = countdown.date
//        print("Users selected date... \(date)")
//        let time = countdown.time ?? Date()
//        print("Users selected time... \(time)")
//        let timeTimeInterval = time.timeIntervalSinceNow
//        print("New time interval \(timeTimeInterval)")
//        let dateWithTime = date.addingTimeInterval(timeTimeInterval)
//        print("Updated date for countdown... \(dateWithTime)")
//        let countdownTime = Date(timeInterval: <#T##TimeInterval#>, since: <#T##Date#>
//        let countdownDate = Date().addingTimeInterval(countdownTime)
//        return countdownDate
//        return dateWithTime
//    }
    
    func createCountdown(name: String, date: Date, time: Date) {
        let countdown = Countdown(eventName: name, date: date, time: time)
        countdowns.append(countdown)
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: updateTimer(timer:))
//        print("How many timers are there?")
        saveToPersistentStore()
    }
    
    func deleteCountdown(countdown: Countdown) {
        guard let countdownToRemove = countdowns.firstIndex(of: countdown) else { return }
        countdowns.remove(at: countdownToRemove)
//        timer?.invalidate()
        
        saveToPersistentStore()
    }
    
//    func updateTimer(timer: Timer) {
//        let now = Date()
//        print("timer activated")
//        if let eventDate = eventDate {
//            if now <= eventDate {
//                delegate?.countdownUpdate(time: remainingTimeInterval)
//            }
//        }
//    }
    
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
