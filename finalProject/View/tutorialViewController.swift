//
//  tutorialViewController.swift
//  finalProject
//
//  Created by Alyssa Jo Tice on 10/7/18.
//  Copyright © 2018 Alyssa Jo Tice. All rights reserved.
//

/* Here, we are going to set up what we want the page control view to look like. With the single page and the walkthrough.
 */

import UIKit

class tutorialViewController: UIViewController {
    
    var pageIndex : Int?
    @IBOutlet weak var tutorialImage: UIImageView!
    var picName : String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tutorialImage.image = (UIImage(named: picName!))
    }
    
    func configure (with picTitle: String){
        self.picName = picTitle
    }
}
