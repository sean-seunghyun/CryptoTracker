//
//  CircleButtonView.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/14.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
        // frame으로 아이콘의 사이즈를 고정시켜준다.
            .frame(width: 20, height: 20)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .padding()
            .background(
                Circle()
                    .foregroundColor(Color.theme.background)
                    .shadow(color: Color.theme.accent.opacity(0.3), radius: 10, x: 0, y: 0)
            )
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group{
            CircleButtonView(iconName: "info")
                .previewLayout(.sizeThatFits)
            
            CircleButtonView(iconName: "plus")
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                
        }
        
    }
}
