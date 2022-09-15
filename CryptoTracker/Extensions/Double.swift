//
//  Double.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/14.
//

import Foundation

extension Double{
    
    private var currencyFormatter2 : NumberFormatter{
        let formatter = NumberFormatter()
        //formatter.locale = Locale.current
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }
    
    /// Converts a Double value to 2digits currency String
    /// ```
    /// Converts 6211.2928 -> 6211.29
    /// ```
    func asCurrencyWith2Decimals() -> String{
        return currencyFormatter2.string(from: NSNumber(value: self))!
    }
    
    /// Converts a Double value to 2digits String value
    /// ```
    /// Converts 6.2928 -> 6.29
    /// ```
    func asNumberString() -> String{
        return String(format: "%.2f", self)
    }
    
    
    /// Converts a Double value to 2digits String value with % symbol
    /// ```
    /// Converts 6.2928 -> 6.29%
    /// ```
    func asPercentString() -> String{
        return self.asNumberString() + "%"
    }
}
