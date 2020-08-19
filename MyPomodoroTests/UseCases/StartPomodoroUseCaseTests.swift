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
        let (sut, timerSpy, exp) = makeSut(pomodoro: Pomodoro(state: .running, seconds: 5), fulfillmentExpectationCount: 4, expectationMessage: "When pomodoro is couting down")
        
        sut.start { _ in
        } receivingValue: { pomodoro in
            exp.fulfill()
        }
        
        XCTAssertEqual(timerSpy.completionCallCount, 5)
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_startPomodoro_whenPomodoroIsCountingDown_shouldcallCompletionWhenFinishes() {
        let (sut, timerSpy, exp) = makeSut(pomodoro: Pomodoro(state: .running, seconds: 5), fulfillmentExpectationCount: 1, expectationMessage: "When pomodoro finishes")
        
        sut.start { pomodoro in
            exp.fulfill()
        } receivingValue: { _ in
        }
        
        XCTAssertEqual(timerSpy.completionCallCount, 5)
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_startPomodoro_whenPomodoroChangesState_shouldCallCompletionAndStopCountdown() {
        let pomodoro = Pomodoro(state: .running, seconds: 5)
        let (sut, timerSpy, exp) = makeSut(pomodoro: pomodoro, fulfillmentExpectationCount: 1, expectationMessage: "When pomodoro is not in running state")
        let receiveValueExpectation = expectation(description: "receivingValue for pomodoro")
        
        sut.start { pomodoro in
            exp.fulfill()
        } receivingValue: { _ in
            sut.pause()
            receiveValueExpectation.fulfill()
        }
        
        XCTAssertEqual(timerSpy.completionCallCount, 2)
        XCTAssertEqual(timerSpy.stopCallCount, 1)
        wait(for: [receiveValueExpectation, exp], timeout: 1.0)
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
