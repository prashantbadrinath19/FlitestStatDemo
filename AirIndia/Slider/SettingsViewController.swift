//
//  SettingsViewController.swift
//  AirIndia
//
//  Created by Cheeja on 6/13/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import UIKit
import FirebaseAuth
import ECSlidingViewController

class SettingsViewController: UIViewController {
    
    var settingsArr = ["Account", "Privacy and Security", "Notifications", "Support", "About", "Logout"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.slidingViewController().topViewAnchoredGesture = [ECSlidingViewControllerAnchoredGesture.tapping, ECSlidingViewControllerAnchoredGesture.panning]
        self.slidingViewController().anchorLeftPeekAmount = 70
        self.edgesForExtendedLayout = [UIRectEdge.top, UIRectEdge.bottom, UIRectEdge.left]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell")
        cell?.textLabel?.text = settingsArr[indexPath.row]
        cell?.textLabel?.textColor = UIColor.white
        cell?.textLabel?.textAlignment = .right
        return cell!
    }
    
    private func destroyToLogin() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        guard let rootViewController = window.rootViewController else {
            return
        }
        
        let authStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = authStoryboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        
        vc.view.frame = rootViewController.view.frame
        vc.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = vc
        }, completion: { completed in
            rootViewController.dismiss(animated: true, completion: nil)
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == settingsArr.index(of: "Logout") {
            do{
                try Auth.auth().signOut()
                destroyToLogin()
            } catch{
                print("error")
            }
        }
    }
}
