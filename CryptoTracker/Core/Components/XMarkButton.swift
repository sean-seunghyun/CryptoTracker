//
//  XMarkButton.swift
//  CryptoTracker
//
//  Created by sean on 2022/09/19.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Image(systemName: "xmark")
            .font(.headline)
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
    }
}
