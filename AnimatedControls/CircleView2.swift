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
  var backgroundLayer : CALayer
  
  private var arcLayers : [CircleLayer2] = []
  var arcWidths : [Int] = [] {
    didSet { refreshArcs() }
  }
  
  let π = CGFloat(M_PI)

  let gradientColors = [
    (NSColor(deviceRed: 171.0/255.0, green: 22.0/255.0, blue: 75.0/255.0, alpha: 1.0).CGColor,
      NSColor(calibratedRed: 101.0/255.0, green: 13.0/255.0, blue: 45.0/255.0, alpha: 1.0).CGColor),
    (NSColor(deviceRed: 22.0/255.0, green: 95.0/255.0, blue: 171.0/255.0, alpha: 1.0).CGColor,
      NSColor(calibratedRed: 13.0/255.0, green: 56.0/255.0, blue: 101.0/255.0, alpha: 1.0).CGColor),
    (NSColor(deviceRed: 54.0/255.0, green: 140.0/255.0, blue: 64.0/255.0, alpha: 1.0).CGColor,
      NSColor(calibratedRed: 32.0/255.0, green: 83.0/255.0, blue: 38.0/255.0, alpha: 1.0).CGColor),
    (NSColor(deviceRed: 240.0/255.0, green: 212.0/255.0, blue: 10.0/255.0, alpha: 1.0).CGColor,
      NSColor(calibratedRed: 165.0/255.0, green: 145.0/255.0, blue: 7.0/255.0, alpha: 1.0).CGColor),
    (NSColor(calibratedRed: 244.0/255.0, green: 209.0/255.0, blue: 217.0/255.0, alpha: 1.0).CGColor,
      NSColor(deviceRed: 253.0/255.0, green: 200.0/255.0, blue: 213.0/255.0, alpha: 1.0).CGColor)
  ]
  
  
  // MARK: - Initializers
  required init?(coder: NSCoder) {
    
    containerLayer = CALayer()
    containerLayer.name = "container"
    
    backgroundLayer = CALayer()
    backgroundLayer.name = "background"
    backgroundLayer.backgroundColor = NSColor.clearColor().CGColor
    
    super.init(coder: coder)
    
    doInitialSetup()
  }
  
  
  // MARK: - Setup
  func doInitialSetup() {
    backgroundLayer.frame = bounds
    
    containerLayer.frame = bounds
    containerLayer.backgroundColor = NSColor.clearColor().CGColor
    containerLayer.shadowColor = NSColor.darkGrayColor().CGColor
    containerLayer.shadowOffset = CGSize(width: 10.0, height: 5.0)
    containerLayer.shadowRadius = 3.0
    containerLayer.shadowOpacity = 1.0
    
    self.layer = containerLayer
    self.wantsLayer = true
    
    containerLayer.addSublayer(backgroundLayer)
  }
  
  
  func createCircleLayer() {
    arcWidths = [ 1, 1, 1, 1, 1 ]
  }
  
  func updateCircles() {
    arcWidths = [ 1, 2, 1 ]
  }
  
  func adjustAngles() {
    arcWidths = [ 1, 1, 5, 1 ]
  }
  

  // MARK: - CALayerDelegate
  override func actionForLayer(layer: CALayer, forKey key: String) -> CAAction? {
    
    if (arcLayers as [CALayer]).contains(layer) {
      let aLayer = layer as! CircleLayer2
      
      if aLayer.dynamicType.isCustomAnimatableProperty(key) {
        let animation = aLayer.createCustomAnimationForKey(key)
//        animation.delegate = self
//        animation.setValue(aLayer, forKey: "layer")
        
        return animation
      }

    }
    
    return super.actionForLayer(layer, forKey: key)
  }
  
  // MARK: - CAAnimationDelegate
//  override func animationDidStart(anim: CAAnimation!) {
//    println("delegate - animationDidStart")
//  }
//  
//  override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
//    println("delegate - animationDidStop")
//    
//    if let layer = anim.valueForKey("layer") as? CircleLayer2 {
////      || anim == arcLayers[0].animationForKey("angleEnd") {
//      
//      for i in 0..<arcLayers.count - 1 {
//        if layer == arcLayers[i] {
//          println("ended \(i), start \(i+1)")
//          refreshArcAtPosition(i+1)
//        }
//      }
//    }
//    
//  }
  
  
  // MARK: - Update
  func refreshArcs() {
    
    if arcWidths.count > arcLayers.count {
      for i in arcLayers.count..<arcWidths.count {
        let newLayer = CircleLayer2(radius: 100)
        newLayer.frame = bounds
        newLayer.name = "layer \(i)"
        
        newLayer.colorStart = gradientColors[i].0
        newLayer.colorEnd = gradientColors[i].1
        
        newLayer.delegate = self
        
        arcLayers.append(newLayer)
        
        containerLayer.addSublayer(newLayer)
      }
    }
    
    else if arcWidths.count < arcLayers.count {
      for _ in 0..<arcLayers.count - arcWidths.count {
        let unneededLayer = arcLayers.removeLast()
        
        unneededLayer.removeFromSuperlayer()
      }
    }
    
//    refreshArcAtPosition(0)
    
    let sumOfValues = CGFloat(arcWidths.reduce(0, combine: +))
    
//    CATransaction.begin()
    
    var startOfAngle = CGFloat(0)
    for i in 0..<arcLayers.count {
      let angleWidth = 360 * CGFloat(arcWidths[i]) / sumOfValues
      
//      var anAnimation = arcLayers[i].createCustomAnimationForKey("angleStart")
//      anAnimation.toValue = startOfAngle
//      arcLayers[i].addAnimation(anAnimation, forKey: "rocoAnimation")
//      anAnimation.timeOffset = CFTimeInterval(i) * 1.0
//      anAnimation.duration = 1.0
//      
//      anAnimation = arcLayers[i].createCustomAnimationForKey("angleEnd")
//      anAnimation.toValue = startOfAngle + angleWidth
//      arcLayers[i].addAnimation(anAnimation, forKey: "rocoAnimation")
//      anAnimation.timeOffset = CFTimeInterval(i) * 1.0
//      anAnimation.duration = 1.0
      
      arcLayers[i].angleStart = startOfAngle
      arcLayers[i].angleEnd = startOfAngle + angleWidth

      startOfAngle += angleWidth
    }
    
//    CATransaction.commit()
    
  }
  
//  func refreshArcAtPosition(index: Int) {
//    let sumOfValues = CGFloat(arcWidths.reduce(0, combine: +))
//    
//    var startOfAngle = CGFloat(0)
//    for i in 0..<arcLayers.count {
//      var angleWidth = 360 * CGFloat(arcWidths[i]) / sumOfValues
//      
//      if i == index {
//        arcLayers[i].angleStart = startOfAngle
//        arcLayers[i].angleEnd = startOfAngle + angleWidth
//      }
//      
//      startOfAngle += angleWidth
//    }
//  }
    
}
