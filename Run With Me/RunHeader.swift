//
//  RunHeader.swift
//  Run With Me
//
//  Created by Allen Jue on 11/20/22.
//

import SwiftUI

struct RunHeader: View {
    let timeElapsed: Int
    let timeRemaining: Int
    let distance: Double
    
    private var totalTime: Int {
        timeElapsed + timeRemaining
    }
    
    private var minutesLeft: Int {
        timeRemaining / 60
    }
    
    private var progress: Double {
        guard totalTime > 0 else { return 1 }
        return Double(timeElapsed) / Double(totalTime)
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
            HStack {
                VStack (alignment: .leading){
                    Text("Time elapsed")
                    if(timeElapsed / 60 == 0) {
                        Label("\(timeElapsed) seconds", systemImage: "hourglass.bottomhalf.fill")
                    } else {
                        Label("\(timeElapsed / 60) minutes", systemImage: "hourglass.bottomhalf.fill")
                    }
                    
                }
                
                Spacer()
                VStack (alignment: .trailing){
                    Text("Time remaining")
                    if(timeRemaining / 60 == 0) {
                        Label("\(timeRemaining) seconds", systemImage: "hourglass.tophalf.fill")
                    } else {
                        Label("\(timeRemaining / 60) minutes", systemImage: "hourglass.tophalf.fill")
                    }
                 
                }
                
            }
        }
    }
}

struct RunHeader_Provider: PreviewProvider {
    static var previews: some View {
        RunHeader(timeElapsed: 5, timeRemaining: 12, distance: 5)
    }
}
