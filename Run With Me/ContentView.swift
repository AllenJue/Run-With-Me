//
//  ContentView.swift
//  Run With Me
//  TODO: shows remaining time of run and current pace
//
//  Created by Allen Jue on 11/17/22.
//

import SwiftUI

struct ContentView: View {
    @Binding var run: Run
    @StateObject var timer = RunTimer()
    @StateObject var location = Location()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(run.theme.mainColor)
            VStack {
                LocationView()

                RunHeader(timeElapsed: timer.secondsElapsed, timeRemaining: timer.secondsRemaining, distance: run.runDistance)
                Spacer()
                Circle()
                    .strokeBorder(lineWidth: 24)

                HStack {
                    Text("Today's Run")
                }
            }
            .padding()
        }
        .padding()
        .foregroundColor(run.theme.accentColor)
        .onAppear {
            timer.reset(secondsRemaining: run.goalTime * 60, distance: run.runDistance)
            timer.startRun()
        }
        .onDisappear {
            timer.stopRun()
            let newHistory = History(goalTime: run.goalTime, runDistance: run.runDistance)
            run.history.insert(newHistory, at: 0)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(run: .constant(Run.sampleData[0]))
    }
}
