//
//  PausePomodoroUseCaseTests.swift
//  MyPomodoroTests
//
//  Created by Thiago Ramos on 16/08/20.
//

import XCTest
@testable import MyPomodoro

class PausePomodoroUseCaseTests: XCTestCase {
        
    func test_pausePomodoro_shouldChangeStateToPaused() {
        let pomodoro = Pomodoro(state: .running, seconds: 5)
        let sut = makeSut(pomodoro: pomodoro)
        
        sut.pause()
        
        XCTAssertEqual(PomodoroState.paused, pomodoro.state)   
    }
    
    
    // MARK: - Helpers
    func makeSut(pomodoro: Pomodoro) -> PomodoroManager {
        let timerSpy        = PomodoroTimerSpy(pomodoro: pomodoro)
        let pomodoroManager = PomodoroManager(pomodoro: pomodoro, pomodoroTimer: timerSpy)
        return pomodoroManager
    }

}
