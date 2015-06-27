//
//  AppDelegate.swift
//  AnimatedControls
//
//  Created by David on 6/26/15.
//  Copyright (c) 2015 David. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet weak var window: NSWindow!


  func applicationDidFinishLaunching(aNotification: NSNotification) {
    // Insert code here to initialize your application
  }

  func applicationWillTerminate(aNotification: NSNotification) {
    // Insert code here to tear down your application
  }

  
  
  func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
    return true
  }
  
  
//  @IBOutlet weak var view: CircleView!
//  
//  @IBAction func button1(sender: AnyObject) {
//    view.createCircleLayer()
//  }
//  
//  @IBAction func button2(sender: AnyObject) {
//    view.increaseCircleRadius()
//  }
//  
//  @IBAction func button3(sender: AnyObject) {
//    view.adjustAngles()
//  }

  @IBOutlet weak var view: CircleView2!
  
  @IBAction func button1(sender: AnyObject) {
    view.createCircleLayer()
  }
  
  @IBAction func button2(sender: AnyObject) {
    view.updateCircles()
  }
  
  @IBAction func button3(sender: AnyObject) {
    view.adjustAngles()
  }
  
}

