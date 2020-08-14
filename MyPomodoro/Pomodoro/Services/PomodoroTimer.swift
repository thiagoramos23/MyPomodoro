//
//  PomodoroCounter.swift
//  MyPomodoro
//
//  Created by Thiago Ramos on 11/08/20.
//

import Foundation

protocol CountdownTimer {
    func countdown(completion: @escaping (Pomodoro) -> Void)
}

class PomodoroTimer: CountdownTimer  {
    var pomodoro: Pomodoro
    var counter: InternalCounter
    
    init(pomodoro: Pomodoro, counter: InternalCounter) {
        self.pomodoro = pomodoro
        self.counter  = counter
    }
    
    func countdown(completion: @escaping (Pomodoro) -> Void) {
        self.counter.dispatchEventHandler = {
            if self.pomodoro.isFinished() {
                self.counter.suspend()
            }
            
            completion(self.pomodoro)
            self.pomodoro = self.pomodoro.countdown()
        }
        
        self.counter.resume()
    }
}
