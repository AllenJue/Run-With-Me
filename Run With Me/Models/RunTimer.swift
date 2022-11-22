//
//  RunTimer.swift
//  Run With Me
//  Source of Truth for the timer, Adapted from Apple ScrumDinger code
//
//  Created by Allen Jue on 11/20/22.
//

import Foundation
import MapKit

class RunTimer: ObservableObject {
    /// The number of seconds since the beginning of the run.
    @Published var secondsElapsed = 0
    /// Time remaining in current run.
    @Published var secondsRemaining = 0
    /// The distance in miles left to run
    private(set) var distance: Double
    
    /// TODO perhaps need a cur location and prev location
    private(set) var lengthInMinutes: Int
    private(set) var totalSeconds: Int
    private var timer: Timer?
    private var timerStopped = false
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var startDate: Date?
    
    
    /// Stop the timer.
    func stopRun() {
        timer?.invalidate()
        timer = nil
        timerStopped = true
    
    }
    
    init(timeRemaining: Int = 0, distance: Double = 0) {
        self.secondsRemaining = timeRemaining * 60
        self.distance = distance
        lengthInMinutes = timeRemaining / 60
        secondsElapsed = 0
        totalSeconds = timeRemaining * 60
    }
    
    
    /// Start the timer.
    func startRun() {
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            if let self = self, let startDate = self.startDate {
                let secondsElapsed = Date().timeIntervalSince1970 - startDate.timeIntervalSince1970
                self.update(secondsElapsed: Int(secondsElapsed))
            }
        }
    }
    
    /// Update the clock
    func update(secondsElapsed: Int) {
        self.secondsElapsed = secondsElapsed
        self.secondsRemaining = max(totalSeconds - self.secondsElapsed, 0)
        if(self.secondsRemaining == 0) {
            stopRun()
        }
        guard !timerStopped else { return }
    }
    
    /// Reset the timer to some new kind of Run
    func reset(secondsRemaining: Int, distance: Double) {
        self.secondsRemaining = secondsRemaining
        self.distance = distance
        secondsElapsed = 0
        lengthInMinutes = secondsRemaining / 60
        totalSeconds = secondsRemaining
    }
    
}
