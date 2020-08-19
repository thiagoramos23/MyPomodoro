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
    func pause()
}

public final class PomodoroManager: Manager {
    private var pomodoroTimer: CountdownTimer
    private var pomodoro: Pomodoro
    
    init(pomodoro: Pomodoro, pomodoroTimer: CountdownTimer) {
        self.pomodoro      = pomodoro
        self.pomodoroTimer = pomodoroTimer
    }
    
    func pause() {
        self.pomodoro = Pomodoro(state: .paused, seconds: pomodoro.seconds)
    }
    
    func start(completion: @escaping CompletionHandler, receivingValue: @escaping ReceivingValueHandler) {
        self.pomodoroTimer.countdown { pomodoro in
            if pomodoro.seconds == 0 {
                completion(pomodoro)
            }
            receivingValue(pomodoro)
            
        }
    }
    
}
