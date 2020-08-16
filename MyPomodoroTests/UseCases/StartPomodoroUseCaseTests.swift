//
//  File.swift
//  
//
//  Created by Thiago Ramos on 04/08/20.
//

import XCTest
@testable import MyPomodoro

final class StartPomodoroTests: XCTestCase {
    
    func test_startPomodoro_shouldStartCounterAndReceiveValuesForTheSpecifiedAmountOfSeconds() {
        let (sut, _, exp) = makeSut(pomodoro: Pomodoro(state: .running, seconds: 5), expectationFulfillment: 5)
        
        sut.start { _ in
        } receivingValue: { pomodoro in
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_startPomodoro_shouldcallCompletionWhenFinishes() {
        let (sut, _, exp) = makeSut(pomodoro: Pomodoro(state: .running, seconds: 5), expectationFulfillment: 1)
        sut.start { pomodoro in
            exp.fulfill()
        } receivingValue: { _ in
        }
        
        wait(for: [exp], timeout: 1.0)
    }
        
    // MARK: - Helpers
    func makeSut(pomodoro: Pomodoro, expectationFulfillment: Int) -> (PomodoroManager, CountdownTimer, XCTestExpectation) {
        let exp = expectation(description: "When Pomodoro finishes")
        exp.expectedFulfillmentCount = expectationFulfillment
        let timerSpy        = PomodoroTimerSpy(pomodoro: pomodoro)
        let pomodoroManager = PomodoroManager(pomodoro: pomodoro, pomodoroTimer: timerSpy)
        return (pomodoroManager, timerSpy, exp)
    }
}
