//
//  CoinDetailDataService.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/21.
//


import Foundation
import Combine

class CoinDetailDataService{
    let coin: Coin
    @Published var coinDetail: CoinDetail? = nil
    var coinDetailSubscription: AnyCancellable?
    
    init(coin: Coin){
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        coinDetailSubscription = NetworkingManager.download(for: url)
            .decode(type: CoinDetail.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoinDetails in
                guard let self = self else { return }
                
                self.coinDetail = returnedCoinDetails
                // API call을 여러번 하는 경우 여기서 cancel을 해준다.
                // 여기서는 굳이 해줄 필요가 없음.
                self.coinDetailSubscription?.cancel()
            })
        
    }
    
    
}
