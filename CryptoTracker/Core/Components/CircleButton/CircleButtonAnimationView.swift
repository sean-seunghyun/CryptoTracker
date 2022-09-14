//
//  CircleButtonAnimationView.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/14.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding var isAnimate: Bool
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(isAnimate ? 1.0 : 0.0)
            .opacity(isAnimate ? 0.0 : 1.0)
            .animation(isAnimate ? .easeOut(duration: 1.0) : .none)
           
            
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView(isAnimate: .constant(false))
    }
}
