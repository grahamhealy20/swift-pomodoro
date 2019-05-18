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
    
    func update(timeRemaining: String) {
        // TODO: Add converson of seconds to mins:seconds
        // We need to update the UI on the main thread
        DispatchQueue.main.async {
            self.timerLabel.stringValue = timeRemaining
        }
    }
    
    
}
