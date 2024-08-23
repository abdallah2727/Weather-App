//
//  AlertManger.swift
//  Weather-App
//
//  Created by Abdallah ismail on 23/08/2024.
//

import Foundation
import UIKit

class AlertBuilder {
    
    static func showAlert(on viewController: UIViewController, title: String = "Alert", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
