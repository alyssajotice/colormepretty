//
//  testZoomViewController.swift
//  finalProject
//
//  Created by Alyssa Jo Tice on 12/1/18.
//  Copyright © 2018 Alyssa Jo Tice. All rights reserved.
//

import UIKit

class testZoomViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        
        //scrollView.contentSize = image.frame.size

        // Do any additional setup after loading the view.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return image
    }
    
}
