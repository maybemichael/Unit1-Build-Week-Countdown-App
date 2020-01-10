//
//  CountdownHomeTableViewController.swift
//  CountdownApp
//
//  Created by Michael on 1/6/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

protocol CountdownDelegate: AnyObject {
    func countdownUpdate(time: TimeInterval)
}

class CountdownHomeTableViewController: UITableViewController {

    let countdownController = CountdownController()
    
    var timer: Timer?
    
    var eventDate: Date?
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
        
    
    var remainingTimeInterval: TimeInterval {
        var timeRemaining: TimeInterval = 0
        if let eventDate = eventDate {
            timeRemaining = eventDate.timeIntervalSinceNow
        }
        return timeRemaining
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countdownController.loadFromPersistentStore()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(refreshCountdowns), userInfo: nil, repeats: true)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        updateViews()
        print("\(countdownController.countdowns)")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countdownController.countdowns.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountdownCell", for: indexPath) as? CountdownsTableViewCell else { return UITableViewCell()}

        // Configure the cell...
        let countdown = countdownController.countdowns[indexPath.row]
        cell.countdown = countdown
        let eventDate = countdown.date
        cell.eventDate = eventDate
        
        return cell
    }
    
    @objc func refreshCountdowns() {
        for visibleCell in tableView.visibleCells {
            guard let cell = visibleCell as? CountdownsTableViewCell else { continue }
            cell.updateViews()
        }
    }
    
    func updateViews() {
        tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            countdownController.deleteCountdown(countdown: countdownController.countdowns[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
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

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddCountdownSegue" {
            guard let addCountdownVC = segue.destination as? AddCountdownsTableViewController else { return }
            addCountdownVC.countdownController = countdownController
        } else if segue.identifier == "CountdownDetailSegue" {
            guard let countdownDetailVC = segue.destination as? CountdownDetailViewController else { return }
            countdownDetailVC.countdownController = countdownController
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedCountdown = countdownController.countdowns[indexPath.row]
                countdownDetailVC.countdown = selectedCountdown
                countdownDetailVC.eventDate = countdownController.countdowns[indexPath.row].date
            }
        } else if segue.identifier == "CountdownSettingsSegue" {
            guard let countdownSettingsVC = segue.destination as? CountdownSettingsTableViewController else { return }
            countdownSettingsVC.countdownController = countdownController
        }
    }
}



