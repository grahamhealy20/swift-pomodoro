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
    @IBOutlet weak var startButton: NSMenuItem!
    @IBOutlet weak var pauseButton: NSMenuItem!
    
    var timerMenuItem: NSMenuItem!
    var pomodoroTimer: PomodoroTimer!
    
    override func awakeFromNib() {
        // Set main status bar title/icon
        statusItem.button?.title = "Pomodoro"
        statusItem.menu = statusMenu
        
        // Get the timer menu item and assign a custom view to it instead of regular text.
        timerMenuItem = statusMenu.item(withTag: 1)
        timerMenuItem.view = timerView
        
        pomodoroTimer = PomodoroTimer()
        pomodoroTimer.delegate = self
        
        updateMenuItems()
        
        timerView.update(timeRemaining: pomodoroTimer.seconds)
    }
    
    func updateMenuItems() {
        if pomodoroTimer.paused == true {
            pauseButton.isHidden = true
            startButton.isHidden = false
        } else {
            pauseButton.isHidden = false
            startButton.isHidden = true
        }
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
        timerView.update(timeRemaining: pomodoroTimer.seconds)
    }
    
    // MARK: Delegate implementation
    func timerDidStart() {
        NSLog("Timer has started")
        updateMenuItems()
    }
    
    func timerDidTick(seconds: Int) {
        NSLog("Timer has ticked")
        NSLog("Seconds remaining \(seconds)")
        
        // Update UI
        timerView.update(timeRemaining: seconds)
    }
    
    func timerDidPause() {
        NSLog("Timer has been paused")
        updateMenuItems()
    }
    
    func timerDidEnd() {
        NSLog("Timer has finished")
        updateMenuItems()
        notificationManager.notification()
    }
    
    func timerDidReset(seconds: Int) {
        NSLog("Timer has been reset")
        updateMenuItems()
        timerView.update(timeRemaining: seconds)
    }
    
    // MARK: button handlers
    @IBAction func startPressed(_ sender: NSMenuItem) {
        start()
    }
    
    @IBAction func pausedPressed(_ sender: NSMenuItem) {
        pause()
    }
    
    
    @IBAction func resetClicked(_ sender: NSMenuItem) {
        reset()
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
}
