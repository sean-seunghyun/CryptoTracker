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
    @Published var isLoading = false
    
    var coinDataService = CoinDataService.instance
    var marketDataService = MarketDataService.instance
    var portfolioDataService = PortfolioDataService.instance
    
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
        
        
        portfolioDataService.$savedPortfolios
            .combineLatest($allCoins)
        // 최종적으로 portofolioCoins:[Coin] 에 저장하므로 map의 return 값은 [Coin]이다.
            .map { (portfolios, allCoins) -> [Coin] in
                allCoins.compactMap { coin -> Coin? in
                    // 모든 코인에 대해 하나하나 찾아가면서 portfolio의 id와 일치하는게 있는지 확인한다.
                    guard let entity = portfolios.first(where: {$0.coinID == coin.id}) else {
                        return nil
                    }
                    // 일치하는게 있으면 해당 코인을 업데이트 해준다.
                    return coin.updateHoldings(currentHoldings: entity.amount)
                }
            }
            .sink { [weak self] receviedPortfolios in
                self?.portfolioCoins = receviedPortfolios
            }
            .store(in: &cancellables)
        
        
        
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map { marketData, portfolios -> [Statistics] in
                var stats: [Statistics] = []
                
                guard let data = marketData else { return stats}
                
                let portfolioValue = portfolios
                                        .map({$0.currentHoldingsValue})
                                        .reduce(0, +)
                
                let previousValue =
                           portfolios
                               .map { (coin) -> Double in
                                   let currentValue = coin.currentHoldingsValue
                                   let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                                   let previousValue = currentValue / (1 + percentChange)
                                   return previousValue
                               }
                               .reduce(0, +)

               let percentageChange = ((portfolioValue - previousValue) / previousValue)
                       
                
                let marketCap = Statistics(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
                let totalVolume = Statistics(title: "Total Volume", value: data.volume)
                let btcDominance = Statistics(title: "BTC Dominance", value: data.btcDominance)
                let portfolio = Statistics(title: "Portfolio value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
                
                stats.append(contentsOf: [marketCap, totalVolume, btcDominance, portfolio])
                
                return stats
            }
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
                self?.isLoading = false
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
    
    func updatePortfolio(coin: Coin, amount: Double){
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    
    func reloadData(){
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapticManager.notification(type: .success)
    }
}
