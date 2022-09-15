//
//  CoinImageView.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/15.
//

import SwiftUI

struct CoinImageView: View {
    let coin:Coin
    
    @StateObject var vm: CoinImageViewModel
    
    init(coin: Coin){
        self.coin = coin
        // StateObject에 대한 초기화는 상단의 전역변수를 두는 곳에서 할 수 없다.
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    
    var body: some View {
        if let image = vm.image{
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        } else if vm.isLoading{
            ProgressView()
        }else{
            Image(systemName: "questionmark")
                .foregroundColor(Color.theme.secondaryText)
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
