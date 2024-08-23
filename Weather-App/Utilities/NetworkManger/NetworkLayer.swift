//
//  NetworkLayer.swift
//  Weather-App
//
//  Created by Abdallah ismail on 21/08/2024.
//

import Foundation
import Combine
class NetworkLayer:NetworkLayerProtocol {
    func fetchData<T: Decodable>(from url: URL, as type: T.Type) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
extension NetworkLayer
{
    func fetchDataa<T: Decodable>(from url: URL, as type: T.Type) async throws -> T {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        }
}
