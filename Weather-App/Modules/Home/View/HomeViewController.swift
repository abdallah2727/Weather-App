//
//  HomeViewController.swift
//  Weather-App
//
//  Created by Abdallah ismail on 20/08/2024.
//

import UIKit

class HomeViewController: UIViewController {
  let vm = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.viewDidLoad()
    }


}
