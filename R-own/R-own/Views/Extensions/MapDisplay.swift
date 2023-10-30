//
//  MapDisplay.swift
//  R-own
//
//  Created by Aman Sharma on 27/06/23.
//

import SwiftUI
import MapKit

struct MapDisplay: UIViewRepresentable {
    let locations: [MapLocation]
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        
        for location in locations {
            let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            
            uiView.addAnnotation(annotation)
        }
        
        if let firstLocation = locations.first {
            let coordinate = CLLocationCoordinate2D(latitude: firstLocation.latitude, longitude: firstLocation.longitude)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            
            uiView.setRegion(region, animated: true)
        }
    }
}

struct MapLocation {
    let latitude: Double
    let longitude: Double
}








//struct ContentView: View {
//    let latitude: Double = 37.33182
//    let longitude: Double = -122.03118
//
//    var body: some View {
//        VStack {
//            MapView(latitude: latitude, longitude: longitude)
//                .frame(height: UIScreen.main.bounds.height / 2)
//
//            Text("Latitude: \(latitude), Longitude: \(longitude)")
//                .padding()
//        }
//    }
//}
