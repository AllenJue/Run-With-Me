//
//  LocationView.swift
//  Run With Me
//
//  Created by Allen Jue on 11/21/22.
//

import Foundation
import SwiftUI
import CoreLocation

let METER_TO_MILE_CONVERSION = 1_609.34
let SECONDS_TO_HOURS_CONVERSION = 3_600.0
struct LocationView: View {
    let metersTraveled: Double
    let timeElapsed: Int
    var body: some View {
        VStack {
            let milesTraveled = convertMetersToMiles(metersTraveled: metersTraveled)
            let formattedDistance = String(format: "%.2f", milesTraveled)
            Label("Distance traveled: \(formattedDistance) miles", systemImage: "map.circle")
            let formattedSpeed = String(format: "%.2f", getAvgSpeed(timeElapsed: timeElapsed, distanceInMiles: milesTraveled))
            Label("Average speed: \(formattedSpeed) mph", systemImage: "move.3d")
        }
    }
}

func convertMetersToMiles(metersTraveled: Double) -> Double {
    return metersTraveled / METER_TO_MILE_CONVERSION
}

func getAvgSpeed(timeElapsed: Int, distanceInMiles: Double) -> Double {
    return distanceInMiles / (Double(timeElapsed) / SECONDS_TO_HOURS_CONVERSION)
}

struct LocationView_Preview: PreviewProvider {
    static var previews: some View {
        LocationView(metersTraveled: 2000.0, timeElapsed: 7200)
    }
}
