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
        return PomodoroManagerViewModel(
            pomodoroManager: PomodoroManager(
                pomodoroTimer: PomodoroTimer(
                    timeInSeconds: 1500,
                    counter: Counter(
                        interval: 1
                    )
                ),
                nextPomodoroType: PomodoroType.breakInterval
            )
        )
    }
}
