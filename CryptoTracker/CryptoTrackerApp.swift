//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/14.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    @StateObject var vm: HomeViewModel = HomeViewModel()
    @State var showLaunchView:Bool = true
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                //NavigationView는 가장 상단에 설정해주는 것이 좋다.
                NavigationView{
                    HomeView()
                    .navigationBarHidden(true)
                }
                .navigationViewStyle(.stack) // for iPad
                .environmentObject(vm)
                
                
                // ZStack을 해주고 zIndex까지 해줘야 transition 효과가 제대로 나타난다.
                ZStack{
                    if showLaunchView{
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(AnyTransition.move(edge: .leading))
                    }
                }.zIndex(2.0)
               
                
            }
            
            
        }
    }
}
