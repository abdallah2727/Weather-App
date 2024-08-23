//
//  SearchViewController.swift
//  Weather-App
//
//  Created by Abdallah ismail on 22/08/2024.
//

import UIKit

class SearchViewController: UIViewController {
// MARK: - propties
    var searched:Bool? = true
    let vm = SearchViewModel()
    
// MARK: - outlets
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    weak var coordinator: MainCoordinator?
// MARK: - viewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Actions
    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let cityName = searchTextField.text, !cityName.isEmpty else {
            AlertBuilder.showAlert(on: self, message:Constants.AlertMessages.enterData.rawValue)
            return
          }
          
          let viewModel = SearchViewModel()
          viewModel.validateCityURL(cityName: cityName) { isValid in
              DispatchQueue.main.async {
                  if isValid {
                      let homeVC = HomeViewController()
                      homeVC.searchForNewCity(cityName)
                      homeVC.search = true
                      let sheetViewController = FWIPNSheetViewController(controller: homeVC, sizes: [.percent(0.9)])
                      sheetViewController.gripSize = CGSize(width: 70, height: 6)
                      self.present(sheetViewController, animated: true)
                  } else {
                      AlertBuilder.showAlert(on: self, message: Constants.AlertMessages.enterValidData.rawValue)
                  }
              }
          }
                              }
           




}
