//
//  File.swift
//  
//
//  Created by Thiago Ramos on 09/08/20.
//

import Foundation

protocol Manager {
    typealias CompletionHandler = (TimeInterval) -> Void
    typealias ReceivingValueHandler = (TimeInterval) -> Void

    func start(completion: @escaping CompletionHandler, receivingValue: @escaping ReceivingValueHandler)
    func pause()
}

public final class PomodoroManager: Manager {
    private var pomodoroTimer: CountdownTimer
    private var pomodoro: Pomodoro = Pomodoro(state: .stopped)
    
    init(pomodoroTimer: CountdownTimer) {
        self.pomodoroTimer = pomodoroTimer
    }
    
    func pause() {
        self.pomodoro = Pomodoro(state: .paused)
        self.pomodoroTimer.stop()
    }
        
    func start(completion: @escaping CompletionHandler, receivingValue: @escaping ReceivingValueHandler) {
        guard self.pomodoro.isNotRuning() else { return }
        
        self.pomodoro = Pomodoro(state: .running)
        self.pomodoroTimer.countdown { timeInterval in
            if timeInterval == 0 {
                completion(timeInterval)
            } else {
                receivingValue(timeInterval)
            }
        }
    }
    
}
