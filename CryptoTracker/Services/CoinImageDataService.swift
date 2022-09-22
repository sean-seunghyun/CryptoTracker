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
    let fileManger = LocalFileManager.instance
    let folderName: String = "coin_images"
    let imageName: String

    init(coin: Coin){
        self.coin = coin
        self.imageName = coin.id
        
        getCoinImage()
    }
    
    private func getCoinImage(){
        if let savedCoinImage = fileManger.get(folderName: folderName, imageName: imageName){
            image = savedCoinImage
//            print("get images from fileManager")
        }else{
            downloadCoinImage()
//            print("download Images")
        }
    }
    
    private func downloadCoinImage(){
        guard let url = URL(string: coin.image) else { return }
        
        coinImageSubscription =
        NetworkingManager.download(for: url)
        // 이미지는 decode할 필요 없음
        // 대신 tryMap으로 UIImage로 변환해주기
            .tryMap({UIImage(data: $0)})
            .receive(on: DispatchQueue.main) // decoing까지 background 스레드에서 진행, 이후에 main스레드에서 계속 작업

            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                guard
                    let self = self,
                    let downloadedImage = returnedImage
                else { return }
                self.image = downloadedImage
                self.fileManger.add(image: downloadedImage, folderName: self.folderName, imageName: self.imageName)
                self.coinImageSubscription?.cancel()
            })
    }
    
    
}

