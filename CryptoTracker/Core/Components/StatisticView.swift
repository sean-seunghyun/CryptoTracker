//
//  StatisticView.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/16.
//

import SwiftUI

struct StatisticView: View {
    let stat:Statistics
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees:
                                            (stat.percentageChange ?? 0) >= 0 ?
                                          0 : 180))
                    .foregroundColor(
                        (stat.percentageChange ?? 0) >= 0 ? Color.theme.green :
                            Color.theme.red
                    )
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption2)
                    .bold()
            }
            .opacity((stat.percentageChange == nil) ? 0.0 : 1.0)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(stat: dev.stat1)
            .previewLayout(.sizeThatFits)
    }
}
