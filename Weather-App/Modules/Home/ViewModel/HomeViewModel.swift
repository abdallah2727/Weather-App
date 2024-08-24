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
    private var isDataFetched = false
    public var city:String?
    var isSearchSuccessful: Bool = false
    weak var coordinator: MainCoordinator?
    // MARK: - Inputs & outputs
    enum Input {
        case viewDidAppear
        case citySearchedSent
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
        let url = Constants.getUrlUsingCoord(lat: latitude, lon: longitude)
        getDataFromAPi(url: url)
    }
    
    func didFailWithError(_ error: any Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
}
// MARK: - transform inputs into output to view controller
extension HomeViewModel{
    func transformInputFromView(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        let outputPublisher = PassthroughSubject<Output, Never>()
        
        input
            .sink { [weak self] event in
                guard let self = self else { return }
                
                switch event {
                case .citySearchedSent:
                    if let city = self.city {
                        self.handleGetWeatherSearched(outputPublisher: outputPublisher, city: city)
                    }
                    
                case .viewDidAppear:
                    if !self.isDataFetched {
                        self.handleGetWeather(outputPublisher: outputPublisher)
                        self.isDataFetched = true
                    }
                }
            }
            .store(in: &cancellables)
        
        return outputPublisher.eraseToAnyPublisher()}
    private func handleGetWeather(outputPublisher: PassthroughSubject<Output, Never>) {
        locationService.delegate = self
        locationService.initializeLocationManager()
        
        $weather
            .compactMap { $0 }
            .map { Output.fetchQuateDidSucceed(data: $0) }
            .subscribe(outputPublisher)
            .store(in: &cancellables)
        
        
        
    }
    func handleGetWeatherSearched(outputPublisher: PassthroughSubject<Output, Never>,city:String) {
        updateWeatherForSearchedCity(city)
        $weather
            .compactMap { $0 }
            .map { Output.fetchQuateDidSucceed(data: $0) }
            .subscribe(outputPublisher)
            .store(in: &cancellables)
        
        
        
    }
}
// MARK: - detect and update searched city
extension HomeViewModel{
    
    func updateWeatherForSearchedCity(_ city: String) {
        let url = Constants.getUrlUsingcityname(city: city)
        getDataFromAPi(url: url)
        
    }
    func getDataFromAPi(url:String){
        let url = URL(string:url)
        isSearchSuccessful = true
        getApiData.fetchData(from: url!, as: WeatherResponse.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    let vc = SearchViewController()
                    vc.searched = false
                    self?.errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] weatherResponse in
                self?.weather = weatherResponse
                let vc = SearchViewController()
                vc.searched = true
            })
            .store(in: &cancellables)
        
    }
    
    
}
