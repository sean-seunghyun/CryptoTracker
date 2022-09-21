//
//  DetailView.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/20.
//

import SwiftUI

struct DetailLoadingView: View{
    @Binding var coin: Coin?
  
    
    var body: some View {
        ZStack{
            if let coin = coin{
                DetailView(coin: coin)
            }
        }
    }
    
}

struct DetailView: View {
    private let coin: Coin
    @StateObject private var vm: DetailViewModel
    
    init(coin: Coin){
        self.coin = coin
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        
        let columns: [GridItem] = [
                GridItem(.flexible()),
                GridItem(.flexible())
        ]
        let spacing:CGFloat = 40
        
        ScrollView{
            VStack{
                  Text("")
                    .frame(height: 150)
                
                Text("Overview")
                    .bold()
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                
                LazyVGrid(
                    columns: columns,
                    alignment: .leading,
                    spacing: spacing,
                    pinnedViews: []) {
                    ForEach(vm.overviewStatistics){ stat in
                        StatisticView(stat: stat)
                    }
                }
                
                Text("Additional Details")
                    .bold()
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                
                LazyVGrid(columns: columns, alignment: .leading, spacing: spacing, pinnedViews: []) {
                    ForEach(vm.additionalStatistics) { stat in
                        StatisticView(stat: stat)

                    }
                }

            }
            .padding()
        }
        .navigationTitle(coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}
