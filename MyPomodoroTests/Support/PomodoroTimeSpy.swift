//
//  PomodoroTimeSpy.swift
//  MyPomodoroTests
//
//  Created by Thiago Ramos on 16/08/20.
//

import Foundation

class PomodoroTimerSpy: CountdownTimer {
    var pomodoro: Pomodoro
    
    init(pomodoro: Pomodoro) {
        self.pomodoro = pomodoro
    }
            
    func countdown(completion: @escaping (Pomodoro) -> Void) {
        while pomodoro.isActive() {
            pomodoro = pomodoro.countdown()
            completion(pomodoro)
        }
        
        if pomodoro.isPaused() {
            completion(pomodoro)
        }
    }
    
    func pausePomodoro() {
        self.pomodoro = Pomodoro(state: .paused, seconds: self.pomodoro.seconds)
    }
}
