//
//  UrlValidation.swift
//  Weather-App
//
//  Created by Abdallah ismail on 23/08/2024.
//

import Foundation

class URLValidate{
    static let shared = URLValidate()
    
    private init() {}
    
    func validateURL(_ url: URL, completion: @escaping (Bool) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD" // Using HEAD to check the validity of the URL without downloading the entire content
        
        let task = URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                completion(httpResponse.statusCode == 200)
            } else {
                completion(false)
            }
        }
        task.resume()
    }
}
