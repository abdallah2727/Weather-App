//
//  HomeViewController.swift
//  Weather-App
//
//  Created by Abdallah ismail on 20/08/2024.
//

import UIKit
import Combine
class HomeViewController: UIViewController {
// MARK: - Outlets
    @IBOutlet weak var ConditionsView: UIView!
    @IBOutlet weak var humid: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var seaLevel: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var wetherDesc: UILabel!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var TempLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var CityNameLabel: UILabel!
    
// MARK: - Private proprties
    private let vm = HomeViewModel()
    private let input: PassthroughSubject <HomeViewModel.Input, Never> = .init()
    private var cancelablles = Set<AnyCancellable>()
// MARK: - ViewDidLoad & did appear
    override func viewDidLoad() {
        super.viewDidLoad()
        if !NetworkMonitor.shared.isConnected {
                   AlertManager.shared.showNoConnectionAlert(on: self)
               }
        bind()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        input.send(.viewDidAppear)
    }
}
// MARK: - VM Bind
extension HomeViewController {
    func bind() {
        let output = vm.transformInputFromView(input: input.eraseToAnyPublisher())
        
        output
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Failed with error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] event in
                switch event {
                case .fetchQuateDidSucceed(let weatherResponse):
                    switch weatherResponse.weather[0].main  {
                    case Constants.WeatherCondition.clear.rawValue:
                        if weatherResponse.weather[0].icon.contains("n"){
                            self?.backgroundImage.image = UIImage.night
                        }
                        else {
                            self?.backgroundImage.image = UIImage.clear
                        }
                    case Constants.WeatherCondition.rain.rawValue:
                        self?.backgroundImage.image = UIImage.rain
                    case Constants.WeatherCondition.clouds.rawValue:
                        self?.backgroundImage.image = UIImage.clouds
                        self?.ConditionsView.backgroundColor = UIColor.clear
                        
                    default:
                        self?.backgroundImage.image = UIImage.clear
                    }
                    self?.TempLabel.text = weatherResponse.main.temp.formattedToNonDecimalString()+Constants.celuisSymbol
                    self?.CityNameLabel.text = weatherResponse.name.concatenateWithComma(weatherResponse.sys.country)
                    self?.weatherCondition.text = weatherResponse.weather[0].main
                    self?.wetherDesc.text = weatherResponse.weather[0].description
                    self?.humid.text = String(weatherResponse.main.humidity)+Constants.hu
                    self?.pressure.text = String(weatherResponse.main.pressure)
                    self?.seaLevel.text = String(weatherResponse.main.seaLevel)
                    self?.wind.text = String(weatherResponse.wind.deg)+Constants.km
                    
                case .fetchQuateDidFail(let error):
                    self?.CityNameLabel.text = error.localizedDescription
                }
            })
            .store(in: &cancelablles)
    }
}
