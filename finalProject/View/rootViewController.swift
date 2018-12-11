//
//  rootViewController.swift
//  finalProject
//
//  Created by Alyssa Jo Tice on 10/7/18.
//  Copyright © 2018 Alyssa Jo Tice. All rights reserved.
//

import UIKit

class rootViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //var parkCaptionModel = captionModel.sharedInstance
    var pageViewController : UIPageViewController?
    var pageControl = UIPageControl()
    var currentIndex = 0
    var lastPendingViewControllerIndex = 0
    var startButton = UIButton()
    let cModel = colorModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "rootViewController") as! rootViewController
        UIApplication.shared.keyWindow?.rootViewController = viewController;
        
        //First, create an instance of the page view controller
        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "pageViewController") as? UIPageViewController
        
        pageViewController!.dataSource = self
        pageViewController!.delegate = self
        
        let firstPage = contentController(at:0)
        pageViewController!.setViewControllers([firstPage], direction: .forward, animated: false, completion: nil)
        
        self.addChild(pageViewController!)
        pageViewController?.didMove(toParent: self)
        self.view.addSubview(pageViewController!.view)
        
        configureStartButton()
        configurePageControl()
    }
    
    //reload the layout when we switch orientations
    override func viewDidLayoutSubviews() {
        startButton.center = CGPoint(x: (self.view.bounds.width/2), y: (self.view.bounds.height*0.8))
        pageControl.center = CGPoint(x: (self.view.bounds.width/2), y: (self.view.bounds.height*0.95))
    }
    
    //switch scenes when the user presses start
    @objc func buttonAction(sender: UIButton!) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "startPage") as UIViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = 5 //EDIT
        self.pageControl.currentPage = 0
        self.pageControl.alpha = 0.8
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.view.addSubview(pageControl)
    }
    
    func configureStartButton(){
        startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 125, height: 50))
        startButton.backgroundColor = #colorLiteral(red: 0.9671540856, green: 0.6349585652, blue: 0.7611256242, alpha: 1)
        startButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .disabled)
        startButton.center = CGPoint(x: (self.view.bounds.width/2), y: (self.view.bounds.height*0.9))
        startButton.layer.cornerRadius = 5
        startButton.setTitle("Start App", for: .normal)
        startButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        startButton.isEnabled = true
        self.view.addSubview(startButton)
        self.view.bringSubviewToFront(startButton)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]){
        
        if let viewController = pendingViewControllers[0] as? tutorialViewController {
            self.lastPendingViewControllerIndex = viewController.pageIndex!
        }
    }
    
    func contentController(at index:Int) -> tutorialViewController {
        
        let content = self.storyboard?.instantiateViewController(withIdentifier: "tutorialViewController") as! tutorialViewController
        
        content.pageIndex = index
        
        let title = (cModel.picturePrefix()) + String(index+1) + ".png"
        content.configure(with: title)
        return content
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let contentViewController = viewController as! tutorialViewController
        let index = contentViewController.pageIndex!
        
        //if false, return nil
        guard index > 0 else {return nil}
        
        let newController =  contentController(at: index-1)
        return newController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let contentViewController = viewController as! tutorialViewController
        let index = contentViewController.pageIndex!
        guard index < (5-1/*NUMBER OF TUTORIAL pagES*/) else {return nil}
        let newController =  contentController(at: index+1)
        return newController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if (!completed){
            return
        }
        else{
            self.currentIndex = lastPendingViewControllerIndex
            self.pageControl.currentPage = self.currentIndex
            startButton.isEnabled = true

        }
    }
    
    //delegate methods
    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewController.SpineLocation {
        if (orientation == .portrait) || (orientation == .portraitUpsideDown) || (UIDevice.current.userInterfaceIdiom == .phone) {
            // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to true, so set it to false here.
            let currentViewController = self.pageViewController!.viewControllers![0]
            let viewControllers = [currentViewController]
            self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in })
            
            self.pageViewController!.isDoubleSided = false
            return .min
        }
        
        // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
        let currentViewController = self.pageViewController!.viewControllers![0] as! tutorialViewController
        var viewControllers: [UIViewController]
        
        let indexOfCurrentViewController = currentViewController.pageIndex!
        if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
            let nextViewController = self.pageViewController(self.pageViewController!, viewControllerAfter: currentViewController)
            viewControllers = [currentViewController, nextViewController!]
        } else {
            let previousViewController = self.pageViewController(self.pageViewController!, viewControllerBefore: currentViewController)
            viewControllers = [previousViewController!, currentViewController]
        }
        self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })
        
        return .mid
    }
}
