//
//  ErrorBanner.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 30/8/25.
//

import SwiftUI

struct ErrorBanner: View {
    let error: Error?
    var retry: () -> Void
    var body: some View {
        HStack {
            if let networkError = error as? NetworkError {
                Text(networkError.errorDescription).font(.footnote)
            } else {
                Text(error?.localizedDescription ?? "Unknown error").font(.footnote)
            }
            Spacer()
            Button("Retry", action: retry)
        }
        .padding(12)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(radius: 4)
    }
}
