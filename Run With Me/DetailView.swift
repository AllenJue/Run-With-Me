//
//  DetailView.swift
//  Run With Me
//
//  Created by Allen Jue on 11/19/22.
//

import SwiftUI

/**
 Creates a View for a particular run that can be accessed from a Run card
 */
struct DetailView: View {
    @Binding var run: Run
    @State private var isEditing = false
    @State private var data = Run.Data() /* Source of truth */
    @State private var location = Location()

    var body: some View {
        /**
         Create a list of details, which describe the goal time, run distance, completed runs, and gives the user the opportunity to start the run.
         */
        VStack {
            List {
                Section(header: Text("Run info")) {
                    NavigationLink(destination: ContentView(run: $run)) {
                        Label("Start Run", systemImage: "timer")
                            .font(.headline)
                            .foregroundColor(.accentColor)
                    }
                    HStack {
                        Label("Goal Time", systemImage: "clock")
                        Spacer()
                        Text("\(run.goalTime) minutes")
                    }
                    HStack {
                        Label("Run Distance", systemImage: "map.circle")
                        Spacer()
                        let formatted = String(format: "%.1f", run.runDistance)
                        Text("\(formatted) miles")
                    }
                }
                Section(header: Text("History")) {
                    ForEach (run.history) { history in
                        Text(history.data, style: .date)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            
        }
        .navigationTitle(run.runName)
        .onAppear {
            location.requestPermission()
        }
        .toolbar {
            Button("Edit") {
                isEditing = true;
                data = run.data
            }
        }
        .sheet(isPresented: $isEditing) {
            NavigationView {
                DetailEditView(data: $data)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isEditing = false;
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isEditing = false
                                run.update(from: data)
                            }
                        }
                    }
            }
            
        }
        .navigationTitle(run.runName)
    }
}


struct DetailView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(run: .constant(Run.sampleData[0]))
        }
    }
}
