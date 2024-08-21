//
//  ViewModel.swift
//  Weather-App
//
//  Created by Abdallah ismail on 21/08/2024.
//

import Foundation
import CoreLocation
class HomeViewModel{
    let locationService = LocationService()
    func viewDidLoad(){
        locationService.delegate = self
        locationService.initializeLocationManager()
    }
}
extension HomeViewModel:LocationServiceDelegate{
    func didUpdateLocation(latitude: Double, longitude: Double) {
        print("Latitude: \(latitude), Longitude: \(longitude)")
        
    }
    
    func didFailWithError(_ error: any Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
}
