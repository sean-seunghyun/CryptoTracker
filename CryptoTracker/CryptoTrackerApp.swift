//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/14.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            
            //NavigationView는 가장 상단에 설정해주는 것이 좋다.
            NavigationView{
                HomeView()
                .navigationBarHidden(true)
            }
           
        }
    }
}
