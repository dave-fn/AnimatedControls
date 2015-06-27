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
  
  
  // MARK: - Initializers
//  override init(frame frameRect: NSRect) {
//    
//    containerLayer = CALayer()
//    containerLayer.name = "background"
//    containerLayer.backgroundColor = NSColor.blackColor().CGColor
//    
//    layer1 = CALayer()
//    layer1.name = "layer-1"
//    
//    super.init(frame: frameRect)
//    
//    self.layer = containerLayer
//  }

  required init?(coder: NSCoder) {
    
    containerLayer = CALayer()
    containerLayer.name = "background"
    
    layer1 = CALayer()
    layer1.name = "layer-1"
    
    layer2 = CAShapeLayer()
    layer2.name = "layer-shape-2"
    
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
  }
  
  
  func createCircleLayer() {
    layer1.frame = CGRectInset(self.bounds, 10, 10)
    layer1.borderColor = NSColor.yellowColor().CGColor
    layer1.borderWidth = 1.0
    
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
  
  func updateCircles() {
    layer1.borderWidth += 5.0
    
    layer2.fillColor = NSColor.redColor().CGColor
    layer2.lineWidth += 1.0
  }
  
  func adjustAngles() {
  }
  
  
}
