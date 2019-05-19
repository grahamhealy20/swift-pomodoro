//
//  Pomodoro.swift
//  Pomodoro
//
//  Created by Graham Healy on 17/05/2019.
//  Copyright © 2019 Graham Healy. All rights reserved.
//

import Foundation


protocol PomodoroTimerDelegate {
    func timerDidStart()
    func timerDidPause()
    func timerDidEnd()
    func timerDidTick(seconds: Int)
    func timerDidReset(seconds: Int)
}


class PomodoroTimer {
    
    var delegate: PomodoroTimerDelegate?
    var timer: Timer!
    // TODO: Set this to default value externally
    var seconds = 10
    var paused = true
    
    init() {}
    
    func start() {
        // TODO: Do some validation to ensure the seconds variable is set
        // Start the timer and add it to the run loop for the current thread (so it runs async and wont block the UI).
        paused = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        if let delegate = delegate{
            delegate.timerDidStart()
        }
    }
    
    func pause() {
        // TODO: Pause the timer
        paused = true
        timer.invalidate()
        if let delegate = delegate{
            delegate.timerDidPause()
        }
    }
    
    func reset() {
        paused = true
        
        // TODO Reset the timer to default state
        if (timer != nil) {
            timer.invalidate()
        }
        seconds = 10
        if let delegate = delegate{
            delegate.timerDidReset(seconds: seconds)
        }
    }
    
    @objc func timerTick() {
        if seconds < 1 {
            timer.invalidate()
            
            if let delegate = delegate{
                delegate.timerDidEnd()
            }
        } else {
            seconds -= 1
            
            // TODO: Fire timerDidTick delegate method
            if let delegate = delegate{
                delegate.timerDidTick(seconds: seconds)
            }
            
        }
    }
    
}
