//
//  DetailEditView.swift
//  Run With Me
//
//  Created by Allen Jue on 11/19/22.
//

import SwiftUI

/**
 Allows users to edit their runs by changing the distances, time, and name for a specific Run
 */
struct DetailEditView: View {
    @Binding var data: Run.Data
    
    var body: some View {
        Form {
            Section (header: Text("Run information")) {
                TextField ("Run name", text: $data.runName)
                HStack {
                    Slider(value: $data.goalTime, in: 1...60, step: 1)
                    Spacer()
                    Text("\(Int(data.goalTime)) minute(s)")
                }
                HStack {
                    Slider(value: $data.runDistance, in: 1...60, step: 0.10)
                    Spacer()
                    let formatted = String(format: "%.1f", data.runDistance)
                    Text("\(formatted) miles")
                }
                ThemePicker(selection: $data.theme)
            }
            
        }
    }
}

struct DetailEditView_Preview: PreviewProvider {
    static var previews: some View {
        DetailEditView(data: .constant((Run.sampleData[0].data)))
    }
}
