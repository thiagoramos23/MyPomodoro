//
//  PomodoroCounterTests.swift
//  MyPomodoroTests
//
//  Created by Thiago Ramos on 11/08/20.
//

import XCTest

class PomodoroTimerTests: XCTestCase {

    func test_countdown_countDownsPomodoroUntilZero() {
        let (sut, _) = makeSut(seconds: 5)
        let exp = expectation(description: "Counting down pomodoro")
        exp.expectedFulfillmentCount = 5

        sut.countdown() { _ in
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
    }
    
    func test_countdown_callsDispatchEventHandlerEveryTimeInterval() {
        let (sut, spy) = makeSut(seconds: 10)
        let exp = expectation(description: "Counting down pomodoro")
        exp.expectedFulfillmentCount = 10

        sut.countdown { _ in
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertEqual(spy.dispatchCallCount, 10)
    }
    
    func test_stop_shouldSuspendCounter() {
        let (sut, spy) = makeSut(seconds: 10)
        let exp = expectation(description: "Should not keep calling countdown")
        exp.expectedFulfillmentCount = 1
        
        sut.countdown { time in
            sut.stop()
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(spy.stopCallCount, 1)
    }
    
    private func makeSut(seconds: Int) -> (PomodoroTimer, CounterSpy) {
        let spy = CounterSpy(interval: TimeInterval(1))
        let sut = PomodoroTimer(timeInSeconds: TimeInterval(seconds), counter: spy)
        return (sut, spy)
    }
    
    class CounterSpy: InternalCounter {
        var isSuspended = false
        var dispatchCallCount = 0
        var stopCallCount = 0
        
        var dispatchEventHandler: (() -> Void)?
        
        private var interval: TimeInterval
        
        init(interval: TimeInterval) {
            self.interval = interval
        }
                        
        func resume() {
            while !isSuspended {
                self.dispatchEventHandler?()
                self.dispatchCallCount += 1
            }
        }
        
        func suspend() {
            self.stopCallCount += 1
            self.isSuspended = true
        }
    }
}
