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
    
    weak var delegate: CountdownDelegate?
    
    var countdownController: CountdownController?
    
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
        
        guard let eventDate = eventDate else { return }
        
        let eventTime = eventDate.timeIntervalSinceNow
        countdownNameLabel.text = countdown.eventName
        countdownLabel.text = formatter.string(from: eventTime)
        
    }
}

extension CountdownTableViewCell: CountdownDelegate {
    func countdownUpdate(date: Date) {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.includesApproximationPhrase = false
        formatter.includesTimeRemainingPhrase = false
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        eventDate = date
        countdownLabel.text = formatter.string(from: date.timeIntervalSinceNow)
        
    }
    
   
}
