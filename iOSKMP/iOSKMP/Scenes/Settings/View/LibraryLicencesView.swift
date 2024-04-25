//
//  OpenSourceView.swift
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
          if let acknowledgements = viewModel.acknowledgements {
              AcknowListSwiftUIView(acknowledgements:acknowledgements)
                  .navigationBarHidden(true)
          }
     }
      .navigationTitle(Text(LocalizedStringKey(Localization.acknowledgementsTitle)))
    }
}

#Preview {
    LibraryLicencesView()
}
