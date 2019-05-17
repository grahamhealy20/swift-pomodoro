//
//  PomodoroStatusMenuController.swift
//  Pomodoro
//
//  Created by Graham Healy on 17/05/2019.
//  Copyright © 2019 Graham Healy. All rights reserved.
//

import Cocoa

class PomodoroStatusMenuController: NSObject, PomodoroTimerDelegate {
    
    // MARK: Nib Wiring
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var timerView: TimerView!
    var timerMenuItem: NSMenuItem!
    
    var pomodoroTimer: PomodoroTimer!
    
    override func awakeFromNib() {
        // Set main status bar title/icon
        statusItem.button?.title = "Pomodoro"
        statusItem.menu = statusMenu
    
        timerMenuItem = statusMenu.item(withTag: 1)
        timerMenuItem.view = timerView
        
        pomodoroTimer = PomodoroTimer()
        pomodoroTimer.delegate = self
        
        pomodoroTimer.start()
    }
    
    func resetTimer() {
        NSLog("Resetting timer")
    }
    
    // MARK: Delegate implementation
    func timerDidTick(seconds: Int) {
        NSLog("Timer has ticked")
        NSLog("Seconds remaining \(seconds)")
        
        // Update UI
        updateItemTitle(seconds: seconds)

    }
    
    func updateItemTitle(seconds: Int) {
        timerView.update(timeRemaining: "\(seconds)")
//        if let timeTitle = self.statusMenu.item(withTag: 1) {
//            timeTitle.title = "\(seconds)"
//        }
    }
    
    func timerDidEnd() {
        NSLog("Timer has ended")
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
}
