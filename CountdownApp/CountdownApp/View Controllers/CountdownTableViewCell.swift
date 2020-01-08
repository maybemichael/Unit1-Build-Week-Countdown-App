//
//  CountdownTableViewCell.swift
//  CountdownApp
//
//  Created by Michael on 1/7/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class CountdownTableViewCell: UITableViewCell {

    @IBOutlet weak var countdownNameLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    
    var dateFormatter: DateFormatter = {
      let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
      return formatter
    }()
    
    var eventDate: Date? {
        didSet {
            updateViews()
        }
    }
    
    var countdown: Countdown? {
        didSet {
            updateViews()
        }
    }

    func updateViews() {
        guard let countdown = countdown else { return }
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.includesApproximationPhrase = false
        formatter.includesTimeRemainingPhrase = false
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.calendar = .current
        
        guard let eventDate = eventDate else { return }
        
        let eventTime = eventDate.timeIntervalSinceNow
        countdownNameLabel.text = "Until \(countdown.eventName)"
        
        
        
        switch eventTime {
        case 1...59:
            formatter.allowedUnits = [.second]
            countdownLabel.text = formatter.string(from: eventTime)
        case 60...3599:
            formatter.allowedUnits = [.second, .minute]
            countdownLabel.text = formatter.string(from: eventTime)
        case 3600...86399:
            formatter.allowedUnits = [.second, .minute, .hour]
            countdownLabel.text = formatter.string(from: eventTime)
        case 86400...2764799:
            formatter.allowedUnits = [.day, .weekOfMonth, .month]
            countdownLabel.text = formatter.string(from: eventTime)
        case 2764800...33177599:
            formatter.allowedUnits = [.day, .weekOfMonth, .month, .year]
            countdownLabel.text = formatter.string(from: eventTime)
        case 33177600...1990656000:
            formatter.allowedUnits = [.month, .year]
            countdownLabel.text = formatter.string(from: eventTime)
        default:
            formatter.allowedUnits = [.second, .minute, .hour, .day, .month, .year]
            countdownLabel.text = formatter.string(from: eventTime)
        }
    }
}

extension CountdownTableViewCell: CountdownDelegate {
    func countdownUpdate(time: TimeInterval) {
        updateViews()
    }
}
