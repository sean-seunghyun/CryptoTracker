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
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            
            //NavigationView는 가장 상단에 설정해주는 것이 좋다.
            NavigationView{
                HomeView()
                .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
