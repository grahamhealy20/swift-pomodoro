//
//  Pomodoro.swift
//  Pomodoro
//
//  Created by Graham Healy on 17/05/2019.
//  Copyright © 2019 Graham Healy. All rights reserved.
//

import Foundation


protocol PomodoroTimerDelegate {
    func timerDidTick(seconds: Int)
    func timerDidEnd()
}


class PomodoroTimer {
    var delegate: PomodoroTimerDelegate?
    
    var timer: Timer!
    var seconds = 60
    
    init() {}
    
    func start() {
        // Start the timer and add it to the run loop for the current thread (so it runs async and wont block the UI).
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
    }
    
    func pause() {
        // TODO: Pause the timer
    }
    
    func reset() {
        // TODO Reset the timer to default state
        seconds = 60
    }
    
    @objc func timerTick() {
        if seconds < 1 {
            timer.invalidate()
        
            // TODO: Fire timerDidEnd delegate method
            reset()
            
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
