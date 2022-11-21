//
//  RunView.swift
//  Run With Me
//
//  Created by Allen Jue on 11/18/22.
//

import SwiftUI

struct RunView: View {
    @Binding var runs: [Run]                            /// Binding variable that represents a shared list of Runs throughout the entirety of the code hierarchy
    @Environment(\.scenePhase) private var scenePhase   /// Keeps track of current scene's state. When it becomes inactive, save state
    @State private var isPresentingNewRun = false       /// Trigger for adding a new run
    @State private var newRunData = Run.Data()          /// Variable for new run data, can be added to runs
    let saveAction: ()->Void
    
    var body: some View {
        /// Display run in a list
        List {
            ForEach($runs) { $run in
                NavigationLink (destination: DetailView(run: $run)){
                    CardView(run: run)

                }
                .listRowBackground(run.theme.mainColor)
            }
        }
        .navigationTitle("Runs")
        .toolbar {
            Button(action: { isPresentingNewRun = true }) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Run")
        }
        .sheet(isPresented: $isPresentingNewRun) { /// pops up a sheet to potentially add a new run
            NavigationView {
                DetailEditView(data: $newRunData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewRun = false;
                                newRunData = Run.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newScrum = Run(data: newRunData)
                                runs.append(newScrum)
                                isPresentingNewRun = false;
                                newRunData = Run.Data()
                            }
                        }
                    }
            }
        }
        /// if the phase ever becomes inactive, save state
        .onChange(of: scenePhase) { phase in
            if(phase == .inactive) {
                saveAction()
            }
        }
    }
}

struct RunView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RunView(runs: .constant(Run.sampleData), saveAction: {})
        }
    }
}
