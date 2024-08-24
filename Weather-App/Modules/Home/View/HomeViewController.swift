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
    @IBOutlet weak var searchCustomButton: CustomButton!
    @IBOutlet weak var ConditionsView: UIView!
    @IBOutlet unowned var noConnectionImage: UIImageView!
    @IBOutlet weak var WindImage: UIImageView!
    @IBOutlet weak var seaLevelImage: UIImageView!
    @IBOutlet weak var pressureImage: UIImageView!
    @IBOutlet weak var humidImage: UIImageView!
    @IBOutlet weak var humid: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var seaLevel: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var wetherDesc: UILabel!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var TempLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var CityNameLabel: UILabel!
    
    @IBAction func GoToSearchVc(_ sender: Any) {
        coordinator?.goToSearch()
    }
    // MARK: - proprties
    let vm = HomeViewModel()
    var search = false
    private let input: PassthroughSubject <HomeViewModel.Input, Never> = .init()
    private var cancelablles = Set<AnyCancellable>()
    weak var coordinator: MainCoordinator?
// MARK: - ViewDidLoad & did appear
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        searchCustomButton.setupButton(color: .lightGray, font: .headline, title: Constants.ButtonSearchContent)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if search == false {input.send(.viewDidAppear)}
        else {  
            input.send(.citySearchedSent)
        }
    }
}
// MARK: - VM Bind
extension HomeViewController {
    func bind() {
       if CheckConnection.shared.isNetworkAvailable() {
           let (blurEffectView, activityIndicator) = showLoadingIndicatorWithBlur()
           noConnectionImage.image = nil
        let output = vm.transformInputFromView(input: input.eraseToAnyPublisher())
        output
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print((error.localizedDescription))
                }
            }, receiveValue: { [weak self] event in
                switch event {
                case .fetchQuateDidSucceed(let weatherResponse):
                    switch weatherResponse.weather[0].main  {
                    case Constants.WeatherCondition.clear.rawValue:
                        if weatherResponse.weather[0].icon.contains("n"){
                            self?.backgroundImage.image = UIImage.night
                            self?.setupNight()
                        }
                        else {
                            self?.backgroundImage.image = UIImage.clear
                        }
                    case Constants.WeatherCondition.rain.rawValue:
                        self?.backgroundImage.image = UIImage.rain
                        self?.setupNight()
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
                    self?.hideLoadingIndicatorWithBlur(blurEffectView: blurEffectView, activityIndicator: activityIndicator)
                case .fetchQuateDidFail(let error):
                    self?.CityNameLabel.text = error.localizedDescription
                    self?.dismiss(animated: true)
                    
                }
            })
        .store(in: &cancelablles)}
        else {
            AlertManager.shared.showNoConnectionAlert(on:self)
            noConnectionImage.image = UIImage.noConnection
            searchCustomButton.isEnabled = false
        }

    }
    }
// MARK: - VM Notify with city name
extension HomeViewController{
    func searchForNewCity(_ cityName: String) {
        search = true
        vm.city = cityName
    }
    func setupNight(){

        self.CityNameLabel.textColor = .white
        self.TempLabel.textColor = .white
        self.humid.textColor = .white
        self.weatherCondition.textColor = .white
        self.wetherDesc.textColor = .white
        self.pressure.textColor = .white
        self.seaLevel.textColor = .white
        self.wind.textColor = .white
        self.humidImage.image = UIImage.humidW
        self.WindImage.image = UIImage.windW
        self.pressureImage.image = UIImage.pressureW
        self.seaLevelImage.image = UIImage.seaLevelw
       
    }
   
}

