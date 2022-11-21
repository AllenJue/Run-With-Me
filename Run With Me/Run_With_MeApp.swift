//
//  Run_With_MeApp.swift
//  Run With Me
//
//  Created by Allen Jue on 11/17/22.
//

import SwiftUI

@main
struct Run_With_MeApp: App {
    
//    @State private var sampleData = Run.sampleData
    /// loads an instance of a data store
    @StateObject private var runStore = DataStore()
    var body: some Scene {
        /// main window group for the app, where it is navigatable
        WindowGroup {
            NavigationView {
                /// pass in a binding for an array of Runs, which will be rendered by the RunView and used as a source of truth
                RunView(runs: $runStore.runs) {
                    DataStore.save(runs: runStore.runs) { result in
                        if case.failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
            }
            .onAppear {
                DataStore.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let runs):
                        runStore.runs = runs
                    }
                    
                }
            }
        }
    }
}
