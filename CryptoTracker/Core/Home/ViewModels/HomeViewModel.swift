//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/15.
//

import Foundation

class HomeViewModel: ObservableObject{
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    init(){
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
            self.allCoins = [DeveloperPreview.instance.coin]
            self.portfolioCoins = [DeveloperPreview.instance.coin]
        }
    }
}
