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
    /// optional error handling value
    @State private var errorHandler: ErrorWrapper?
    
    var body: some Scene {
        /// main window group for the app, where it is navigatable
        WindowGroup {
            NavigationView {
                /// pass in a binding for an array of Runs, which will be rendered by the RunView and used as a source of truth
                RunView(runs: $runStore.runs) {
                    Task {
                        do {
                            try await DataStore.save(runs: runStore.runs)
                        } catch {
                            errorHandler = ErrorWrapper(error: error, guidance: "Try again later")
                        }
                    }
                }
            }
            .task {
                do {
                    runStore.runs = try await DataStore.load()
                } catch {
                    errorHandler = ErrorWrapper(error: error, guidance: "Could not load data successfully")
                }
            }
            .sheet(item: $errorHandler, onDismiss: {
                /// fill with sample data on dismiss when user dismisses
                runStore.runs = Run.sampleData
            }) { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
//            .sheet(item: , content: <#T##(Identifiable) -> View#>)
        }
    }
}
