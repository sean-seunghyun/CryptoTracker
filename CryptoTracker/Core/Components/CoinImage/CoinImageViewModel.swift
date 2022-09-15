//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/15.
//

import Foundation
import SwiftUI
import Combine
class CoinImageViewModel: ObservableObject{
    @Published var image:UIImage?
    @Published var isLoading: Bool = false
    let coin: Coin
    var cancellables = Set<AnyCancellable>()
    
    let dataService:CoinImageDataService
    
    init(coin: Coin){
        self.coin = coin
        isLoading = true
        dataService = CoinImageDataService(coin: coin)
        addSubscribers()
    }
    
    func addSubscribers(){
        dataService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] receivedImage in
                self?.image = receivedImage
            }
            .store(in: &cancellables)

    }
}
