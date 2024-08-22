//
//  DataTypes+Extentions.swift
//  Weather-App
//
//  Created by Abdallah ismail on 22/08/2024.
//
import Foundation

extension Double {
    /// Converts the Double to a String with no decimal places.
    func formattedToNonDecimalString() -> String {
        return String(format: "%.0f", self)
    }
}
extension String {
    /// Concatenates the current string with another string, separated by a comma.
    func concatenateWithComma(_ other: String) -> String {
        return "\(self),\(other)"
    }
}


