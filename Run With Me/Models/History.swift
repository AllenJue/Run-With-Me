//
//  History.swift
//  Run With Me
//
//  Created by Allen Jue on 11/20/22.
//

import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let data: Date
    var goalTime: Int
    var runDistance: Double
    
    init(id: UUID = UUID(), data: Date = Date(), goalTime: Int, runDistance: Double) {
        self.id = id
        self.data = data
        self.goalTime = goalTime
        self.runDistance = runDistance
    }
}
