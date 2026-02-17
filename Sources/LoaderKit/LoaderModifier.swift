import SwiftUI

struct LoaderModifier: ViewModifier {

    // MARK: - Properties

    /// Shared loader state used to control loader visibility.
    @ObservedObject private var loader = AppLoader.shared

    // MARK: - ViewModifier

    /// Wraps the content with a loader overlay when loader is active.
    func body(content: Content) -> some View {
        ZStack {
            content

            // Loader overlay
            if loader.isLoader {
                LoaderView(
                    style: loader.style,
                    isSilent: loader.isSilent
                )
            }

            // Success overlay
            if loader.showsSuccess,
               let message = loader.successMessage {
                SuccessView(message: message)
            }

            // Error overlay
            if loader.showsError,
               let message = loader.errorMessage {
                ErrorView(message: message)
            }
        }
    }
}
