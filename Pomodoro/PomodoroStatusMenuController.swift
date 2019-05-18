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
    let notificationManager: NotificationManager = NotificationManager()
    
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
        
        // TODO: Remove this, only for debugging until the buttons are added.
        start()
    }
    
    // MARK: Timer actions
    func start() {
        NSLog("Starting timer")
        pomodoroTimer.start()
    }
    
    func pause() {
        NSLog("Pausing timer")
        pomodoroTimer.pause()
    }
    
    func reset() {
        NSLog("Resetting timer")
        pomodoroTimer.reset()
    }
    
    func updateTimerView(seconds: Int) {
        timerView.update(timeRemaining: "\(seconds)")
    }
    
    
    // MARK: Delegate implementation
    func timerDidTick(seconds: Int) {
        NSLog("Timer has ticked")
        NSLog("Seconds remaining \(seconds)")
        
        // Update UI
        updateTimerView(seconds: seconds)
    }
    
    func timerDidEnd() {
        NSLog("Timer has finished")
        notificationManager.notification()
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
}
