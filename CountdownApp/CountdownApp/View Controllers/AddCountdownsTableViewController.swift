//
//  AddCountdownsTableViewController.swift
//  CountdownApp
//
//  Created by Michael on 1/9/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class AddCountdownsTableViewController: UITableViewController {


    
    @IBOutlet weak var countdownNameTextField: UITextField!
    @IBOutlet weak var dateInputTextField: UITextField!
    
    @IBOutlet weak var timeInputTextField: UITextField!
    
    

    var countdownController: CountdownController?

    var countdown: Countdown?

    var timeComponentDate = Date()
    
    var dateComponentDate = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.dateInputTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        self.timeInputTextField.setInputViewDatePicker2(target: self, selector: #selector(tapDone2))
    
    }
    
    
    
    @IBAction func doneTapped(_ sender: Any) {
        guard let name = countdownNameTextField.text, let dateString = dateInputTextField.text, let timeString = timeInputTextField.text, !name.isEmpty, !dateString.isEmpty, !timeString.isEmpty else { return }
        
        guard let combinedDate = countdownController?.getEventDate(date: dateComponentDate, time: timeComponentDate) else { return }
        
        countdownController?.createCountdown(name: name, date: combinedDate)

        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func tapDone() {
        if let datePicker = self.dateInputTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeZone = .current
            self.dateInputTextField.text = dateFormatter.string(from: datePicker.date)
            dateComponentDate = datePicker.date
            print("This is the dateString... \(dateComponentDate)")
        }
        
        self.dateInputTextField.resignFirstResponder()
    }
    
    @objc func tapDone2() {
        if let datePicker = self.timeInputTextField.inputView as? UIDatePicker {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = .current
        self.timeInputTextField.text = dateFormatter.string(from: datePicker.date)
            timeComponentDate = datePicker.date
        }
        self.timeInputTextField.resignFirstResponder()
    }
}
