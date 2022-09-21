//
//  DetailViewModel.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/21.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject{
    
    @Published var coin: Coin
    @Published var overviewStatistics: [Statistics] = []
    @Published var additionalStatistics: [Statistics] = []
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil
    
    private var coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    
    
    
    init(coin: Coin){
        self.coin = coin
        coinDetailDataService = CoinDetailDataService(coin: coin)

        addSubscribers()
    }
    
    private func addSubscribers(){
        coinDetailDataService.$coinDetail
            .combineLatest($coin)
            .map(coinInfoToStatistics)
            .sink { [weak self] (overview, additional)  in
                self?.overviewStatistics = overview
                self?.additionalStatistics = additional
            }
            .store(in: &cancellables)
        
        
        // coinDetail에 대해서 두번 subscription 하지만 이렇게 하는게 더 깔끔해서 두번 한다.
        coinDetailDataService.$coinDetail
            .sink { [weak self] coinDetail in
                self?.coinDescription = coinDetail?.description?.en
                self?.websiteURL = coinDetail?.links?.homepage?.first
                self?.redditURL = coinDetail?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    private func coinInfoToStatistics(coinDetail: CoinDetail?, coin: Coin) -> ([Statistics], [Statistics]){
        
        let overviewStatistics = getOverviewInfo(coin: coin)
        let additionalStatistics = getAdditionalInfo(coin: coin, coinDetail: coinDetail)
        
        return (overviewStatistics, additionalStatistics)
    }
    
    
    private func getOverviewInfo(coin: Coin) -> [Statistics]{
        var overviewStatistics:[Statistics] = []
        
        let currentPrice = coin.currentPrice.asCurrencyWith2Decimals()
        let currentPriceChange = coin.priceChangePercentage24HInCurrency
        let currentPriceStat = Statistics(title: "Current Price", value: currentPrice, percentageChange: currentPriceChange)
        
        let marketCap = coin.marketCap?.formattedWithAbbreviations()
        let marketCapPercent = coin.marketCapChangePercentage24H
        let marketCapStat = Statistics(title: "Market Capitalization", value: marketCap ?? "n/a", percentageChange: marketCapPercent)
        
        let rank = String(coin.rank)
        let rankStat = Statistics(title: "Rank", value: rank)
        
        let volume = coin.totalVolume?.formattedWithAbbreviations()
        let volumeStat = Statistics(title: "Volume", value: volume ?? "n/a")
        
        overviewStatistics.append(contentsOf: [currentPriceStat, marketCapStat, rankStat, volumeStat])
        
        return overviewStatistics
    }
    
    private func getAdditionalInfo(coin: Coin, coinDetail: CoinDetail?) -> [Statistics] {

        var additionalStatistics:[Statistics] = []
        
        let high = coin.high24H?.asCurrencyWith2Decimals()
        let highStat = Statistics(title: "24h High", value: high ?? "n/a")
        
        let low = coin.low24H?.asCurrencyWith2Decimals()
        let lowStat = Statistics(title: "24g Low", value: low ?? "n/a")
        
        let priceChange = coin.priceChange24H?.asCurrencyWith2Decimals()
        let priceChangePercent = coin.priceChangePercentage24H
        let priceChangeStat = Statistics(title: "24h Price Change", value: priceChange ?? "n/a", percentageChange: priceChangePercent)
        
        let marketCapChange = coin.marketCapChange24H?.asCurrencyWith2Decimals()
        let marketCapChangePercent = coin.marketCapChangePercentage24H
        let marketCapChangeStat = Statistics(title: "24h Market Cap Change", value: marketCapChange  ?? "n/a", percentageChange: marketCapChangePercent)
        
        let blockTime = coinDetail?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime != 0 ? String(blockTime) : "n/a"
        let blockTimeStat = Statistics(title: "Block Time", value: blockTimeString)
        
        let hashingAlgorithm = coinDetail?.hashingAlgorithm ?? "n/a"
        let hashingAlgorithmStat = Statistics(title: "Hashing Algorithm", value: hashingAlgorithm)
        
        additionalStatistics.append(contentsOf: [highStat, lowStat, priceChangeStat, marketCapChangeStat, blockTimeStat, hashingAlgorithmStat])
        
        return additionalStatistics
    }
    
}
