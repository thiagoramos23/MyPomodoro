//
//  MyPomodoroApp.swift
//  MyPomodoro
//
//  Created by Thiago Ramos on 09/08/20.
//

import SwiftUI

@main
struct MyPomodoroApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(pomodoroManager: createPomodoroManager())
        }
    }
}

extension MyPomodoroApp {
    
    func createPomodoroManager() -> PomodoroManagerViewModel {
        let newPomodoro = Pomodoro(state: .running, seconds: 5)
        return PomodoroManagerViewModel(
            pomodoroManager: PomodoroManager(
                pomodoro: newPomodoro,
                pomodoroTimer: PomodoroTimer(
                    pomodoro: newPomodoro,
                    counter: Counter(
                        interval: TimeInterval(1)
                    )
                )
            )
        )
    }
}
