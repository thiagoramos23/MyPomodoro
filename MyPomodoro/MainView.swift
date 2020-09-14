//
//  ContentView.swift
//  MyPomodoro
//
//  Created by Thiago Ramos on 09/08/20.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var pomodoroManager: PomodoroManagerViewModel
    
    init(pomodoroManager: PomodoroManagerViewModel) {
        self.pomodoroManager = pomodoroManager
    }
    
    var body: some View {
        VStack {
            Text(self.pomodoroManager.timerString)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(Font.system(size: 80))
            Button(action: {
                self.pomodoroManager.start()
            }, label: {
                Text("START")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            })
        }
        .padding(20)
        .frame(width: 300, height: 300)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(pomodoroManager:
            PomodoroManagerViewModel(pomodoroManager:
                PomodoroManager(
                    pomodoroTimer:
                        PomodoroTimer(
                            timeInSeconds: 1500,
                            counter: Counter(interval: 1)
                        ),
                    nextPomodoroType: PomodoroType.breakInterval
                )
            )
        )
    }
}
