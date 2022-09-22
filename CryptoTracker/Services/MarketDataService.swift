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
    
    func getMarketData(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global#") else { return }
        
        
        marketDataSubscription = NetworkingManager.download(for: url)
            .decode(type: GlobalMarketData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main) // decoing까지 background 스레드에서 진행, 이후에 main스레드에서 계속 작업

            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] receivedGlobalMarketData in
                self?.marketData = receivedGlobalMarketData.data
                self?.marketDataSubscription?.cancel()
            })
        
    }
}



