//
//  AddCountdownTableViewController.swift
//  CountdownApp
//
//  Created by Michael on 1/6/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class AddCountdownTableViewController: UITableViewController {

    @IBOutlet weak var countdownNameTextField: UITextField!
    @IBOutlet weak var dateInputTextField: UITextField!
    @IBOutlet weak var timeInputTextField: UITextField!

    var countdownController: CountdownController?

    var countdown: Countdown?

    var combinedDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dateInputTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        self.timeInputTextField.setInputViewDatePicker2(target: self, selector: #selector(tapDone2))

    }

    @IBAction func doneTapped(_ sender: Any) {
        guard let name = countdownNameTextField.text, let dateString = dateInputTextField.text, let timeString = timeInputTextField.text, !name.isEmpty, !dateString.isEmpty, !timeString.isEmpty else { return }
        var updatedDate: Date?
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.timeStyle = .short
        if let date = dateFormatter.date(from: dateString), let time = dateFormatter.date(from: timeString) {
            updatedDate = countdownController?.getEventDate(date: date, time: time)
        }
        combinedDate = updatedDate
        countdownController?.createCountdown(name: name, date: combinedDate ?? Date())

        navigationController?.popToRootViewController(animated: true)
    }



    @objc func tapDone() {
        if let datePicker = self.dateInputTextField.inputView as? UIDatePicker {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = .current
        self.dateInputTextField.text = dateFormatter.string(from: datePicker.date)
        }
        self.dateInputTextField.resignFirstResponder()
    }

    @objc func tapDone2() {
        if let datePicker = self.timeInputTextField.inputView as? UIDatePicker {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = .current
        datePicker.countDownDuration = .infinity
        self.timeInputTextField.text = dateFormatter.string(from: datePicker.date)
        }
        self.timeInputTextField.resignFirstResponder()
    }
}

// MARK: - Table view data source
/*
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    */

    /*
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    

