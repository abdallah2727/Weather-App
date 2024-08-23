//
//  NoConnectionAlert.swift
//  Weather-App
//
//  Created by Abdallah ismail on 22/08/2024.
//
import UIKit

class AlertManager {

    static let shared = AlertManager()
    
    private init() {}

    func showAlert(on viewController: UIViewController, title: String, message: String, buttonTitle: String, buttonAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            buttonAction?()
        }
        alert.addAction(action)
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    // Show an alert with settings redirect option
    func showNoConnectionAlert(on viewController: UIViewController) {
        let alert = UIAlertController(
            title: "No Internet Connection",
            message: "Please check your internet settings.",
            preferredStyle: .alert
        )
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }
        alert.addAction(settingsAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
