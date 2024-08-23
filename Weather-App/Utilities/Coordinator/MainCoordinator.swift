//
//  MainCoordinator.swift
//  Weather-App
//
//  Created by Abdallah ismail on 22/08/2024.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    private let window: UIWindow
    private var children: [Coordinator] = []
    var navigationController: UINavigationController

    init(window: UIWindow, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.window = window
    }

    func start() {
        let vc = HomeViewController()
        vc.coordinator = self  // Make sure HomeViewController has this property
        navigationController.setViewControllers([vc], animated: false)
    }
    func goToSearch() {
           let searchVC = SearchViewController()
           searchVC.coordinator = self
           navigationController.pushViewController(searchVC, animated: true)
       }
    func showHomeViewController(withCity city: String) {
          let homeVC = HomeViewController()
          homeVC.coordinator = self
          homeVC.searchForNewCity(city)
        let sheetViewContoller =  FWIPNSheetViewController(controller: homeVC, sizes: [.percent(0.9)])
        sheetViewContoller.gripSize = CGSize(width: 70, height: 6)
        navigationController.pushViewController(sheetViewContoller, animated: true)
      }
}
