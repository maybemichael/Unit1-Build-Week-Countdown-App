//
//  CountdownsTableViewCell.swift
//  CountdownApp
//
//  Created by Michael on 1/9/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class CountdownsTableViewCell: UITableViewCell {

    @IBOutlet weak var countdownNameLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    
    var dateFormatter: DateFormatter = {
          let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            formatter.timeZone = .current
          return formatter
        }()
        
        var dateComponentFormatter = DateComponentsFormatter()
            
        var dateString: String?
        
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
            dateComponentFormatter.unitsStyle = .full
            dateComponentFormatter.includesApproximationPhrase = false
            dateComponentFormatter.includesTimeRemainingPhrase = false
            
            let eventTime = countdown.date.timeIntervalSinceNow
            if eventTime > 0 {
                countdownNameLabel.text = "Time until \n \(countdown.eventName)"
            }
            
            switch eventTime {
            case 1...59:
                dateComponentFormatter.allowedUnits = [.second]
                countdownLabel.text = dateComponentFormatter.string(from: eventTime)
            case 60...3599:
                dateComponentFormatter.allowedUnits = [.second, .minute]
                countdownLabel.text = dateComponentFormatter.string(from: eventTime)
            case 3600...86399:
                dateComponentFormatter.allowedUnits = [.second, .minute, .hour]
                countdownLabel.text = dateComponentFormatter.string(from: eventTime)
            case 86400...2764799:
                dateComponentFormatter.allowedUnits = [.day, .month]
                countdownLabel.text = dateComponentFormatter.string(from: eventTime)
            case 2764800...33177599:
                dateComponentFormatter.allowedUnits = [.day, .month, .year]
                countdownLabel.text = dateComponentFormatter.string(from: eventTime)
            case 33177600...1990656000:
                dateComponentFormatter.allowedUnits = [.month, .year]
                countdownLabel.text = dateComponentFormatter.string(from: eventTime)
            default:
                dateComponentFormatter.allowedUnits = [.second, .minute, .hour, .day, .month, .year]
                countdownLabel.text = dateComponentFormatter.string(from: abs(eventTime))
                countdownNameLabel.text = "Time since \n \(countdown.eventName)"
            }
        }
    }
