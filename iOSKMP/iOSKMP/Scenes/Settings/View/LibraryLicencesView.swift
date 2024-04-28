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
    @State private var viewModel: LibraryLicencesViewModel
    
    init(viewModel: LibraryLicencesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        AcknowListSwiftUIView(acknowledgements:viewModel.acknowledgements)
            .navigationBarBackButtonHidden(true)
//            .navigationTitle("Acknowledgements")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.goBack()
                    } label: {
                        Image(systemName: "chevron.backward")
                    }
                }
            }
    }
}
