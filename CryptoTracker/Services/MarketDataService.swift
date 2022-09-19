//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/19.
//

import Foundation
import Combine

class MarketDataService{
    
    @Published var marketData:MarketData?
    
    var marketDataSubscription: AnyCancellable?
    
    static let instance = MarketDataService()
    
    private init(){
        getMarketData()
    }
    
    private func getMarketData(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global#") else { return }
        
        
        marketDataSubscription = NetworkingManager.download(for: url)
            .decode(type: GlobalMarketData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] receivedGlobalMarketData in
                self?.marketData = receivedGlobalMarketData.data
                self?.marketDataSubscription?.cancel()
            })
        
    }
}



