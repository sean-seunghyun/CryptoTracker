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
    @State private var showDetailView: Bool = false
    @State private var showSettingsView: Bool = false
    @State private var selectedCoin:Coin? = nil
    
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
                    if(!vm.portfolioCoins.isEmpty || !vm.searchBarText.isEmpty){
                        portfolioCoinsList
                            .transition(.move(edge: .trailing))
                    }else{
                        noPortfolioCoinsText
                    }
                    
                }
                
            }
            // 동일한 hierarchy 내에 두개 이상의 multiple sheets는 불가능함.
            // 그러나 여기서는 VStack에 하나, 그 밖에 ZStack에 하나이므로 가능함.
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }
        }
        // sheet를 생성해줄 때는 environmentObject를 새로 추가해줘야 한다.
        .sheet(isPresented: $showEditPortfolio){
            PortfolioView()
                .environmentObject(vm)
        }
        .background(
            NavigationLink(isActive: $showDetailView) {
                // selectCoin을 바로 넣으면 변화된 것을 tracking하지 못하고,
                // 돌아오면 다시 nil을 해주는 등 해줘야 할 것이 많은데
                // 만약 binding을 해주면 자동으로 값이 바뀔 수 있다.
                DetailLoadingView(coin: $selectedCoin)
            } label: {
                EmptyView()
            }
        )
        
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

// MARK: - COMPONENTS
extension HomeView{
    
    private var header: some View{
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .background(
                    CircleButtonAnimationView(isAnimate: $showPortfolio)
                )
                .onTapGesture {
                    if showPortfolio{
                        showEditPortfolio.toggle()
                    }else{
                        showSettingsView.toggle()
                    }
                    
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
                    .onTapGesture {
                        segue(coin: coin)
                        
                    }
            }
            
        }
        .listStyle(PlainListStyle())
        
    }
    
    private var portfolioCoinsList: some View{
        List{
            
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
                
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
    
    private var noPortfolioCoinsText: some View{
        VStack{
            Text("There is no coins in your Portfolio... Please add coins you have.🤔 ")
                .multilineTextAlignment(.center)
                .frame(width: 250)
                .padding(.top)
                .foregroundColor(Color.theme.accent)
                
            Spacer()
        }
    }
}


// MARK: - FUNCTIONS
extension HomeView{
    
    func segue(coin: Coin){
        selectedCoin = coin
        showDetailView = true
    }
}
