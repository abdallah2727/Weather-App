//
//  SearchViewModel.swift
//  Weather-App
//
//  Created by Abdallah ismail on 23/08/2024.
//

import Foundation
import Combine

class SearchViewModel{
    private let networkLayer = NetworkLayer()
    
    func validateCityURL(cityName: String, completion: @escaping (Bool) -> Void) {
            let url = URL(string: Constants.getUrlUsingcityname(city: cityName))!
            URLValidate.shared.validateURL(url) { isValid in
                completion(isValid)
            }
        }
  
}
