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

class CircleLayer2 : CALayer {
  
  @NSManaged var angleStart : CGFloat
  @NSManaged var angleEnd : CGFloat
  @NSManaged var arcWidth : CGFloat
  
  var center : CGPoint = CGPoint(x: 0, y: 0)
  var radius : CGFloat = 1
  
  let π = CGFloat(M_PI)
  
  
  // MARK: - Initializers
  init(radius: CGFloat) {

    self.radius = radius
    
    super.init()
    
    arcWidth = 25
  }
  
  override init!(layer: AnyObject!) {
    
    super.init(layer: layer)
    
    if layer.isKindOfClass(CircleLayer2) {
      var otherLayer = layer as! CircleLayer2
      radius = otherLayer.radius
      center = otherLayer.center
      angleStart = otherLayer.angleStart
      angleEnd = otherLayer.angleEnd
      arcWidth = otherLayer.arcWidth
    }
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Setup
  
  
  
  // MARK: - Drawing
  override func drawInContext(ctx: CGContext!) {
    
    var arcPath = createArc(customDegreesToRadians(angleStart), end: customDegreesToRadians(angleEnd), radius: radius, width: arcWidth)
    
    drawArcInContext(ctx, path: arcPath)
    drawArcGradientInContext(ctx, path: arcPath, radius: radius, width: arcWidth)
  }
  
  func createArc(start: CGFloat, end: CGFloat, radius: CGFloat, width: CGFloat) -> CGPathRef {
    
    var center = CGPoint(x: NSMidX(self.bounds), y: NSMidY(self.bounds))
    var clockwise : Bool = true
    
    var arcPathStart = CGPathCreateMutable()
    
    CGPathAddArc(arcPathStart, nil, center.x, center.y, radius - width/2, start, end, clockwise)
    
    var arcPath = CGPathCreateCopyByStrokingPath(arcPathStart, nil, width, kCGLineCapButt, kCGLineJoinMiter, 10)
    
    return arcPath
  }
  
  func drawArcInContext(c: CGContext!, path: CGPathRef) {
    
    CGContextSetStrokeColorWithColor(c, NSColor.blackColor().CGColor)
    CGContextSetLineWidth(c, 1.0)
    
//    CGContextSetShadowWithColor(c, CGSize(width: 10, height: 5), 5, NSColor.blackColor().CGColor)
    
    CGContextAddPath(c, path)
    
    CGContextStrokePath(c)
  }
  
  func drawArcGradientInContext(c: CGContext!, path: CGPathRef, radius: CGFloat, width: CGFloat) {
    
//    CGContextBeginTransparencyLayer(ctx, nil as CFDictionary!)
    
//    CGContextSaveGState(ctx)
    
    var center = CGPoint(x: NSMidX(self.bounds), y: NSMidY(self.bounds))
    
    var colorSpace = CGColorSpaceCreateDeviceRGB()
    var colors = [NSColor.lightGrayColor().CGColor, NSColor.darkGrayColor().CGColor]
    var locations : [CGFloat] = [0.0, 1.0]
    var gradient = CGGradientCreateWithColors(colorSpace, colors, locations)
    
    var gradientDrawingOptions = CGGradientDrawingOptions(kCGGradientDrawsAfterEndLocation)
    
    CGContextAddPath(c, path)
    
    CGContextClip(c)
    CGContextDrawRadialGradient(c, gradient, center, radius - width, center, radius, gradientDrawingOptions)
    
//    CGContextRestoreGState(ctx)
    
  }
  
  
  // MARK: - Animation
  func createCustomAnimationForKey(key: String) -> CABasicAnimation {
    
    var animation = CABasicAnimation(keyPath: key)
    
    if let previousValue = presentationLayer()?.valueForKey(key) as? CGFloat {
      animation.fromValue = previousValue
    }
    else {
      animation.fromValue = 0
    }
    
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    animation.duration = 0.5
    
    return animation
  }
  
  
  // MARK: - Actions
//  override func actionForKey(key: String!) -> CAAction! {
//    
//    if self.dynamicType.isCustomAnimatableProperty(key) {
//      return createCustomAnimationForKey(key)
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
  
  func customDegreesToRadians(degrees: CGFloat) -> CGFloat {
    return degreesToRadians(customDegrees(degrees))
  }
  
  func customDegrees(degrees: CGFloat) -> CGFloat {
    return -degrees + 90
  }
  func degreesToRadians(degrees: CGFloat) -> CGFloat {
    return degrees * π / 180
  }
  
}
