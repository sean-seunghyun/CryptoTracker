//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/14.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: Coin
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0){
            leftColumn
            Spacer()
            if showHoldingsColumn{
                holdingColumn
            }
            rightColumn
        }
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin : dev.coin, showHoldingsColumn: true)
            CoinRowView(coin : dev.coin, showHoldingsColumn: true)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}

extension CoinRowView{
    private var leftColumn: some View {
        HStack{
            Text("\(coin.rank)")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var holdingColumn: some View{
        VStack(alignment: .trailing){
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.theme.accent)
    }
    
    private var rightColumn: some View{
        VStack(alignment : .trailing){
            Text(coin.currentPrice.asCurrencyWith2Decimals())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "0%")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                    Color.theme.green :
                    Color.theme.red)
        }
        // portrait mode로만 설정해놨기 때문에 사용 가능. 그렇지 않으면 Geometry Reader 사용해야 함
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
