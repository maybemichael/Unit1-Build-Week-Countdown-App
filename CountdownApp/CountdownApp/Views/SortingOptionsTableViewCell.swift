//
//  SortingOptionsTableViewCell.swift
//  CountdownApp
//
//  Created by Michael on 1/9/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit

class SortingOptionsTableViewCell: UITableViewCell {

    @IBOutlet weak var sortingOptionsLabel: UILabel!
    
    var countdownController: CountdownController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func sortingSwitchToggled(_ sender: Any) {
        countdownController?.sorting.sortByDate.toggle()
        guard let sortedCountdown = countdownController?.countdowns else { return }
        countdownController?.sortCountdowns(array: sortedCountdown)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
