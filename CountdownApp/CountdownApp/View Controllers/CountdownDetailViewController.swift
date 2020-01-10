//
//  CountdownDetailViewController.swift
//  CountdownApp
//
//  Created by Michael on 1/9/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class CountdownDetailViewController: UIViewController {

    var timer: Timer?
    
    var countdownController: CountdownController?
    
    var countdown: Countdown?
    
    var eventDate: Date?
    
    var dateComponentFormatter: DateComponentsFormatter = {
        let componentFormatter = DateComponentsFormatter()
        componentFormatter.unitsStyle = .full
        componentFormatter.includesApproximationPhrase = false
        componentFormatter.includesTimeRemainingPhrase = false
        componentFormatter.allowedUnits = [.second, .minute, .hour, .day, .month, .year]
        return componentFormatter
    }()
    
    @IBOutlet weak var countdownNameLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
//        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: updateViews())
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(refreshCountdown), userInfo: nil, repeats: true)
    }
    
    @objc func refreshCountdown() {
        updateViews()
    }
    
    
    func updateViews() {

            guard let countdown = countdown, let eventDate = eventDate else { return }
            
            let eventTime = eventDate.timeIntervalSinceNow
                    
            if eventTime >= 0 {
                countdownLabel.text = dateComponentFormatter.string(from: eventTime)
                countdownNameLabel.text = "Countdown until... \n \(countdown.eventName)"
            } else {
                countdownLabel.text = dateComponentFormatter.string(from: abs(eventTime))
                countdownNameLabel.text = "Time Since... \(countdown.eventName)"
            }
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
