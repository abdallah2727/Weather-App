//
//  NetworkLayerProtocol.swift
//  Weather-App
//
//  Created by Abdallah ismail on 21/08/2024.
//

import Foundation
import Combine
protocol NetworkLayerProtocol {
    func fetchData<T: Decodable>(from url: URL, as type: T.Type) -> AnyPublisher<T, Error>
}
