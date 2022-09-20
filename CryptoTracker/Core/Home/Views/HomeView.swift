//
//  HomeView.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/14.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm:HomeViewModel
    @State private var showPortfolio: Bool = false
    @State private var showEditPortfolio: Bool = false
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            VStack{
                header
                
                HomeStatsView(showPortfolio: $showPortfolio)
                
                SearchBarView(textFieldText: $vm.searchBarText)
                //minLength를 0으로 설정해서 0이 될 수 있게끔 설정.
                Spacer(minLength: 0)
                
                listCaption
                
                if !showPortfolio{
                    allCoinsList
                    .transition(.move(edge: .leading))
                }
                
                if showPortfolio{
                    portfolioCoinsList
                    .transition(.move(edge: .trailing))
                    
                }
                
            }
        }
        // sheet를 생성해줄 때는 environmentObject를 새로 추가해줘야 한다.
        .sheet(isPresented: $showEditPortfolio){
            PortfolioView()
                .environmentObject(vm)
        }
     
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
            //.environmentObject(HomeViewModel())
                .environmentObject(dev.vm)
                .navigationBarHidden(true)
                .preferredColorScheme(.dark)
        }
        
    }
}


extension HomeView{
    // MARK: - COMPONENTS
    private var header: some View{
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .background(
                    CircleButtonAnimationView(isAnimate: $showPortfolio)
                )
                .onTapGesture {
                    showEditPortfolio.toggle()
                }
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.easeIn) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding()
        
    }
    
    private var allCoinsList: some View{
        List{
            
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
            
        }
        .listStyle(PlainListStyle())
        
    }
    
    private var portfolioCoinsList: some View{
        List{
            
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
            
        }
        .listStyle(PlainListStyle())
        
    }
    
    private var listCaption: some View{
        HStack(spacing: 0){
            HStack {
                Text("Coin")
                Image(systemName: "chevron.down")
                    
                    .opacity(vm.sortOption == .rank || vm.sortOption == .rankReversed ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.easeInOut) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            if showPortfolio{
                HStack {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        
                        .opacity(vm.sortOption == .holdings || vm.sortOption == .holdingsReversed ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            HStack {
                Text("Price")
                    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                Image(systemName: "chevron.down")
                    
                    .opacity(vm.sortOption == .price || vm.sortOption == .priceReversed ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
                
            }
            .onTapGesture {
                withAnimation(.easeInOut) {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            .padding(.trailing)
            Image(systemName: "goforward")
                
                .onTapGesture {
                    withAnimation(.linear(duration: 2.0)){
                        vm.reloadData()
                    }
                }
                .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
        }
        .padding(.horizontal)
        .foregroundColor(Color.theme.secondaryText)
        .font(.caption)
    }
}
