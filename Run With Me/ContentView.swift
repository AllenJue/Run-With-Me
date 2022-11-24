//
//  ContentView.swift
//  Run With Me
//  TODO: shows remaining time of run and current pace
//
//  Created by Allen Jue on 11/17/22.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @Binding var run: Run
    @StateObject var location = Location()
    @StateObject var timer = RunTimer()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(run.theme.mainColor)
            VStack {
                RunHeader(timeElapsed: timer.secondsElapsed, timeRemaining: timer.secondsRemaining, distance: location.distanceTraveled)
                Spacer()
                LocationView(metersTraveled: location.distanceTraveled, timeElapsed: timer.secondsElapsed)
                Spacer()
                HStack {
                    Text(run.runName)
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

