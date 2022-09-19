//
//  Statistics.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/16.
//

import Foundation

struct Statistics: Identifiable{
    let id: String = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil){
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
    
}
