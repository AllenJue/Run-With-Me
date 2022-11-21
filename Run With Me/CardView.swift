//
//  CardView.swift
//  Run With Me
//  Appearance for a singular card (run entry)
//
//  Created by Allen Jue on 11/18/22.
//

import SwiftUI

struct CardView: View {
    let run: Run
    var body: some View {
        VStack(alignment: .leading) {
            Text(run.runName).font(.headline)
            Spacer()
            HStack() {
                let formatted = String(format: "%.1f", run.runDistance)
                Label("Distance: \(formatted)", systemImage: "hourglass.circle")
                Spacer()
               
                Label("Target Time: \(run.goalTime)", systemImage: "hourglass.circle")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption)
        }
//        .foregroundColor(run.theme.accentColor)
        .padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var sample_run = Run.sampleData[0]
    static var previews: some View {
        CardView(run: sample_run)
                    .background(sample_run.theme.mainColor)
    }
}
