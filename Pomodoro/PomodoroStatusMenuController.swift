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
    }
    
    func timerDidEnd() {
        NSLog("Timer has ended")
        notificationManager.notification()
    }
    
//    func notification() {
//        NSLog("Sending Notifiaction")
//        let notification = NSUserNotification()
//        notification.identifier = "1"
//        notification.title = "Pomodoro"
//        notification.subtitle = "Timer Ended"
//        notification.informativeText = "Time to take a break!"
//        notification.soundName = NSUserNotificationDefaultSoundName
//
//        //        notification.contentImage = NSImage(contentsOfURL: NSURL(string: "https://placehold.it/300")!)
//
//        // Manually display the notification
//        let notificationCenter = NSUserNotificationCenter.default
//        notificationCenter.deliver(notification)
//    }
//
//    // MARK: NSUserNotificationCenterDelegate implementation
//    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
//        return true
//    }
//
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
}
