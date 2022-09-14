//
//  Color.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/14.
//

import Foundation
import SwiftUI

extension Color{
    static let theme = Theme()
}

struct Theme{
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}
