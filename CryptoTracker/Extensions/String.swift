//
//  String.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/21.
//

import Foundation

extension String{
    
    var removeHTMLOccurences: String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
