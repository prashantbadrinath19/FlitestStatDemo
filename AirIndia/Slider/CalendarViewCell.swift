//
//  CalendarViewCell.swift
//  AirIndia
//
//  Created by Cheeja on 6/13/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarViewCell: JTAppleCell {
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var selectedView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedView.layer.cornerRadius = selectedView.frame.size.height/2
        selectedView.layer.borderWidth = 1.0
        selectedView.layer.borderColor = UIColor.white.cgColor
    }
}
