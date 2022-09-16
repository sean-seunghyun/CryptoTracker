//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/16.
//

import SwiftUI

struct SearchBarView: View {
    //@State var textFieldText: String = ""
    
    // 이렇게 하면 상위 컴포넌트에서 textFieldText를 관리할 수 있어서 재사용성이 높다.
    @Binding var textFieldText: String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    textFieldText.isEmpty ?
                    Color.theme.secondaryText :
                    Color.theme.accent
                )
            Spacer()
            TextField("Search by name or symbol...", text: $textFieldText)
                .foregroundColor(Color.theme.accent)
            // 아래 두개를 해줘야 키보드에서 제안 영역이 사라진다.
                .disableAutocorrection(true)
                .keyboardType(.alphabet)
            Spacer()
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(Color.theme.accent.opacity(
                    textFieldText.isEmpty ?
                    0 :
                    0.5))
                .onTapGesture {
                    textFieldText = ""
                    UIApplication.shared.endEditing()
                }
        }
        .padding()
        .background(
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(Color.theme.background)
            .shadow(color: Color.theme.accent.opacity(0.15), radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(textFieldText: .constant(""))
                .previewLayout(.sizeThatFits)
            
            SearchBarView(textFieldText: .constant(""))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
