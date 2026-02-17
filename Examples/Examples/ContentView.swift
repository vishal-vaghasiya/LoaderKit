//
//  ContentView.swift
//  Examples
//
//  Created by Vishal Vaghasiya on 10/02/26.
//

import SwiftUI
import LoaderKit

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {

            // MARK: - Loader Types

            Button("Activity Loader") {
                AppLoader.shared.show(style: .activity)
            }

            Button("Ring Loader") {
                AppLoader.shared.show(style: .ring)
            }

            Button("GIF Loader") {
                AppLoader.shared.show(style: .gif(name: "CCO-loader"))
            }

            Button("Silent Loader") {
                AppLoader.shared.showSilent(style: .ring)
            }

            Button("Hide Loader") {
                AppLoader.shared.hide()
            }

            Divider()

            // MARK: - Success & Error

            Button("Show Success") {
                AppLoader.shared.showSuccess(
                    message: "Saved successfully"
                )
            }

            Button("Show Error") {
                AppLoader.shared.showError(
                    message: "Something went wrong"
                )
            }

            Divider()

            // MARK: - Async Example

            Button("Async API Call") {
                Task {
                    do {
                        try await AppLoader.shared.withLoader {
                            try await Task.sleep(nanoseconds: 2_000_000_000)
                        }
                        AppLoader.shared.showSuccess(message: "API completed")
                    } catch {
                        AppLoader.shared.showError(message: "API failed")
                    }
                }
            }
        }
        .padding()
        .withLoader()   // ✅ REQUIRED
    }
}

#Preview {
    ContentView()
}
