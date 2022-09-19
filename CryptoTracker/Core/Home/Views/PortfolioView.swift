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
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                    }
                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        HStack {
                            Text("Save")
                                .font(.headline)
                            Image(systemName: "checkmark")
                                .font(.headline)
                        }.opacity(selectedCoin != nil && currentAmount != "" ? 1 : 0)
                    }
                    
                }
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
            ForEach(vm.allCoins) { coin in
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
    
    
    private func getValue(price: Double, amount: Double) -> String{
        return (price * amount).asCurrencyWith2Decimals()
    }
}
