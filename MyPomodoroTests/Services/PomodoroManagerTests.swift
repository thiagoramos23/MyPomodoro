//
//  File.swift
//  
//
//  Created by Thiago Ramos on 04/08/20.
//

import XCTest
@testable import MyPomodoro

final class PomodoroManagerStartTests: XCTestCase {
    
    func test_startPomodoro_shouldStartCounterAndReceiveValuesForTheSpecifiedAmountOfSeconds() {
        let (sut, exp) = makeSut(pomodoro: Pomodoro(state: .running, seconds: 5), expectationFulfillment: 5)
        
        sut.start { _ in
        } receivingValue: { pomodoro in
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_startPomodoro_shouldcallCompletionWhenFinishes() {
        let (sut, exp) = makeSut(pomodoro: Pomodoro(state: .running, seconds: 5), expectationFulfillment: 1)
        sut.start { pomodoro in
            exp.fulfill()
        } receivingValue: { _ in
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: - Helpers
    
    func makeSut(pomodoro: Pomodoro, expectationFulfillment: Int) -> (PomodoroManager, XCTestExpectation) {
        let exp = expectation(description: "When Pomodoro finishes")
        exp.expectedFulfillmentCount = expectationFulfillment
        let pomodoroManager = PomodoroManager(pomodoro: pomodoro, pomodoroTimer: PomodoroTimerSpy(pomodoro: pomodoro))
        return (pomodoroManager, exp)
    }

    class PomodoroTimerSpy: CountdownTimer {
        var pomodoro: Pomodoro
        
        init(pomodoro: Pomodoro) {
            self.pomodoro = pomodoro
        }
        
        func countdown(completion: @escaping (Pomodoro) -> Void) {
            while !pomodoro.isFinished() {
                pomodoro = pomodoro.countdown()
                completion(pomodoro)
            }
        }
        
    }
}
