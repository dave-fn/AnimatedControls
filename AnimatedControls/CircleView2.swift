//
//  CircleView2.swift
//  AnimatedControls
//
//  Created by David on 6/26/15.
//  Copyright (c) 2015 David. All rights reserved.
//

import Foundation
import AppKit

class CircleView2 : NSView {
  
  var containerLayer : CALayer
  var layer1 : CALayer
  var layer2 : CAShapeLayer
  var arcLayer : CAShapeLayer
  var arcLayer2 : CircleLayer2
  
  var arcEndAngle : CGFloat
  
  let π = CGFloat(M_PI)
  
  
  // MARK: - Initializers
  required init?(coder: NSCoder) {
    
    containerLayer = CALayer()
    containerLayer.name = "background"
    
    layer1 = CALayer()
    layer1.name = "layer-1"
    
    layer2 = CAShapeLayer()
    layer2.name = "layer-shape-2"
    
    arcLayer = CAShapeLayer()
    arcLayer.name = "layer-shape_arc"
    
    arcLayer2 = CircleLayer2(radius: 15)
    arcLayer2.name = "layer-circle_arc"
    
    arcEndAngle = π / 2.0
    
    super.init(coder: coder)
    
    doInitialSetup()
  }
  
  
  // MARK: - Setup
  func doInitialSetup() {
    containerLayer.frame = bounds
    containerLayer.backgroundColor = NSColor.clearColor().CGColor
    containerLayer.shadowColor = NSColor.darkGrayColor().CGColor
    containerLayer.shadowOffset = CGSize(width: 10.0, height: 5.0)
    containerLayer.shadowRadius = 3.0
    containerLayer.shadowOpacity = 1.0
    
    self.layer = containerLayer
    self.wantsLayer = true
    
    containerLayer.addSublayer(layer1)
    containerLayer.addSublayer(layer2)
//    containerLayer.addSublayer(arcLayer)
    containerLayer.addSublayer(arcLayer2)
    
//    layer1.delegate = self
//    layer2.delegate = self
    arcLayer.delegate = self
    arcLayer2.delegate = self
  }
  
  
  func createCircleLayer() {
    
    drawLayer1()
    drawLayer2()
    drawArcLayer()
    drawArcLayer2()
    
  }
  
  func updateCircles() {
    layer1.borderWidth += 5.0
    
    layer2.fillColor = NSColor.redColor().CGColor
    layer2.lineWidth += 1.0
    
//    arcLayer.lineWidth += 10.0
    arcEndAngle += π / 4.0
    arcLayer.setNeedsDisplay()
    
//    arcLayer2.radius += 20
    arcLayer2.angleEnd += π / 4
  }
  
  func adjustAngles() {
  }
  
  
  // MARK: - Individual Drawing
  func drawLayer1() {
    // Layer 1 - CALayer
    layer1.frame = CGRectInset(self.bounds, 10, 10)
    layer1.borderColor = NSColor.yellowColor().CGColor
    layer1.borderWidth = 1.0
  }
  
  func drawLayer2() {
    // Layer 2 - CAShapeLayer
    layer2.frame = CGRectInset(self.bounds, 10, 10)
    
//    var center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
    var center = CGPoint(x: NSMidX(self.bounds), y: NSMidY(self.bounds))
    var aPath = CGPathCreateMutable()
    CGPathMoveToPoint(aPath, nil, 1, 1)
    CGPathAddLineToPoint(aPath, nil, self.bounds.width - 21, self.bounds.height - 21)
    CGPathMoveToPoint(aPath, nil, 1, self.bounds.height - 21)
    CGPathAddLineToPoint(aPath, nil, self.bounds.width - 21, 1)
    CGPathMoveToPoint(aPath, nil, center.x, center.y)
    var aRect = NSRect(x: center.x - 25, y: center.y - 25, width: 30, height: 30)
    CGPathAddEllipseInRect(aPath, nil, aRect)
    layer2.path = aPath
    
    layer2.lineCap = kCALineCapSquare
    layer2.lineJoin = kCALineJoinRound
    layer2.lineWidth = 2.0
    layer2.strokeColor = NSColor.greenColor().CGColor
    layer2.fillColor = NSColor.whiteColor().CGColor
  }
  
  func drawArcLayer() {
    // Arc - CAShapeLayer
    arcLayer.frame = CGRectInset(self.bounds, 10, 10)
    
    var radius : CGFloat = 95.0
    var startAngle = π / 4.0
    var endAngle = arcEndAngle // π / 2.0
    var clockwise : Bool = false
    
    var aPath = CGPathCreateMutable()
    var center = CGPoint(x: NSMidX(self.bounds), y: NSMidY(self.bounds))
    CGPathMoveToPoint(aPath, nil, center.x, center.y)
    CGPathAddArc(aPath, nil, center.x, center.y, radius, startAngle, endAngle, clockwise)
    
    arcLayer.path = aPath
    
    arcLayer.fillColor = NSColor.blackColor().CGColor
    
    arcLayer.lineWidth = 2.0
    arcLayer.strokeColor = NSColor.whiteColor().CGColor
  }
  
  func drawArcLayer2() {
    // Arc 2 - CircleLayer2
    arcLayer2.frame = bounds
    
//    arcLayer2.path = CGPathCreateWithEllipseInRect(bounds, nil)
    
    var radius : CGFloat = 95.0
    var startAngle = π / 4.0
    var endAngle = arcEndAngle // π / 2.0
    var clockwise : Bool = false
    
    println("animating between \(startAngle) and \(endAngle)")
    
    var aPath = CGPathCreateMutable()
    var center = CGPoint(x: NSMidX(self.bounds), y: NSMidY(self.bounds))
    CGPathMoveToPoint(aPath, nil, center.x, center.y)
    CGPathAddArc(aPath, nil, center.x, center.y, radius, startAngle, endAngle, clockwise)
    
    arcLayer2.path = aPath
  
    arcLayer2.lineWidth = 2.0
    arcLayer2.strokeColor = NSColor.orangeColor().CGColor
  }
  
  
  // MARK: - Individual Animations
  func animateLayer1(key: String!) -> CABasicAnimation {
//    println("animating layer 1")
    
    var animation = CABasicAnimation(keyPath: key)
    
    if layer1.presentationLayer()?.valueForKey(key) != nil {
      animation.fromValue = layer1.presentationLayer().valueForKey(key)
    }
    else {
      animation.fromValue = 0
    }
    
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    animation.duration = 2.25
    
    return animation
  }
  
  func animateLayer2(key: String!) -> CABasicAnimation {
//    println("animating layer 2")
    
    var animation = CABasicAnimation(keyPath: key)
    
    if layer2.presentationLayer()?.valueForKey(key) != nil {
      animation.fromValue = layer2.presentationLayer().valueForKey(key)
    }
    else {
      animation.fromValue = 0
    }
    
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    animation.duration = 5.25
    
    return animation
  }
  
  func animateArcLayer(key: String!) -> CABasicAnimation {
//    println("animating arc layer")
    
    var animation = CABasicAnimation(keyPath: key)
    
    if arcLayer.presentationLayer()?.valueForKey(key) != nil {
      animation.fromValue = arcLayer.presentationLayer().valueForKey(key)
    }
    else {
      animation.fromValue = 0
    }
    
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    animation.duration = 1.0
    
    return animation
  }
  
  func animateArcLayer2(key: String!) -> CABasicAnimation {
    
    var animation = CABasicAnimation(keyPath: key)
    
    if arcLayer.presentationLayer()?.valueForKey(key) != nil {
      animation.fromValue = arcLayer.presentationLayer().valueForKey(key)
    }
    else {
      animation.fromValue = 0
    }
    
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    animation.duration = 1.0
    
    return animation
  }
  
  
  // MARK: - CALayerDelegate
  override func displayLayer(layer: CALayer!) {
    println("in delegate - displayLayer")
//    super.displayLayer(layer)
//    layer.displayIfNeeded()
    
    if layer == arcLayer2 {
      drawArcLayer2()
//      arcLayer2.fillColor = NSColor.lightGrayColor().CGColor
//      arcLayer2.strokeColor = NSColor.blackColor().CGColor
//      arcLayer2.lineWidth = 1.0
//      
//      arcLayer2.shadowColor = NSColor.blackColor().CGColor
//      arcLayer2.shadowOffset = CGSize(width: 0, height: 2)
//      arcLayer2.shadowOpacity = 0.75
//      arcLayer2.shadowRadius = 3.0
//      arcLayer2.shadowPath = arcLayer2.path
//      
//      var gradientLayer = CAGradientLayer()
//      gradientLayer.colors = [NSColor.whiteColor().CGColor, NSColor.lightGrayColor().CGColor]
//      gradientLayer.frame = CGPathGetBoundingBox(arcLayer2.path)
//      
//      var maskLayer = CAShapeLayer()
//      var translationT = CGAffineTransformMakeTranslation(-CGRectGetMinX(gradientLayer.frame), -CGRectGetMinY(gradientLayer.frame))
//      maskLayer.path = CGPathCreateCopyByTransformingPath(arcLayer2.path, &translationT)
//      
//      gradientLayer.mask = maskLayer
    }
    
  }
  
  override func drawLayer(layer: CALayer!, inContext ctx: CGContext!) {
    
    if layer == arcLayer {
      drawArcLayer()
    }
    else if layer == arcLayer2 {
      println("missing?")
    }
    
    super.drawLayer(layer, inContext: ctx)
  }
  
  override func actionForLayer(layer: CALayer!, forKey key: String!) -> CAAction! {
    
    if layer == layer1 {
      return animateLayer1(key)
    }
    else if layer == layer2 {
      return animateLayer2(key)
    }
    else if layer == arcLayer {
      return animateArcLayer(key)
    }
    else if layer == arcLayer2 {
      return animateArcLayer2(key)
    }
    
    return super.actionForLayer(layer, forKey: key)
  }
  
//  override func layoutSublayersOfLayer(layer: CALayer!) {
//    println("in delegate - layoutSublayersOfLayer")
//    super.layoutSublayersOfLayer(layer)
//  }
  
  
}
