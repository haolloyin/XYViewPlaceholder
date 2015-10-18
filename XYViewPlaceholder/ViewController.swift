//
//  ViewController.swift
//  XYViewPlaceholder
//
//  Created by hao on 10/18/15.
//  Copyright © 2015 hao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var placeholderVisible = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        let superView = UIView.init(frame: CGRectMake(0, 0, width, height / 2 + 30))
        superView.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(superView)
        
        self.addViewWith(superView, frame: CGRectMake(20, 80, 40, 40), color: UIColor.greenColor())
        self.addViewWith(superView, frame: CGRectMake(20, 125, 40, 40), color: UIColor.grayColor())
        self.addViewWith(superView, frame: CGRectMake(65, 80, 80, 80), color: UIColor.greenColor())
        self.addViewWith(superView, frame: CGRectMake(165, 80, 140.6, 182.3), color: UIColor.redColor())
        // show all subviews
        superView.showPlaceholderWithAllSubviews()
        
        
        let imageView = UIImageView.init(frame: CGRectMake(20, height/2 + 40, 100, 100))
        imageView.image = UIImage.init(named: "avatar.png")
        self.view.addSubview(imageView)
        imageView.showPlaceholderWith(UIColor.redColor())
        
        
        let button = UIButton.init(frame: CGRectMake(width/2 + 10, height/2 + 40, 100.5, 80.5))
        button.backgroundColor = UIColor.greenColor()
        self.view.addSubview(button)
        button.showPlaceholderWith(UIColor.whiteColor(), backColor: UIColor.greenColor(), arrowSize: 10, lineWidth: 2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private
    
    func addViewWith(superView: UIView, frame: CGRect, color: UIColor) {
        let v = UIView.init(frame: frame)
        v.backgroundColor = color;
        superView.addSubview(v)
    }
    
    @IBAction func hideOrShow(sender: AnyObject) {
        print("placeholderVisible=\(self.placeholderVisible)")
        
        if self.placeholderVisible {
            self.placeholderVisible = false
            self.view.removePlaceholderWithAllSubviews()
        }
        else {
            self.placeholderVisible = true
            self.view.showPlaceholderWithAllSubviews()
        }
    }
}

