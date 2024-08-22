//
//  Constatns.swift
//  Weather-App
//
//  Created by Abdallah ismail on 22/08/2024.
//

import Foundation
// MARK: - Constants
public struct Constants {
   enum WeatherCondition:String{
        case clear = "Clear"
        case rain = "Rain"
        case clouds = "Clouds"
    }
   static let celuisSymbol = "°C"
   static let km = "/km"
   static let hu = "g/kg"

}
// MARK: - Functions
extension Constants{
    static func getUrlUsingCoord(lat: Double, lon: Double) -> String {
        let baseurl = "https://api.openweathermap.org/data/2.5/weather?"
        let apiKey = "a4fb53215b8b14a3e0cfa0845c7dcf66"
        let units = "metric"
        return "\(baseurl)lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=\(units)"
    }
}

