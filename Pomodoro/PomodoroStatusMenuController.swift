//
//  PomodoroStatusMenuController.swift
//  Pomodoro
//
//  Created by Graham Healy on 17/05/2019.
//  Copyright © 2019 Graham Healy. All rights reserved.
//

import Cocoa

class PomodoroStatusMenuController: NSObject {
    
    // MARK: Nib Wiring
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    override func awakeFromNib() {
        statusItem.button?.title = "Pomodoro"
        statusItem.menu = statusMenu
        
        NSLog("Awakened from Nib")
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
}
