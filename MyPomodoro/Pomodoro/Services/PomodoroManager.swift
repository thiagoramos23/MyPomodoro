//
//  File.swift
//  
//
//  Created by Thiago Ramos on 09/08/20.
//

import Foundation

protocol Manager {
    typealias CompletionHandler = (Pomodoro) -> Void
    typealias ReceivingValueHandler = (Pomodoro) -> Void

    func start(completion: @escaping CompletionHandler, receivingValue: @escaping ReceivingValueHandler)
}

public final class PomodoroManager: Manager {
    private var pomodoroTimer: CountdownTimer
    private var pomodoro: Pomodoro
    
    init(pomodoro: Pomodoro, pomodoroTimer: CountdownTimer) {
        self.pomodoro      = pomodoro
        self.pomodoroTimer = pomodoroTimer
    }
    
    func start(completion: @escaping CompletionHandler, receivingValue: @escaping ReceivingValueHandler) {
        // TODO: Add spec for when a client pauses the pomodoro. This should call the completion block.
        self.pomodoroTimer.countdown { pomodoro in
            self.pomodoro = pomodoro
            if pomodoro.isInactive() {
                completion(pomodoro)
            }
            receivingValue(pomodoro)
        }
    }
    
}
