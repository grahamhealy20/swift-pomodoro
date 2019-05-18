//
//  Notification.swift
//  Pomodoro
//
//  Created by Graham Healy on 18/05/2019.
//  Copyright © 2019 Graham Healy. All rights reserved.
//

import Cocoa

class NotificationManager: NSObject, NSUserNotificationCenterDelegate {
    
    override init() {
        super.init()
        NSUserNotificationCenter.default.delegate = self
    }
    
    func notification() {
        NSLog("Sending Notifiaction")
        let notification = NSUserNotification()
        notification.identifier = "1"
        notification.title = "Pomodoro"
        notification.subtitle = "Timer Finished"
        notification.informativeText = "Time to take a break!"
        notification.soundName = NSUserNotificationDefaultSoundName
        
        // Manually display the notification
        let notificationCenter = NSUserNotificationCenter.default
        notificationCenter.deliver(notification)
    }
    
    // MARK: NSUserNotificationCenterDelegate implementation
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
    
    
}
