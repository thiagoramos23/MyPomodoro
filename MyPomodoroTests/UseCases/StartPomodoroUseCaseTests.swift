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
        let (sut, timerSpy, exp) = makeSut(pomodoro: Pomodoro(state: .running, seconds: 5), fulfillmentExpectationCount: 5, expectationMessage: "When pomodoro is couting down")
        
        sut.start { _ in
        } receivingValue: { pomodoro in
            exp.fulfill()
        }
        
        XCTAssertEqual(timerSpy.completionCalls, 5)
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_startPomodoro_whenPomodoroIsNotActive_shouldcallCompletionWhenFinishes() {
        let (sut, timerSpy, exp) = makeSut(pomodoro: Pomodoro(state: .running, seconds: 5), fulfillmentExpectationCount: 1, expectationMessage: "When pomodoro finishes")
        
        sut.start { pomodoro in
            exp.fulfill()
        } receivingValue: { _ in
        }
        
        XCTAssertEqual(timerSpy.completionCalls, 5)
        wait(for: [exp], timeout: 1.0)
    }
        
    // MARK: - Helpers
    func makeSut(pomodoro: Pomodoro, fulfillmentExpectationCount: Int, expectationMessage: String = "When testing pomodoro") -> (PomodoroManager, PomodoroTimerSpy, XCTestExpectation) {
        let timerSpy        = PomodoroTimerSpy(pomodoro: pomodoro)
        let pomodoroManager = PomodoroManager(pomodoro: pomodoro, pomodoroTimer: timerSpy)
        let exp = expectation(description: expectationMessage)
        exp.expectedFulfillmentCount = fulfillmentExpectationCount
        return (pomodoroManager, timerSpy, exp)
    }
}
