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
    
    var checkedCell: UITableViewCell?
    
//    var checkedIndex: IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        
    
        if tableView.cellForRow(at: indexPath) != checkedCell {
            if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.none {
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
                checkedCell?.accessoryType = .none
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
                checkedCell?.accessoryType = .checkmark
            }
        }

        
        
        tableView.reloadData()
        guard let sortByDateCell = tableView.cellForRow(at: indexPath) else { return }
        
        sortCountdowns(cell: sortByDateCell)
        }
    
    func sortCountdowns(cell: UITableViewCell) {
        if cell.accessoryType == .checkmark {
            countdownController?.sortingByDate = true
        } else {
            countdownController?.sortingByDate = false
        }
    }
}


