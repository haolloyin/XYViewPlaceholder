//
//  XYViewPlaceholder.swift
//  XYViewPlaceholder
//
//  Created by hao on 10/17/15.
//  Copyright © 2015 hao. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

struct XYViewPlaceholderConfig
{
    
    var lineColor = UIColor.blueColor()
    var backgroundColor = UIColor.clearColor()
    var arrowSize: CGFloat = 5.0
    var lineWidth: CGFloat = 1.0
    var frameColor = UIColor.redColor()
    var frameWidth: CGFloat = 0.0
    
    var showArrow = true
    var showText = true
    
    var visibleKindOfClasses = [AnyClass]()
    var visibleMemberOfClasses = [AnyClass]()
    private let defaultMemberOfClasses = [
        UIImageView.self,
        UIButton.self,
        UILabel.self,
        UITextField.self,
        UITextView.self,
        UISwitch.self,
        UISlider.self,
        UIPageControl.self
    ]
    
    var autoDisplay = false
    var visible = true {
        didSet {
            let delegate = UIApplication.sharedApplication().delegate
            
            if !visible {
                delegate?.window?!.hidePlaceholderWithAllSubviews()
            }
            else {
                delegate?.window?!.showPlaceholderWithAllSubviews()
            }
        }
    }
    
    // singleton
    static let defaultConfig = XYViewPlaceholderConfig()
}


extension String
{
    func heightWith(font: UIFont, width: CGFloat, lineBreakMode: NSLineBreakMode) -> CGSize {
        let label = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = lineBreakMode
        label.font = font
        label.text = self
        
        label.sizeToFit()
        
        return label.frame.size
    }
}


class XYViewPlaceholder: UIView
{
    var lineColor = XYViewPlaceholderConfig.defaultConfig.lineColor
    var backColor = XYViewPlaceholderConfig.defaultConfig.backgroundColor
    var arrowSize = XYViewPlaceholderConfig.defaultConfig.arrowSize
    var lineWidth = XYViewPlaceholderConfig.defaultConfig.lineWidth
    var frameColor = XYViewPlaceholderConfig.defaultConfig.frameColor {
        didSet {
            self.layer.borderColor = frameColor.CGColor
        }
    }
    var frameWidth = XYViewPlaceholderConfig.defaultConfig.frameWidth {
        didSet {
            self.layer.borderWidth = CGFloat(frameWidth)
        }
    }
    
    var showArrow = XYViewPlaceholderConfig.defaultConfig.showArrow
    var showText = XYViewPlaceholderConfig.defaultConfig.showText
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.backgroundColor = UIColor.clearColor()
        self.contentMode = .Redraw
        self.userInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let width = rect.size.width
        let height = rect.size.height
        
        let fontSize = 4 + min(width, height) / 20
        let arrowSize = CGFloat(self.arrowSize)
        let lineWidth = CGFloat(self.lineWidth)
        
        let font = UIFont.systemFontOfSize(fontSize)
        
        print("fame=\(self.frame), width=\(width), height=\(height), arrowSize=\(arrowSize), fontSize=\(fontSize)")
        
        // fill the back
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(ctx, self.backColor.CGColor);
        CGContextFillRect(ctx, rect);
        
        if self.showArrow {
            // strike lines & arrows
            CGContextSetLineWidth(ctx, lineWidth);
            CGContextSetStrokeColorWithColor(ctx, self.lineColor.CGColor);
            
            CGContextMoveToPoint(ctx, width/2, 0);
            CGContextAddLineToPoint(ctx, width/2, height);
            CGContextMoveToPoint(ctx, width/2, 0);
            CGContextAddLineToPoint(ctx, width/2 - arrowSize, arrowSize);
            CGContextMoveToPoint(ctx, width/2, 0);
            CGContextAddLineToPoint(ctx, width/2+arrowSize, arrowSize);
            CGContextMoveToPoint(ctx, width/2, height);
            CGContextAddLineToPoint(ctx, width/2-arrowSize, height-arrowSize);
            CGContextMoveToPoint(ctx, width/2, height);
            CGContextAddLineToPoint(ctx, width/2+arrowSize, height-arrowSize);
            
            CGContextMoveToPoint(ctx, 0, height/2);
            CGContextAddLineToPoint(ctx, width, height/2);
            CGContextMoveToPoint(ctx, 0, height/2);
            CGContextAddLineToPoint(ctx, arrowSize, height/2-arrowSize);
            CGContextMoveToPoint(ctx, 0, height/2);
            CGContextAddLineToPoint(ctx, arrowSize, height/2+arrowSize);
            CGContextMoveToPoint(ctx, width, height/2);
            CGContextAddLineToPoint(ctx, width-arrowSize, height/2-arrowSize);
            CGContextMoveToPoint(ctx, width, height/2);
            CGContextAddLineToPoint(ctx, width-arrowSize, height/2+arrowSize);
            
            CGContextStrokePath(ctx);
        }
        
        if self.showText && width >= 50 {
            // calculate the text area
            let strLabel = "\(width) x \(height)"
            let labelSize = strLabel.heightWith(font, width:CGFloat.max, lineBreakMode: .ByClipping)
            
            let rectWidth = labelSize.width + 4
            let rectHeight = labelSize.height + 4
            
            print("w=\(rectWidth), h=\(rectHeight)")
            
            // clear the area behind the textz
            let strRect = CGRectMake(width/2 - rectWidth/2, height/2 - rectHeight/2, rectWidth, rectHeight)
            CGContextClearRect(ctx, strRect);
            CGContextSetFillColorWithColor(ctx, self.backColor.CGColor);
            CGContextFillRect(ctx, strRect);
            
            // draw text
            CGContextSetFillColorWithColor(ctx, self.lineColor.CGColor);
            let textLabel: NSString = strLabel
            let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
            textStyle.alignment = NSTextAlignment.Center
            textStyle.lineBreakMode = NSLineBreakMode.ByTruncatingMiddle
            let textFontAttributes = [
                NSFontAttributeName: font,
                NSForegroundColorAttributeName: UIColor.blueColor(),
                NSParagraphStyleAttributeName: textStyle
            ]
            
            textLabel.drawInRect(CGRectInset(strRect, 0, 2), withAttributes: textFontAttributes)
        }
    }
}


extension UIView
{
    public override class func initialize() {
        struct Static {
            static var token: dispatch_once_t = 0
        }
        
        func xy_swizzleSelector(originalSelector:Selector, swizzledSelector:Selector) {
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            
            let didAddMethod = class_addMethod(self,
                originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
            
            if didAddMethod {
                class_replaceMethod(self,
                    swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
        
        dispatch_once(&Static.token) {
            xy_swizzleSelector(Selector("init"), swizzledSelector: Selector("xy_init"))
        }
    }
    
    // MARK: - Method Swizzling
    
    func xy_init() -> UIView {
        print("xy_init: \(self)")
        self.xy_init()
        
        return self
    }
    
    func xy_initWithFrame(frame: CGRect) -> UIView {
        print("xy_initWithFrame=\(frame)")
        self.xy_initWithFrame(frame)
        
        return self
    }
    
    // MARK: - Private
    
    private func checkAutoDisplay() {
        let config = XYViewPlaceholderConfig.defaultConfig
        
        if !self.isKindOfClass(XYViewPlaceholder.self) {
            if config.autoDisplay {
                if config.visibleMemberOfClasses.count > 0 {
                    for cls: AnyClass in config.visibleMemberOfClasses {
                        if self.isMemberOfClass(cls) {
                            self.showPlaceholder()
                            return
                        }
                    }
                }
                else if config.visibleKindOfClasses.count > 0 {
                    for cls: AnyClass in config.visibleKindOfClasses {
                        if self.isKindOfClass(cls) {
                            self.showPlaceholder()
                            return
                        }
                    }
                }
                else {
                    self.showPlaceholder()
                }
            }
        }
    }
    
    private func getPlaceholder() -> XYViewPlaceholder? {
        
        if self.hidden {
            return nil
        }
        
        let tag = XYViewPlaceholder.self.hash() + self.hashValue
        
        print("getPlaceholder: frame=\(self.frame), tag=\(tag)")
        
        if let placeholder = self.viewWithTag(tag) as? XYViewPlaceholder {
            return placeholder
        }
        else {
            let placeholder = XYViewPlaceholder.init(frame: self.bounds)
            return placeholder
        }
    }
    
    // MARK: - show
    
    func showPlaceholder() {
        self.showPlaceholderWith(XYViewPlaceholderConfig.defaultConfig.lineColor)
    }
    
    func showPlaceholderWith(lineColor: UIColor) {
        self.showPlaceholderWith(lineColor, backColor: XYViewPlaceholderConfig.defaultConfig.backgroundColor)
    }
    
    func showPlaceholderWith(lineColor: UIColor, backColor: UIColor) {
        let config = XYViewPlaceholderConfig.defaultConfig
        self.showPlaceholderWith(lineColor, backColor: backColor, arrowSize: config.arrowSize)
    }
    
    func showPlaceholderWith(lineColor: UIColor, backColor: UIColor, arrowSize: CGFloat) {
        let config = XYViewPlaceholderConfig.defaultConfig
        self.showPlaceholderWith(lineColor, backColor: backColor, arrowSize: arrowSize, lineWidth: config.lineWidth)
    }
    
    func showPlaceholderWith(lineColor: UIColor, backColor: UIColor, arrowSize: CGFloat, lineWidth: CGFloat) {
        let config = XYViewPlaceholderConfig.defaultConfig
        self.showPlaceholderWith(lineColor, backColor: backColor, arrowSize: arrowSize, lineWidth: lineWidth,
            frameWidth: config.frameWidth, frameColor: config.frameColor)
    }
    
    func showPlaceholderWith(lineColor: UIColor, backColor: UIColor, arrowSize: CGFloat, lineWidth: CGFloat, frameWidth: CGFloat, frameColor: UIColor) {
        #if RELEASE
            // do nothing
            #else
            if let placeholder = self.getPlaceholder() {
                placeholder.lineColor = lineColor
                placeholder.backColor = backColor
                placeholder.arrowSize = arrowSize
                placeholder.lineWidth = lineWidth
                placeholder.frameColor = frameColor
                placeholder.frameWidth = frameWidth
                
                placeholder.tag = XYViewPlaceholder.self.hash() + self.hashValue
                placeholder.hidden = !XYViewPlaceholderConfig.defaultConfig.visible
                
                self.addSubview(placeholder)
            }
        #endif
    }
    
    func showPlaceholderWithAllSubviews() {
        print("showPlaceholderWithAllSubviews")
        self.showPlaceHolderWithAllSubviewsWith(5)
    }
    
    func showPlaceHolderWithAllSubviewsWith(maxPath: UInt) {
        if maxPath > 0 {
            for v: UIView in self.subviews {
                v.showPlaceHolderWithAllSubviewsWith(maxPath - 1)
            }
        }
        self.showPlaceholder()
    }
    
    // MARK: - hide
    
    func hidePlaceholder() {
        if let placeholder = self.getPlaceholder() {
            placeholder.hidden = true
        }
    }
    
    func hidePlaceholderWithAllSubviews() {
        print("hidePlaceholderWithAllSubviews")
        
        for v: UIView in self.subviews {
            v.hidePlaceholderWithAllSubviews()
        }
        
        self.hidePlaceholder()
    }
    
    // MARK: - remove
    
    func removePlaceholder() {
        if let placeholder = self.getPlaceholder() {
            placeholder.removeFromSuperview()
        }
    }
    
    func removePlaceholderWithAllSubviews() {
        for v: UIView in self.subviews {
            v.removePlaceholderWithAllSubviews()
        }
        
        self.removePlaceholder()
    }
}
