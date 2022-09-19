//
//  CoinLogoView.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/19.
//

import SwiftUI

struct CoinLogoView: View {
    let coin: Coin
    var body: some View {
        VStack(spacing: 0){
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
                .padding(.bottom, 7)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            Text(coin.name)
                .font(.subheadline)
                .foregroundColor(Color.theme.secondaryText)
        }
    }
}

struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinLogoView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
            CoinLogoView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
