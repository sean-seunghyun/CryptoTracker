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
    
    var dataService = CoinDataService.instance
    var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        dataService.$allCoins
            .sink { [weak self] receivedCoins in
                self?.allCoins = receivedCoins
            }
            .store(in: &cancellables)
    }
}
