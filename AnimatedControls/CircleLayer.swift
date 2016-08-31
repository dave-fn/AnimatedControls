//
//  CircleLayer.swift
//  Circles3
//
//  Created by David on 6/25/15.
//  Copyright (c) 2015 David. All rights reserved.
//

import Foundation
import AppKit
import QuartzCore

class CircleLayer : CAShapeLayer {
  
  @NSManaged var radius : CGFloat
  @NSManaged var angleStart : CGFloat
  @NSManaged var angleEnd : CGFloat
  
  var arcPath : CGPathRef?
  
  var ringWidth : CGFloat = 25.0
  var outlineWidth : CGFloat = 2.0
  
  
  // MARK: - Initializers
  init(radius radiusVal: CGFloat, start: CGFloat, end: CGFloat) {
    
    super.init()
    
    radius = radiusVal
    angleStart = start
    angleEnd = end
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
  
  override init!(layer: AnyObject) {
    print("init withLayer");
    
    super.init(layer: layer)
    
    if layer.isKindOfClass(CircleLayer) {
      let otherLayer = layer as! CircleLayer
      radius = otherLayer.radius
      angleStart = otherLayer.angleStart
      angleEnd = otherLayer.angleEnd
      name = otherLayer.name
      frame = otherLayer.frame
    }
  }
  
  
  // MARK: - Drawing
  func drawArc(ctx: CGContext!) {
    
    var frame = self.bounds
    var center = CGPointMake(NSMidX(frame), NSMidY(frame))
    var clockwise : Int32 = 1
    
    var angleStartRadians = degreesToRadians(angleStart)
    var angleEndRadians = degreesToRadians(angleEnd)
    
    CGContextBeginPath(ctx)
    
    CGContextAddArc(ctx, center.x, center.y, radius, angleStartRadians, angleEndRadians, clockwise)
    
    CGContextSetLineWidth(ctx, ringWidth)
    CGContextSetLineCap(ctx, kCGLineCapButt)
    //    CGContextSetLineJoin(ctx, kCGLineJoinMiter)
    CGContextReplacePathWithStrokedPath(ctx)
    arcPath = CGContextCopyPath(ctx)
    
    //    CGContextSetLineWidth(ctx, outlineWidth)
    //    CGContextSetStrokeColorWithColor(ctx, NSColor.redColor().CGColor)
    
    //    CGContextStrokePath(ctx)
  }
  
  
  func drawArcShadow(ctx: CGContext!) {
    
    //    CGContextAddPath(ctx, arcPath)
    CGContextSetShadowWithColor(ctx, CGSizeMake(20,2), 5.0, NSColor.yellowColor().CGColor)
    
    //    CGContextStrokePath(ctx)
  }
  
  
  func drawArcGradient(ctx: CGContext!) {
    
    CGContextBeginTransparencyLayer(ctx, nil as CFDictionary!)
    
    CGContextSaveGState(ctx)
    
    var frame = self.bounds
    var center = CGPointMake(NSMidX(frame), NSMidY(frame))
    
    var colorSpace = CGColorSpaceCreateDeviceRGB()
    var colors = [NSColor.lightGrayColor().CGColor, NSColor.darkGrayColor().CGColor]
    var locations : [CGFloat] = [0.0, 1.0]
    var gradient = CGGradientCreateWithColors(colorSpace, colors, locations)
    
    var gradientDrawingOptions = CGGradientDrawingOptions(kCGGradientDrawsAfterEndLocation)
    
    CGContextClip(ctx)
    CGContextDrawRadialGradient(ctx, gradient, center, radius - ringWidth/2, center, radius + ringWidth/2, gradientDrawingOptions)
    
    CGContextRestoreGState(ctx)
    
    //    CGContextAddPath(ctx, arcPath)
    
    //    CGContextSetStrokeColorWithColor(ctx, NSColor.whiteColor().CGColor)
    
    //    CGContextSetLineWidth(ctx, outlineWidth)
    //    CGContextSetStrokeColorWithColor(ctx, NSColor.blueColor().CGColor)
    
    //    CGContextStrokePath(ctx)
  }
  
  
  func drawAll(ctx: CGContext!) {
    
    // ARC
    var frame = self.bounds
    var center = CGPointMake(NSMidX(frame), NSMidY(frame))
    var clockwise : Int32 = 1
    
    var angleStartRadians = degreesToRadians(angleStart)
    var angleEndRadians = degreesToRadians(angleEnd)
    
    CGContextBeginPath(ctx)
    
    CGContextAddArc(ctx, center.x, center.y, radius, angleStartRadians, angleEndRadians, clockwise)
    
    CGContextSetLineWidth(ctx, ringWidth)
    CGContextSetLineCap(ctx, kCGLineCapButt)
    CGContextReplacePathWithStrokedPath(ctx)
    arcPath = CGContextCopyPath(ctx)
    
    // SHADOW
    CGContextSetShadowWithColor(ctx, CGSizeMake(20,2), 5.0, NSColor.yellowColor().CGColor)
    
    // GRADIENT
    CGContextBeginTransparencyLayer(ctx, nil as CFDictionary!)
    
    CGContextSaveGState(ctx)
    
    var colorSpace = CGColorSpaceCreateDeviceRGB()
    var colors = [NSColor.lightGrayColor().CGColor, NSColor.darkGrayColor().CGColor]
    var locations : [CGFloat] = [0.0, 1.0]
    var gradient = CGGradientCreateWithColors(colorSpace, colors, locations)
    
    var gradientDrawingOptions = CGGradientDrawingOptions(kCGGradientDrawsAfterEndLocation)
    
    CGContextClip(ctx)
    CGContextDrawRadialGradient(ctx, gradient, center, radius - ringWidth/2, center, radius + ringWidth/2, gradientDrawingOptions)
    
    CGContextRestoreGState(ctx)
    
    CGContextAddPath(ctx, arcPath)
    CGContextSetLineWidth(ctx, outlineWidth)
    CGContextSetLineJoin(ctx, kCGLineJoinMiter)
    CGContextSetStrokeColorWithColor(ctx, NSColor.lightGrayColor().CGColor)
    CGContextStrokePath(ctx)
    CGContextEndTransparencyLayer(ctx)
    
  }
  
  
  override func drawInContext(ctx: CGContext) {
    drawArc(ctx)
    drawArcShadow(ctx)
    drawArcGradient(ctx)
    
    CGContextAddPath(ctx, arcPath)
    CGContextSetLineWidth(ctx, outlineWidth)
    CGContextSetLineJoin(ctx, kCGLineJoinMiter)
    CGContextSetStrokeColorWithColor(ctx, NSColor.lightGrayColor().CGColor)
    CGContextStrokePath(ctx)
    CGContextEndTransparencyLayer(ctx)
    
    //    drawAll(ctx)
  }
  
  
  // MARK: - Actions
  override func actionForKey(key: String) -> CAAction? {
    
    if key == "radius" || key == "angleStart" || key == "angleEnd" {
      return createAnimationForKey(key)
    }
    
    return super.actionForKey(key)
  }
  
  
  // MARK: - Animations
  func createAnimationForKey(key: String) -> CABasicAnimation {
    
    let animation = CABasicAnimation(keyPath: key)
    
    if presentationLayer()?.valueForKey(key) != nil {
      animation.fromValue = presentationLayer().valueForKey(key)
    }
    else {
      animation.fromValue = 0
    }
    
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    animation.duration = 0.5
    
    return animation
  }
  
  
  override class func needsDisplayForKey(key: String) -> Bool {
    
    if key == "radius" || key == "angleStart" || key == "angleEnd" {
      return true
    }
    
    return super.needsDisplayForKey(key)
  }
  
  
  // MARK: - Helpers
  func degreesToRadians(degrees: CGFloat) -> CGFloat {
    return degrees * CGFloat(M_PI) / 180.0
  }
  
  
}
