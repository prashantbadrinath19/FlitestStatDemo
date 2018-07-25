//
//  FTNavigationController.swift
//  AirIndia
//
//  Created by Prashant  Badrinath on 6/11/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import UIKit

class FTNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = false
        self.setupAppereance(UIColor.white, textColor: UIColor.white, barStyle: UIBarStyle.black)
        if let gesture = self.slidingViewController()?.panGesture {
            gesture.cancelsTouchesInView = false
            self.view.addGestureRecognizer(gesture)
        }
    }
        
        func setupAppereance(_ tintColor: UIColor, textColor: UIColor, barStyle: UIBarStyle) {
            let font  = UIFont(name: "Helvetica neue", size: 18)!
            self.navigationBar.barStyle = barStyle
            self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : textColor, NSAttributedStringKey.font : font]
            self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationBar.barTintColor = tintColor
            self.navigationBar.tintColor = tintColor
            if let gesture = self.slidingViewController()?.panGesture {
                gesture.cancelsTouchesInView = false
                self.view.addGestureRecognizer(gesture)
            }
            self.navigationBar.shadowImage = UIImage()
        }
        
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
