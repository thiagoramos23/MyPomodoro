//
//  PomodoroCounterTests.swift
//  MyPomodoroTests
//
//  Created by Thiago Ramos on 11/08/20.
//

import XCTest

class PomodoroTimerTests: XCTestCase {

    func test_counter_countDownsPomodoroUntilZero() {
        let pomodoro = Pomodoro(state: .running, seconds: 2)
        let sut = PomodoroTimer(pomodoro: pomodoro, counter: CounterSpy(interval: TimeInterval(2)))
        let exp = expectation(description: "Counting down pomodoro")
        exp.expectedFulfillmentCount = 3
        
        sut.countdown() { pomodoro in
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    class CounterSpy: InternalCounter {
        var dispatchEventHandler: (() -> Void)?
        
        private var interval: TimeInterval
        
        init(interval: TimeInterval) {
            self.interval = interval
        }
                        
        func resume() {
            (0...Int(self.interval)).forEach { _ in
                dispatchEventHandler!()
            }
        }
        
        func suspend() {
        }
    }
}
