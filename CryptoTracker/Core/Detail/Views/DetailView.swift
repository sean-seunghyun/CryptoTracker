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
    @State var showFullDescription: Bool = false
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing:CGFloat = 40
    
    init(coin: Coin){
        self.coin = coin
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        
        ScrollView{
            VStack{
                ChartView(coin: coin)
                    .padding(.bottom, 20)
                overviewTitle
                Divider()
                coinDescription
                overviewGrid
                additionalDetailTitle
                Divider()
                additionalDetailGrid
                websiteLinks
                
            }
            .padding()
            
        }
        .navigationTitle(coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                trailingToolBarItem
                
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}

extension DetailView{
    
    private var websiteLinks: some View{
        VStack(alignment: .leading, spacing: 20){
            if let websiteURLString = vm.websiteURL,
               let websiteURL = URL(string: websiteURLString)
              {
                Link("Website", destination: websiteURL)
                    .frame(maxWidth : .infinity, alignment: .leading)
                    .font(.headline)
                    .foregroundColor(Color.blue)
            }
            
            if let redditURLString = vm.redditURL,
               let redditURL = URL(string: redditURLString){
                Link("Reddit", destination: redditURL)
                    .frame(maxWidth : .infinity, alignment: .leading)
                    .font(.headline)
                    .foregroundColor(Color.blue)

            }
        }
    }
    
    private var trailingToolBarItem: some View{
        HStack{
            Text(coin.symbol.uppercased())
                .font(.subheadline)
                .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var coinDescription: some View{
        VStack(alignment: .leading, spacing: 20){
            if let description = vm.coinDescription{
                Text(description.removeHTMLOccurences)
                    .font(.callout)
                    .foregroundColor(Color.theme.secondaryText)
                    .lineLimit(showFullDescription ? nil : 3)
                // text에 직접 animation을 줄 때 더 자연스럽다.
                    .animation(showFullDescription ? Animation.easeInOut : .none, value: showFullDescription)
                
                Button {
                    showFullDescription.toggle()
                } label: {
                    Text(showFullDescription ? "Less" : "Read more")
                        .foregroundColor(Color.blue)
                        .bold()
                }
                .animation(.none)
                
                
            }
            
        }
    }
    
    private var overviewTitle: some View{
        Text("Overview")
            .bold()
            .font(.title)
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    private var overviewGrid: some View{
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(vm.overviewStatistics){ stat in
                    StatisticView(stat: stat)
                }
            }
        
    }
    
    private var additionalDetailTitle: some View{
        Text("Additional Details")
            .bold()
            .font(.title)
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    private var additionalDetailGrid: some View{
        LazyVGrid(columns: columns, alignment: .leading, spacing: spacing, pinnedViews: []) {
            ForEach(vm.additionalStatistics) { stat in
                StatisticView(stat: stat)
                
            }
        }
        
    }
}
