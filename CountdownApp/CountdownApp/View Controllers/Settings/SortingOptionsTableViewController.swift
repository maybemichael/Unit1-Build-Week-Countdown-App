//
//  SortingOptionsTableViewController.swift
//  CountdownApp
//
//  Created by Michael on 1/9/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class SortingOptionsTableViewController: UITableViewController {

    var countdownController: CountdownController?
    
//    var sortedByDate: Bool?
    
    var checkedCell2: UITableViewCell?
    
    var checkedCell: SortingOptionsTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkedCell?.accessoryType = .none
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SortingOptions.allCases.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SortingOptionsCell", for: indexPath) as? SortingOptionsTableViewCell else { return UITableViewCell()}

        let sortingOptions = SortingOptions(rawValue: indexPath.row)?.description
        cell.sortingOptionsLabel.text = sortingOptions
        
        cell.countdownController = countdownController
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.none{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        }

        tableView.reloadData()
        guard let sortByDateCell = tableView.cellForRow(at: indexPath) else { return }
        sortCountdowns(cell: sortByDateCell)
        
        guard let sortByDate = countdownController?.sortingByDate else { return }
        print(sortByDate)
        }
    
    func sortCountdowns(cell: UITableViewCell) {
        if cell.accessoryType == .checkmark {
            countdownController?.sortingByDate = true
        } else {
            countdownController?.sortingByDate = false
        }
    }
}

   
    
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


