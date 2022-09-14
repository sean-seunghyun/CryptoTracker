//
//  HomeView.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/14.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            VStack{
                header
                //minLength를 0으로 설정해서 0이 될 수 있게끔 설정.
                Spacer(minLength: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
            .navigationBarHidden(true)
//            .preferredColorScheme(.dark)
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
        }.padding()
    }
    
}