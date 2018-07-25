//
//  CalendarViewController.swift
//  AirIndia
//
//  Created by Cheeja on 6/13/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import UIKit
import JTAppleCalendar

@objc protocol pickDateDelegate {
    func updateDepartDate(departDate: String)
    func updateReturnDate(returnDate: String)
    func getCurrentDate(currDate: String)
}

class CalendarViewController: UIViewController {
    
    var delegateDate: pickDateDelegate?
    var departSelectTag: Int?
    var returnSelectTag: Int?
    var currentDate: Date?
   
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCalendarView()
        // Do any additional setup after loading the view.
    }
    
    func setUpCalendarView() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        calendarView.visibleDates { (visibleDates) in
            self.setUpViewsOfCalendar(from: visibleDates)
        }
    }
    
    func setUpViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first?.date
        formatter.dateFormat = "YYYY"
        lblYear.text = formatter.string(from: date!)
        formatter.dateFormat = "MMMM"
        lblMonth.text = formatter.string(from: date!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDone(_ sender: Any) {
        formatter.dateFormat = "MM-dd-YYYY"
        let pickedDate = formatter.string(from: currentDate!)
        delegateDate?.updateDepartDate(departDate: pickedDate)
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}

extension CalendarViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "YYYY/MM/dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        let startDate = formatter.date(from: "2018/06/01")
        let endDate = formatter.date(from: "2020/12/31")
        let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarViewCell
        cell.lblDate.text = cellState.text
        if cellState.isSelected {
            cell.selectedView.isHidden = false
        } else {
            cell.selectedView.isHidden = true
        }
        
        if cellState.dateBelongsTo == .thisMonth {
            cell.lblDate.textColor = UIColor.white
        } else {
            cell.lblDate.textColor = UIColor.gray
        }
        return cell
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CalendarViewCell else {
            return
        }
        validCell.selectedView.isHidden = false
        self.currentDate = date
        formatter.dateFormat = "YYYY/MM/dd"
        let pickDate = formatter.string(from: currentDate!)
        delegateDate?.getCurrentDate(currDate: pickDate)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CalendarViewCell else {
            return
        }
        validCell.selectedView.isHidden = true
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setUpViewsOfCalendar(from: visibleDates)
    }
}
