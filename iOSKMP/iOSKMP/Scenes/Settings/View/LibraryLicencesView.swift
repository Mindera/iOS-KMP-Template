//
//  LibraryLicencesView.swift
//  iOSKMP
//
//  Created by Naveen Katari  on 25/04/24.
//

import Foundation
import SwiftUI
import AcknowList

struct LibraryLicencesView: View {
    @State private var viewModel = LibraryLicencesViewModel()
    
    var body: some View {
        NavigationStack {
            AcknowListSwiftUIView(acknowledgements:viewModel.acknowledgements)
                .navigationBarHidden(true)
        }
        .navigationTitle("Acknowledgements")
    }
}

#Preview {
    LibraryLicencesView()
}
