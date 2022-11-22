//
//  LocationView.swift
//  Run With Me
//
//  Created by Allen Jue on 11/21/22.
//

import Foundation
import SwiftUI

struct LocationView: View {
    @StateObject var location = Location()
    var body: some View {
        switch location.locationManager.authorizationStatus {
        case .notDetermined:
            AnyView(RequestLocationView())
                .environmentObject(location)
        case .restricted:
            Text("Restricted")
        case .denied:
            Text("Denied")
        case .authorizedAlways, .authorizedWhenInUse:
            TrackingView()
                .environmentObject(location)
        default:
            Text("Unexpected status")
        }
    }
}
 
struct RequestLocationView: View {
    @EnvironmentObject var location: Location
        var body: some View {
            VStack {
                Image(systemName: "location.circle")
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Button(action: {
                    location.requestPermission()
                }, label: {
                    Label("Allow tracking", systemImage: "location")
                })
                .padding(10)
                .foregroundColor(.white)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                Text("We need your permission to track you.")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
        }
}

struct TrackingView: View {
    @EnvironmentObject var locationViewModel: Location
    var body: some View {
        Text("Thanks!")
    }
}

struct LocationView_Preview: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
