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
    
//    override var accessoryType: UITableViewCell.AccessoryType = .none
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
}
