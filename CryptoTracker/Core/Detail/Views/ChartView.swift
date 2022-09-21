//
//  ChartView.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/21.
//

import SwiftUI

struct ChartView: View {
    let data: [Double]
    let maxY: Double
    let minY: Double
    let lineColor: Color
    let endDate: Date
    let startDate: Date
    @State var chartPercent: CGFloat = 0.0
    
    init(coin: Coin){
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0.0
        minY = data.min() ?? 0.0
        let gap = (data.last ?? 0) - (data.first ?? 0)
        lineColor = gap > 0 ? Color.theme.green : Color.theme.red
        
        endDate = Date(coinGeckoDate: coin.lastUpdated ?? "")
        startDate = Date(timeInterval: -(7*24*60*60), since: endDate)
    }
    
    var body: some View {
        
        VStack {
            chartView
                .frame(height: 200)
                .background(
                    background
                )
                .overlay(
                    priceIndicator
                        .font(.caption)
                        .foregroundColor(Color.theme.secondaryText)
                    , alignment: .leading
                )
                .overlay(
                    dateIndicator
                        .offset(y: 20)
                )
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2.0)) {
                    chartPercent = 1.0
                }
            }
        }
        
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}

extension ChartView{
    private var chartView: some View{
        GeometryReader { geometry in
            Path{ path in
                for index in data.indices{
                    let xUnit = geometry.size.width / CGFloat(data.count)
                    let xPoint = CGFloat((index + 1)) * xUnit
                    
                    let yAxis = maxY - minY
                    let yPoint = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0{
                        path.move(to: CGPoint(x: xPoint, y: yPoint))
                    }
                    
                    path.addLine(to: CGPoint(x: xPoint, y: yPoint))
                    
                }
            }
            .trim(from: 0.0, to: chartPercent)
            .stroke(lineColor, style: .init(lineWidth: 3.0, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.3), radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: 10)
            
            
        }
    }
    
    private var background: some View{
        VStack{
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var priceIndicator: some View{
        VStack{
            Text(maxY.asCurrencyWith2Decimals())
            Spacer()
            Text((maxY + minY / 2.0).asCurrencyWith2Decimals())
            Spacer()
            Text(minY.asCurrencyWith2Decimals())
        }
    }
    
    private var dateIndicator: some View{
        VStack{
            Spacer()
            HStack{
                Text(startDate.toShortString())
                Spacer()
                Text(endDate.toShortString())
            }
            .font(.caption)
            .foregroundColor(Color.theme.secondaryText)
        }
    }
}
