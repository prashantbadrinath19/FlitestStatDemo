//
//  SideMenuViewController.swift
//  AirIndia
//
//  Created by Prashant  Badrinath on 6/11/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import UIKit
import ECSlidingViewController

class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var menuItems = ["Flight Search", "Coupon Cards", "Transaction Details", "User Profile", "Reminder Checkist", "iWatch"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.slidingViewController().topViewAnchoredGesture = [ECSlidingViewControllerAnchoredGesture.tapping, ECSlidingViewControllerAnchoredGesture.panning]
        self.slidingViewController().anchorRightPeekAmount = 70
        self.edgesForExtendedLayout = [UIRectEdge.top, UIRectEdge.bottom, UIRectEdge.left]

        // Do any additional setup after loading the view.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            slidingViewController().topViewController = storyboard.instantiateViewController(withIdentifier: "HomeNavigationViewController")
            slidingViewController().resetTopView(animated: true)
            
        } else  if indexPath.row == 1 {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            slidingViewController().topViewController = storyboard.instantiateViewController(withIdentifier: "CouponNavigationController")
            slidingViewController().resetTopView(animated: true)
            
        } else  if indexPath.row == 2 {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            slidingViewController().topViewController = storyboard.instantiateViewController(withIdentifier: "TransactionNavigationController")
            slidingViewController().resetTopView(animated: true)
            
        } else  if indexPath.row == 3 {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            slidingViewController().topViewController = storyboard.instantiateViewController(withIdentifier: "UserNavigationController")
            slidingViewController().resetTopView(animated: true)
            
        } else  if indexPath.row == 4 {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            slidingViewController().topViewController = storyboard.instantiateViewController(withIdentifier: "ReminderNavigationController")
            slidingViewController().resetTopView(animated: true)
            
        } else  if indexPath.row == 5 {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            slidingViewController().topViewController = storyboard.instantiateViewController(withIdentifier: "iWatchNavigationController")
            slidingViewController().resetTopView(animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
