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

public class Pomodoro: Equatable {
    private(set) var state: PomodoroState
    private(set) var seconds: Int
    
    public init(state: PomodoroState = .stopped, seconds: Int = 1500) {
        self.state   = state
        self.seconds = seconds
    }
    
    public func start() -> Pomodoro {
        return Pomodoro(state: .running, seconds: self.seconds)
    }
    
    public func stop() -> Pomodoro {
        return Pomodoro(state: .stopped, seconds: self.seconds)
    }
    
    public func countdown() -> Pomodoro {
        if self.seconds <= 1 {
            return Pomodoro(state: .finished, seconds: 0)
        }
        
        return Pomodoro(state: self.state, seconds: self.seconds - 1)
    }
    
    public func isActive() -> Bool {
        return state == .running && seconds > 0
    }
    
    public func isInactive() -> Bool {
        return !isActive()
    }
    
    public func isFinished() -> Bool {
        return self.state == .finished
    }
    
    public func getState() -> PomodoroState {
        return self.state
    }
    
    public static func == (lhs: Pomodoro, rhs: Pomodoro) -> Bool {
        if lhs.state == rhs.state && lhs.seconds == rhs.seconds {
            return true
        }
        return false
    }
}
