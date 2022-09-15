//
//  CoinImageDataService.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/15.
//

import Foundation
import SwiftUI
import Combine



class CoinImageDataService{
    @Published var image:UIImage?
    private let coin: Coin
    
    private var coinImageSubscription:AnyCancellable?
    

    init(coin: Coin){
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage(){
        guard let url = URL(string: coin.image) else { return }
        
        coinImageSubscription =
        NetworkingManager.download(for: url)
        // 이미지는 decode할 필요 없음
        // 대신 tryMap으로 UIImage로 변환해주기
            .tryMap({UIImage(data: $0)})
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                guard let self = self else { return }
                self.image = returnedImage
                self.coinImageSubscription?.cancel()
            })
    }
    
    
}

