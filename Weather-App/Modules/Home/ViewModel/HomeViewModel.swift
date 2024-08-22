//
//  ViewModel.swift
//  Weather-App
//
//  Created by Abdallah ismail on 21/08/2024.
//

import Foundation
import CoreLocation
import Combine
class HomeViewModel{
// MARK: - Private proprties
    private let locationService = LocationService()
    private let getApiData:NetworkLayerProtocol
    private let output: PassthroughSubject< Output ,Never> = .init()
    @Published var weather: WeatherResponse?
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()
    // MARK: - Inputs & outputs
    enum Input {
        case viewDidAppear
    } 
    enum Output {
        case fetchQuateDidFail (error:Error)
        case fetchQuateDidSucceed (data:WeatherResponse)
    }
// MARK: - init & ViewDidload
    init(getApiData:NetworkLayerProtocol=NetworkLayer()){
        self.getApiData = getApiData
    }
}
// MARK: - detect current Location and Fetch Data
extension HomeViewModel:LocationServiceDelegate{
    func didUpdateLocation(latitude: Double, longitude: Double) {
        let url = URL(string:Constants.getUrlUsingCoord(lat: latitude, lon: longitude))
        getApiData.fetchData(from: url!, as: WeatherResponse.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] weatherResponse in
                self?.weather = weatherResponse
            })
            .store(in: &cancellables)
    }
         
        
    
    
    func didFailWithError(_ error: any Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
}
extension HomeViewModel{
    func transformInputFromView(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        let outputPublisher = PassthroughSubject<Output, Never>()
        input
            .sink { [weak self] event in
                switch event {
                case .viewDidAppear:
                    self?.handleGetWeather(outputPublisher: outputPublisher)
                }
            }
            .store(in: &cancellables)

        return outputPublisher.eraseToAnyPublisher()
    }
    private func handleGetWeather(outputPublisher: PassthroughSubject<Output, Never>) {
        locationService.delegate = self
        locationService.initializeLocationManager()
        $weather
             .compactMap { $0 }
             .map { Output.fetchQuateDidSucceed(data: $0) }
             .subscribe(outputPublisher)
             .store(in: &cancellables)

         
       
    }
    }


