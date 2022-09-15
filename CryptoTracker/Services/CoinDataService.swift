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
    
    private func getCoins(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap(handleOutput)
            .receive(on: DispatchQueue.main)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink { completeion in
                switch completeion{
                case .finished:
                     break
                case .failure(let error) :
                    print("error downloading data: \(error)")
                }
            } receiveValue: { [weak self] returnedCoins in
                guard let self = self else { return }
                
                self.allCoins = returnedCoins
                // API call을 여러번 하는 경우 여기서 cancel을 해준다.
                // 여기서는 굳이 해줄 필요가 없음.
                self.coinSubscription?.cancel()
            }

    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data{
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}
