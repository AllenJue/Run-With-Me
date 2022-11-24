//
//  Location.swift
//  Run With Me
//
//  Created by Allen Jue on 11/21/22.
//

import Foundation
import CoreLocation

class Location: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastSeenLocation: CLLocation?                /// keep track of last seen coordinate
    @Published var distanceTraveled: Double
    
    let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        distanceTraveled = 0
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations: [CLLocation]) {
        if let location = didUpdateLocations.first {
            let distanceInMeters = lastSeenLocation?.distance(from: location)
            distanceTraveled += distanceInMeters ?? 0
            lastSeenLocation = location
        }
    }
}

extension Location {
    static let sampleData = Location()
}
