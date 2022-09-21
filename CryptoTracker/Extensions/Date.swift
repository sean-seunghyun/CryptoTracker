//
//  Date.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/21.
//

import Foundation


extension Date{
    
    //"2021-03-13T23:18:10.268Z"
    init(coinGeckoDate: String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let date = dateFormatter.date(from: coinGeckoDate) ?? Date()
        self.init(timeInterval: 0, since: date)
    }

    func toShortString() -> String {
            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.dateStyle = .medium
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            return dateFormatter.string(from: self)
        }
    
}

