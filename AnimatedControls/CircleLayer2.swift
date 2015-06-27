//
//  CircleLayer2.swift
//  AnimatedControls
//
//  Created by David on 6/26/15.
//  Copyright (c) 2015 David. All rights reserved.
//

import Foundation
import AppKit
import QuartzCore

class CircleLayer2 : CAShapeLayer {
  
  @NSManaged var angleStart : CGFloat
  @NSManaged var angleEnd : CGFloat
  
  var center : CGPoint = CGPoint(x: 0, y: 0)
  var radius : CGFloat = 1
  
  
  // MARK: - Initializers
  init(radius: CGFloat) {
    
//    self.center = center
    self.radius = radius
    
    super.init()
  }
  
  override init!(layer: AnyObject!) {
    
    super.init(layer: layer)
    
    if layer.isKindOfClass(CircleLayer2) {
      var otherLayer = layer as! CircleLayer2
      radius = otherLayer.radius
//      center = otherLayer.center
      angleStart = otherLayer.angleStart
      angleEnd = otherLayer.angleEnd
    }
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Setup
  
  
  
  // MARK: - Drawing
//  override func drawInContext(ctx: CGContext!) {
//    println("drawing in circle layer")
//    
////    var radius : CGFloat = 95.0
////    var startAngle = angleStart
////    var endAngle = angleEnd
////    var clockwise : Bool = false
////    
////    var aPath = CGPathCreateMutable()
////    var center = CGPoint(x: NSMidX(self.bounds), y: NSMidY(self.bounds))
////    CGPathMoveToPoint(aPath, nil, center.x, center.y)
////    CGPathAddArc(aPath, nil, center.x, center.y, radius, startAngle, endAngle, clockwise)
////    
////    path = aPath
////    
////    lineWidth = 2.0
////    strokeColor = NSColor.redColor().CGColor
//    
//    
////    fillColor = NSColor.lightGrayColor().CGColor
////    strokeColor = NSColor.blackColor().CGColor
////    lineWidth = 1.0
////    
////    shadowColor = NSColor.blackColor().CGColor
////    shadowOffset = CGSize(width: 0, height: 2)
////    shadowOpacity = 0.75
////    shadowRadius = 3.0
////    shadowPath = path
////    
////    var gradientLayer = CAGradientLayer()
////    gradientLayer.colors = [NSColor.whiteColor().CGColor, NSColor.lightGrayColor().CGColor]
////    gradientLayer.frame = CGPathGetBoundingBox(path)
////    
////    var maskLayer = CAShapeLayer()
////    var translationT = CGAffineTransformMakeTranslation(-CGRectGetMinX(gradientLayer.frame), -CGRectGetMinY(gradientLayer.frame))
////    maskLayer.path = CGPathCreateCopyByTransformingPath(path, &translationT)
////    
////    gradientLayer.mask = maskLayer
//  }
  
//  override func display() {
//    println("called display")
//    
//    var radius : CGFloat = 95.0
//    var startAngle = angleStart
//    var endAngle = angleEnd
//    var clockwise : Bool = false
//    
//    var aPath = CGPathCreateMutable()
//    var center = CGPoint(x: NSMidX(self.bounds), y: NSMidY(self.bounds))
//    CGPathMoveToPoint(aPath, nil, center.x, center.y)
//    CGPathAddArc(aPath, nil, center.x, center.y, radius, startAngle, endAngle, clockwise)
//    
//    path = aPath
//    
//    lineWidth = 2.0
//    strokeColor = NSColor.redColor().CGColor
//  }
  
  
  // MARK: - Animation
//  func createAnimationForKey(key: String) -> CABasicAnimation {
//    
//    var animation = CABasicAnimation(keyPath: key)
//    
//    if presentationLayer()?.valueForKey(key) != nil {
//      animation.fromValue = presentationLayer().valueForKey(key)
//    }
//    else {
//      animation.fromValue = 0
//    }
//    
//    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//    animation.duration = 0.5
//    
//    return animation
//  }
  
  
  // MARK: - Actions
//  override func actionForKey(key: String!) -> CAAction! {
//    
//    if self.dynamicType.isCustomAnimatableProperty(key) {
//      return createAnimationForKey(key)
//    }
//    
//    return super.actionForKey(key)
//  }
  
  
  override class func needsDisplayForKey(key: String!) -> Bool {
    
    if isCustomAnimatableProperty(key) {
      return true
    }
    
    return super.needsDisplayForKey(key)
  }
  
  
  // MARK: - Helpers
  class func isCustomAnimatableProperty(key: String!) -> Bool {
    
    if key == "radius" || key == "angleStart" || key == "angleEnd" || key == "arcWidth" {
      return true
    }
    
    return false
  }
  
}
