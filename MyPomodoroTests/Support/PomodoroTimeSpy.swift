//
//  PomodoroTimeSpy.swift
//  MyPomodoroTests
//
//  Created by Thiago Ramos on 16/08/20.
//

import Foundation

class PomodoroTimerSpy: CountdownTimer {
    var pomodoro: Pomodoro
    var completionCallCount: Int = 0
    var stopCallCount: Int = 0
    
    init(pomodoro: Pomodoro) {
        self.pomodoro = pomodoro
    }
            
    func countdown(completion: @escaping (Pomodoro) -> Void) {
        while pomodoro.seconds > 0 && isNotStopped() {
            self.completionCallCount += 1
            pomodoro = Pomodoro(state: pomodoro.state, seconds: pomodoro.seconds - 1)
            completion(pomodoro)
        }
    }
    
    func stop() {
        self.stopCallCount += 1
    }
    
    private func isNotStopped() -> Bool {
        self.stopCallCount == 0
    }
}
