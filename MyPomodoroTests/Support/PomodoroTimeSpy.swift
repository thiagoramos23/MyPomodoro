//
//  PomodoroTimeSpy.swift
//  MyPomodoroTests
//
//  Created by Thiago Ramos on 16/08/20.
//

import Foundation

class PomodoroTimerSpy: CountdownTimer {
    var completionCallCount: Int = 0
    var stopCallCount: Int = 0
    var seconds: TimeInterval
    
    init(seconds: TimeInterval) {
        self.seconds = seconds
    }
            
    func countdown(completion: @escaping (TimeInterval) -> Void) {
        while self.seconds > 0 && isNotStopped() {
            self.seconds -= 1
            self.completionCallCount += 1
            completion(seconds)
        }
    }
    
    func stop() {
        self.stopCallCount += 1
    }
    
    private func isNotStopped() -> Bool {
        self.stopCallCount == 0
    }
}
