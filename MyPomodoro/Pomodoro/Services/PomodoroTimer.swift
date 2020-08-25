//
//  PomodoroCounter.swift
//  MyPomodoro
//
//  Created by Thiago Ramos on 11/08/20.
//

import Foundation

protocol CountdownTimer {
    func countdown(completion: @escaping (TimeInterval) -> Void)
    func stop()
}

class PomodoroTimer: CountdownTimer  {
    var timeInSeconds: TimeInterval
    var counter: InternalCounter

    init(timeInSeconds: TimeInterval, counter: InternalCounter) {
        self.timeInSeconds = timeInSeconds
        self.counter  = counter
    }
        
    func countdown(completion: @escaping (TimeInterval) -> Void) {
        self.counter.dispatchEventHandler = { [weak self] in
            completion(self?.subtract(seconds: 1) ?? 0)
            self?.stopWhenReachesZeroSeconds()
        }

        self.counter.resume()
    }
    
    func stop() {
        self.counter.suspend()
    }
    
    fileprivate func subtract(seconds: Int) -> TimeInterval {
        self.timeInSeconds -= 1
        return self.timeInSeconds
    }

    fileprivate func stopWhenReachesZeroSeconds() {
        if self.timeInSeconds == 0 {
            self.stop()
        }
    }

}
