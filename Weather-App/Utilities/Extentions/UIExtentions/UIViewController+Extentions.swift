//
//  UIViewController+Extentions.swift
//  Weather-App
//
//  Created by Abdallah ismail on 24/08/2024.
//
import UIKit
extension UIViewController {
    
    func showLoadingIndicatorWithBlur() -> (UIVisualEffectView, UIActivityIndicatorView) {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurEffectView)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = blurEffectView.contentView.center
        activityIndicator.hidesWhenStopped = true
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        return (blurEffectView, activityIndicator)
    }
    
    func hideLoadingIndicatorWithBlur(blurEffectView: UIVisualEffectView, activityIndicator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            blurEffectView.removeFromSuperview()
        }
    }
}

