//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/15.
//

import Foundation
import Combine

class CoinDataService{
    @Published var allCoins: [Coin] = []
    
    var coinSubscription: AnyCancellable?
    
    static let instance = CoinDataService()
    
    private init(){
        getCoins()
    }
    
    func getCoins(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        coinSubscription = NetworkingManager.download(for: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main) // decoing까지 background 스레드에서 진행, 이후에 main스레드에서 계속 작업
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoins in
                guard let self = self else { return }
                
                self.allCoins = returnedCoins
                // API call을 여러번 하는 경우 여기서 cancel을 해준다.
                // 여기서는 굳이 해줄 필요가 없음.
                self.coinSubscription?.cancel()
            })
        

    }
    
    
}
