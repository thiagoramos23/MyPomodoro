//
//  PomodoroManagerViewModel.swift
//  MyPomodoro
//
//  Created by Thiago Ramos on 09/08/20.
//

import Foundation
import Combine

class PomodoroManagerViewModel: ObservableObject {
    @Published var timerString: String = "25:00"
    private var pomodoroManager: Manager
    
    init(pomodoroManager: Manager) {
        self.pomodoroManager = pomodoroManager
    }
    
    func start() {
        pomodoroManager.start { timeInterval in
            print("Pomodoro is finished")
        } receivingValue: { timeInterval in
            DispatchQueue.main.async {
                let seconds = Int(timeInterval)
                let formattedMinutes = String(format: "%02d", (seconds % 3600) / 60)
                let formattedSeconds = String(format: "%02d", (seconds % 60))
                self.timerString = "\(formattedMinutes):\(formattedSeconds)"
            }
        }
    }
    
}
