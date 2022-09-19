//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/15.
//
import Combine
import Foundation

class HomeViewModel: ObservableObject{
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchBarText:String = ""
    @Published var statistics: [Statistics] = []
    
    var coinDataService = CoinDataService.instance
    
    var marketDataService = MarketDataService.instance
    
    var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
    }
    
    private func addSubscribers(){
        
        $searchBarText
            // allCoins 또는 searchBarText에 변화가 있을 때마다 발동됨
            .combineLatest(coinDataService.$allCoins)
            // 변화가 끝나고 0.5s 대기 후 발동함
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            // 해당 데이터들을 가공함
            .map(filterCoins)
            .sink { [weak self] receivedCoins in
                self?.allCoins = receivedCoins
            }
            .store(in: &cancellables)

        marketDataService.$marketData
            .map { marketData -> [Statistics] in
                var stats: [Statistics] = []
                
                guard let data = marketData else { return stats}
                
                let marketCap = Statistics(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
                let totalVolume = Statistics(title: "Total Volume", value: data.volume)
                let btcDominance = Statistics(title: "BTC Dominance", value: data.btcDominance)
                let portfolio = Statistics(title: "Portfolio value", value: "$0.00", percentageChange: 0)
                
                stats.append(contentsOf: [marketCap, totalVolume, btcDominance, portfolio])
                
                return stats
            }
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
        
    }
    
    private func filterCoins(inputText: String, allCoins: [Coin]) -> [Coin] {
        guard !inputText.isEmpty else { return allCoins }

        let searchText = inputText.lowercased()

        let serachedCoins = self.allCoins.filter { coin in
            return coin.name.lowercased().contains(searchText) ||
            coin.symbol.lowercased().contains(searchText) ||
            coin.id.lowercased().contains(searchText)
        }
        return serachedCoins
    }
    
}
