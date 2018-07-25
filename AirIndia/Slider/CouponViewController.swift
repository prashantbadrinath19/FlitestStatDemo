//
//  CouponViewController.swift
//  AirIndia
//
//  Created by Cheeja on 6/17/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import UIKit
import ARSPopover

class CouponViewController: BaseViewController, UIScrollViewDelegate {
    
    var pageNumber: CGFloat?
    var images: [String] = ["Coupon1", "Coupon2", "Coupon3", "Coupon4"]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        singleTap.cancelsTouchesInView = false
        singleTap.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(singleTap)

        
        pageControl.numberOfPages = images.count
        for index in 0..<images.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            let imgView = UIImageView(frame: frame)
            imgView.image = UIImage(named: images[index])
            self.scrollView.addSubview(imgView)
        }
        
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(images.count)), height: scrollView.frame.size.height)
        scrollView.delegate = self
        
    }
    
    @objc func handleTap() {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "CouponDetailViewController") as? CouponDetailViewController {
            controller.couponNo = pageControl.currentPage
            present(controller, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber!)
        
    }
    
    
}
