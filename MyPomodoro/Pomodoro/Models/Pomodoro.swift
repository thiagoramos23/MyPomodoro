//
//  File.swift
//  
//
//  Created by Thiago Ramos on 09/08/20.
//

import Foundation

public enum PomodoroState {
    case running
    case finished
    case stopped
    case paused
}

struct Pomodoro {
    private(set) var state: PomodoroState
    
    public init(state: PomodoroState = .stopped) {
        self.state   = state
    }
    
    public func start() -> Pomodoro {
        return Pomodoro(state: .running)
    }
    
    public func stop() -> Pomodoro {
        return Pomodoro(state: .stopped)
    }
    
    public func pause() -> Pomodoro {
        return Pomodoro(state: .paused)
    }
    
    public func finish() -> Pomodoro {
        return Pomodoro(state: .finished)
    }
    
    public func isNotRuning() -> Bool {
        return state != .running
    }
}
