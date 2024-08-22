//
//  UIView+Extentions.swift
//  Weather-App
//
//  Created by Abdallah ismail on 22/08/2024.
//

import Foundation
import UIKit
public extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var circuler: Bool {
        get {
            return self.circuler
        }
        set {
            layer.cornerRadius = layer.cornerRadius / 2
            layer.masksToBounds = true
        }
    }}
