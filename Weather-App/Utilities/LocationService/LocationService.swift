//
//  LocationService.swift
//  Weather-App
//
//  Created by Abdallah ismail on 21/08/2024.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func didUpdateLocation(latitude: Double, longitude: Double)
    func didFailWithError(_ error: Error)
}

class LocationService: NSObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    weak var delegate: LocationServiceDelegate?
    private var locationUpdated = false // Add this flag
    
    func initializeLocationManager() {
        setUpLocationManager()
        if locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways{
            updateLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func updateLocation() {
        locationManager.startUpdatingLocation()
    }
    
    private func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50 // meters
    }
    
    // CLLocationManagerDelegate methods
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            updateLocation()
        } else {
            print("Location access not authorized.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        
        // Ensure the location is only printed once
        if !locationUpdated {
            locationUpdated = true
            let latitude = lastLocation.coordinate.latitude
            let longitude = lastLocation.coordinate.longitude
            
            // Call the delegate method to pass the location data
            delegate?.didUpdateLocation(latitude: latitude, longitude: longitude)
            
            // Stop updating location to prevent further updates
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.didFailWithError(error)
        print("Failed to update location: \(error.localizedDescription)")
    }
}
