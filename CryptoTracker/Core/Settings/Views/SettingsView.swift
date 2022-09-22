//
//  SettingsView.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/22.
//

import SwiftUI

struct SettingsView: View {
    let youtubeURL = URL(string: "https://www.youtube.com/")!
    let defaultURL = URL(string: "https://www.google.com/")!
    let coingeckoURL = URL(string: "https://www.coingecko.com/")!
    
    
    var body: some View {
        // 새로운 sheet를 만들 때는 environment가 바뀌므로 navigationView를 새로 적용해줘야 한다.
        NavigationView{
            List{
                about
                coingecko
            }
            .listStyle(.grouped)
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView{
    private var about: some View{
        Section {
            VStack(alignment: .leading){
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                Text("This app was made to practice SwiftUI. It benefits from Combine, MVVM Architecture and multi threading.")
                    .font(.callout)
                    .foregroundColor(Color.theme.accent)
                   
            }
            .padding(.vertical)
            Link("Visit Website", destination: defaultURL)
                .accentColor(Color.blue)
        } header: {
            Text("About this App")
        }
    }
    
    private var coingecko: some View{
        Section {
            VStack(alignment: .leading){
                Image("coingecko")
                    .resizable()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                Text("The crypto currency data is relying on CoinGecko Free Api.")
                    .font(.callout)
                    .foregroundColor(Color.theme.accent)
                   
            }
            .padding(.vertical)
            Link("Visit Website", destination: coingeckoURL)
                .accentColor(Color.blue)
        } header: {
            Text("CoinGecko API")
        }
    }
}
