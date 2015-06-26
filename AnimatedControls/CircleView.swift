//
//  CircleView.swift
//  Circles3
//
//  Created by David on 6/25/15.
//  Copyright (c) 2015 David. All rights reserved.
//

import Foundation
import AppKit

class CircleView: NSView {
  
  var circleLayer : CircleLayer?
  
  
  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    
    doInitialSetup()
  }
  
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    doInitialSetup()
  }
  
  
  func doInitialSetup() {
    self.layer = containerLayer()
    self.wantsLayer = true
  }
  
  
  func createCircleLayer() {
    
    circleLayer = CircleLayer(radius: CGFloat(45), start: 90, end: 0)
    circleLayer?.name = "circle-1"
    circleLayer?.frame = CGRectInset(self.bounds, 10, 10)
    //    circleLayer?.backgroundColor = NSColor.whiteColor().CGColor
    
    // MARK: CALayer . setFrame
    // If the frame is not set, then drawInContext is not called
    
    self.layer?.addSublayer(circleLayer)
    
    
    circleLayer = CircleLayer(radius: CGFloat(45), start: 180, end: 135)
    circleLayer?.name = "circle-2"
    circleLayer?.frame = CGRectInset(self.bounds, 10, 10)
    
    self.layer?.addSublayer(circleLayer)
  }
  
  
  func increaseCircleRadius() {
    
    if let containerLay = self.layer {
      for aLayer in containerLay.sublayers as! [CircleLayer] {
        aLayer.radius += 10
      }
    }
  }
  
  
  func adjustAngles() {
    
    if let containerLay = self.layer {
      for aLayer in containerLay.sublayers as! [CircleLayer] {
        aLayer.angleStart -= CGFloat(10.0)
        aLayer.angleEnd -= 20.0
      }
    }
  }
  
  
  func containerLayer() -> CALayer {
    var layer = CALayer()
    layer.name = "container"
    layer.backgroundColor = NSColor.blackColor().CGColor
    
    return layer
  }
  
}
