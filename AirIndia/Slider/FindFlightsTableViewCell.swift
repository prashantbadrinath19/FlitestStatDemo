//
//  FindFlightsTableViewCell.swift
//  AirIndia
//
//  Created by Cheeja on 6/15/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import UIKit

class FindFlightsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblFlightNo: UILabel!
    @IBOutlet weak var lblDepartureCode: UILabel!
    @IBOutlet weak var lblArrivalCode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
