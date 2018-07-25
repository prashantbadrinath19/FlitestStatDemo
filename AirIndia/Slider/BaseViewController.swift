//
//  BaseViewController.swift
//  AirIndia
//
//  Created by Prashant  Badrinath on 6/15/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import UIKit

//Hello Testing
class BaseViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftButton = UIButton(type: .system)
        leftButton.setImage(UIImage(named: "Menu"), for: .normal)
        leftButton.tintColor = UIColor.black
        leftButton.sizeToFit()
        leftButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftButton.addTarget(self, action: #selector(self.leftAction), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = leftButton
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let rightButton = UIButton(type: .system)
        rightButton.setImage(UIImage(named: "Settings"), for: .normal)
        rightButton.tintColor = UIColor.black
        rightButton.sizeToFit()
        rightButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        rightButton.addTarget(self, action: #selector(self.rightAction), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = rightButton
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func leftAction(){
        let slidingViewController = self.slidingViewController()
        if slidingViewController?.currentTopViewPosition == .centered {
            slidingViewController?.anchorTopViewToRight(animated: true)
        } else {
            slidingViewController?.resetTopView(animated: true)
        }
    }
    
    @objc func rightAction(){
        let slidingViewController = self.slidingViewController()
        if slidingViewController?.currentTopViewPosition == .centered {
            slidingViewController?.anchorTopViewToLeft(animated: true)
        } else {
            slidingViewController?.resetTopView(animated: true)
        }
    }
    
    
}


