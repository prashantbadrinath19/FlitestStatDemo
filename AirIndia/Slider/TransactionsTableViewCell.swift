//
//  TransactionsTableViewCell.swift
//  AirIndia
//
//  Created by Cheeja on 6/18/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import UIKit

class TransactionsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblFlightNo: UILabel!
    @IBOutlet weak var lblSource: UILabel!
    @IBOutlet weak var lblDest: UILabel!
    @IBOutlet weak var lblSchedule: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
