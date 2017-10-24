//
//  NavigationViewController.swift
//  CementechThunderbolt
//
//  Created by Debashis Banerjee on 24/10/17.
//  Copyright © 2017 Debashis Banerjee. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class NavigationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    let locationManager = CLLocationManager()
    var currentLocation:CLLocationCoordinate2D?
    //destination 37.338027, -122.032209
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        self.mapView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        currentLocation = locValue
        locationManager.stopUpdatingLocation()
        openMapForPlace()
    }
    func openMapForPlace() {
        let center = CLLocationCoordinate2D(latitude: (currentLocation?.latitude)!, longitude: (currentLocation?.longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        
        let newPin = MKPointAnnotation()
        newPin.coordinate = currentLocation!
        newPin.title = "My Current Location"
        self.mapView.addAnnotation(newPin)
        
        let destinationLocation = CLLocationCoordinate2D(latitude: 37.771978, longitude: -122.423385)
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "My Destination"
        destinationAnnotation.coordinate = destinationLocation
        self.mapView.addAnnotation(destinationAnnotation)
        
        
        let sourcePlacemark = MKPlacemark(coordinate: currentLocation!, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            let route = response.routes[0]
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            //let rect = route.polyline.boundingMapRect
            //self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }  
        
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
        return renderer
    }
}
