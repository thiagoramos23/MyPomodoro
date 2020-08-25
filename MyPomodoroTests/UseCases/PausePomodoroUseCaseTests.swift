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
        let (sut, timerSpy) = makeSut(seconds: 5)
        
        sut.pause()
        
        XCTAssertEqual(timerSpy.stopCallCount, 1)
    }
    
    func test_pausePomodoro_whenPomodoroIsRunning_shouldStopPomodoro() {
        let (sut, timerSpy) = makeSut(seconds: 5)
        let exp = expectation(description: "pomodoro should never call complete")
        exp.isInverted = true
        
        let receiveValueExpectation = expectation(description: "receivingValue should be calling once")
        receiveValueExpectation.expectedFulfillmentCount = 1
        
        sut.start { _ in
            exp.fulfill()
        } receivingValue: { _ in
            sut.pause()
            receiveValueExpectation.fulfill()
        }
        
        XCTAssertEqual(timerSpy.stopCallCount, 1)
        wait(for: [receiveValueExpectation, exp], timeout: 1.0)
    }
    
    
    // MARK: - Helpers
    func makeSut(seconds: TimeInterval) -> (PomodoroManager, PomodoroTimerSpy) {
        let timerSpy        = PomodoroTimerSpy(seconds: seconds)
        let pomodoroManager = PomodoroManager(pomodoroTimer: timerSpy)
        return (pomodoroManager, timerSpy)
    }

}
