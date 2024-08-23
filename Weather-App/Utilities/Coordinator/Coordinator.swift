//
//  Coordinator.swift
//  Weather-App
//
//  Created by Abdallah ismail on 22/08/2024.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func start()
}
