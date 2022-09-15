//
//  ContentView.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.theme.background.ignoresSafeArea()
            VStack{
                Text("text 1")
                    .foregroundColor(Color.theme.accent)
                    .font(.caption)
                Text("text 2")
                    .foregroundColor(Color.theme.green)
                Text("text 3")
                    .foregroundColor(Color.theme.red)
                Text("text 4")
                    .foregroundColor(Color.theme.secondaryText)
            }
            .font(.title2)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
