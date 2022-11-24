//
//  CurrentRun.swift
//  Run With Me
//
//  Created by Allen Jue on 11/18/22.
//

import Foundation

/* Object for a singular run */
struct Run: Identifiable, Codable {
    var id: UUID                /* Needs UUID to identify for ForEach */
    var runName: String         /* Name of run */
    var runDistance: Double     /* Distance of run */
    var goalTime: Int           /* Time of run in minutes */
    var theme: Theme            /* Color of run object */
    var history: [History] = []
    init(id: UUID = UUID(), runName: String, runDistance: Double, goalTime: Int, theme: Theme) {
        self.id = id
        self.runName = runName
        self.runDistance = runDistance
        self.goalTime = goalTime
        self.theme = theme
        
    }
}

/**
 Allows for Run structs to have a CompletedRun identifiable field. Also includes a default constructor
 */
extension Run {
    struct Data {
        var runName: String = ""
        var runDistance: Double = 1
        var goalTime: Double = 1
        var theme: Theme = .pastey
    }
    
    var data: Data {
        Data(runName: runName, runDistance: runDistance, goalTime: Double(goalTime), theme: theme)
    }
    
    mutating func update(from data: Data) {
        runName = data.runName
        runDistance = data.runDistance
        goalTime = Int(data.goalTime)
        theme = data.theme
        print("Updating")
    }
    
    init(data: Data) {
        id = UUID()
        runName = data.runName
        runDistance = data.runDistance
        goalTime = Int(data.goalTime)
        theme = data.theme
    }
}


extension Run {
    static let sampleData: [Run] =
    [
        Run (runName: "Long run", runDistance: 5, goalTime: 1,theme: .pastey),
        Run (runName: "Medium run", runDistance: 2, goalTime: 2,theme: .ocean),
        Run (runName: "Short run", runDistance: 1, goalTime: 1,theme: .platinum)
    ]
}
