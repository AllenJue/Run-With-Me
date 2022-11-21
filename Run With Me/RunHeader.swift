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
                    Label("\(timeElapsed / 60)", systemImage: "hourglass.bottomhalf.fill")
                }
                
                Spacer()
                VStack (alignment: .trailing){
                    Text("Time remaining")
                    
                    Label("\(timeRemaining / 60)", systemImage: "hourglass.tophalf.fill")
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
