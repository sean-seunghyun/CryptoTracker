//
//  HomeStatsView.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/16.
//

import SwiftUI

struct HomeStatsView: View {
    @EnvironmentObject var vm:HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width * (1/3))
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment:
                !showPortfolio ? .leading : .trailing)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortfolio: .constant(false))
            .environmentObject(dev.vm)
    }
}
