//
//  LaunchView.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/22.
//

import SwiftUI

struct LaunchView: View {
    @Binding var showLaunchView: Bool
    let loadingString:[String] = "Loading Screen...".map({String($0)})
    let timer = Timer.publish(every: 0.1 , on: .main, in: .common).autoconnect()
    @State var count: Int = 0
    @State var loop: Int = 0
    @State var showLoadingText: Bool = false
    
    var body: some View {
        ZStack{
            Color.launch.background
                .ignoresSafeArea()
            Image("logo-transparent")
                .resizable()
                .frame(width: 150, height: 150)
            ZStack{
                //VStack이 아니라 ZStack에 넣고 offset을 하는 이유는 로고를 가운데에 유지하도록 하기 위함.
                if showLoadingText{
                    HStack(spacing: 0.5){
                        ForEach(loadingString.indices, id: \.self) { index in
                            
                            Text(loadingString[index])
                                .foregroundColor(Color.launch.accent)
                                .font(.headline)
                                .bold()
                                .offset(y: count == index ? -5 : 0)
                        }
                       
                    }
                    .transition(AnyTransition.scale.animation(.easeInOut))
                    
                }
            }
            .offset(y: 80)
        }
        .onAppear(perform: {
            showLoadingText = true
        })
        .onReceive(timer) { _ in
            withAnimation(.spring()){
                if count > loadingString.count{
                    count = 0
                    loop += 1
                    
                    if loop == 1{
                        print("loop \(loop)")
                        showLaunchView.toggle()
                    }
                }else{
                    count += 1
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
