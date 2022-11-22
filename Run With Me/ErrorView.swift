//
//  ErrorView.swift
//  Run With Me
//
//  Created by Allen Jue on 11/21/22.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("An Error Has Occurred!")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                Text(errorWrapper.guidance)
                    .padding(.top)
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ErrorView_Preview: PreviewProvider {
    enum sampleError: Error {
        case errorRequired
    }
    
    static var wrapper: ErrorWrapper {
        ErrorWrapper(error: sampleError.errorRequired, guidance: "Sample error")
    }
    
    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }
}
