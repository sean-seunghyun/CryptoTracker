//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/19.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var vm:HomeViewModel
    
    @State var selectedCoin: Coin? = nil
    @State var currentAmount: String = ""
    @State var currentAmountDouble: Double? = nil
    @State var isAmountChanged: Bool = false
    @State var showCheckMark: Bool = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                SearchBarView(textFieldText: $vm.searchBarText)
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    coinList
                        .padding(.leading)
                })
                currentCoinInfo
                    .padding()
                
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    xButton
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    saveButton
                }
            }
        }
        .onChange(of: vm.searchBarText) { searchText in
            if searchText == ""{
                removeSelectedCoin()
            }
        }
        .onChange(of: currentAmount) { newAmountString in
            let newAmountDouble = Double(newAmountString)
            if newAmountDouble != currentAmountDouble {
                isAmountChanged = true
            }
        }

    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .preferredColorScheme(.dark)
            .environmentObject(dev.vm)
    }
}


extension PortfolioView{
    private var coinList: some View{
        LazyHStack {
            ForEach(vm.portfolioCoins.count > 0 ? vm.portfolioCoins : vm.allCoins) { coin in
                CoinLogoView(coin: coin)
                    .frame(width: 75)
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.theme.green, lineWidth: 1)
                            .opacity(coin == selectedCoin ? 1 : 0)
                        
                    )
                    .onTapGesture {
                        withAnimation(.easeOut){
                            selectedCoin = coin
                        }
                        
                        guard
                            let selectedCoin = vm.portfolioCoins.first(where: {$0 == coin}),
                            let previousAmount = selectedCoin.currentHoldings else {
                            currentAmountDouble = nil
                            currentAmount = ""
                            
                            return
                            
                        }
                        currentAmountDouble = previousAmount
                        currentAmount = "\(previousAmount)"
                    }
                
            }
        }
    }
    
    private var currentCoinInfo: some View{
        VStack{
            if let selectedCoin = selectedCoin{
               
                HStack {
                    Text("Current Price of \(selectedCoin.symbol.uppercased())")
                    Spacer()
                    Text(selectedCoin.currentPrice.asCurrencyWith2Decimals())
                }
                .animation(.none)
                .padding(.vertical)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                
                Divider()
                
                HStack {
                    Text("Current Amount")
                    Spacer()
                    TextField("EX) 3.4", text: $currentAmount)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                .padding(.vertical)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                
                
                Divider()
                
                HStack {
                    Text("Current Value")
                    Spacer()
                    Text(getValue(price: selectedCoin.currentPrice, amount: Double(currentAmount) ?? 0))
                }
                .padding(.vertical)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                
            }
        }
    }

    
    private var xButton: some View{
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
    
    private var saveButton: some View{
        Button {
            handleSaveButton()
        } label: {
            HStack {
                Image(systemName: "checkmark")
                    .font(.headline)
                    .opacity(showCheckMark ? 1 : 0)
                Text("Save")
                    .font(.headline)
                    .opacity(
                        selectedCoin != nil &&
                        isAmountChanged &&
                        currentAmount != "" ?
                        1.0 :
                        0.0)
                
            }
        }
    }
    
    private func handleSaveButton(){
        guard let selectedCoin = selectedCoin,
              let currentAmount = Double(currentAmount) else {
            return
        }
        withAnimation(.easeInOut) {
            showCheckMark = true
        }
        
        vm.updatePortfolio(coin: selectedCoin, amount: currentAmount)
        removeSelectedCoin()
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
            withAnimation(.easeInOut){
                showCheckMark = false
            }
            
        }
        isAmountChanged = false
    }
    
    private func getValue(price: Double, amount: Double) -> String{
        return (price * amount).asCurrencyWith2Decimals()
    }
    
    private func removeSelectedCoin(){
        selectedCoin = nil
        vm.searchBarText = ""
    }
}
