//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/16.
//
import SwiftUI
import Foundation

extension UIApplication {
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
