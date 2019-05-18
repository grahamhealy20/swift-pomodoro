//
//  TimerView.swift
//  Pomodoro
//
//  Created by Graham Healy on 18/05/2019.
//  Copyright © 2019 Graham Healy. All rights reserved.
//

import Cocoa

class TimerView: NSView {
    
    @IBOutlet weak var timerLabel: NSTextField!
    
    func update(timeRemaining: Int) {
        // Convert seconds into hh:mm:ss
        let (_, minutes, seconds) = secondsToTime(seconds: timeRemaining)
        
        // We need to update the UI on the main thread
        DispatchQueue.main.async {
            self.timerLabel.stringValue = String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    func secondsToTime(seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 60) / 60, (seconds % 60) % 60)
    }
}
