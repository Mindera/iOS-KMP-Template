//
//  HeaderView.swift
//  iOSKMP
//
//  Created by Timea Varga on 20.04.2024.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Image(Constants.minderaIcon)
                .resizable()
                .frame(width: Constants.logoSize, height: Constants.logoSize)
            Text("Mindera")
                .font(.system(size: Constants.headerFontSize))
        }
        
        Color.appYellow
            .frame(height: Constants.smallPadding)
    }
}

#Preview {
    HeaderView()
}
