import SwiftUI

// MARK: - Ring Loader View

/// An indeterminate circular ring loader with smooth rotation.
/// This view renders a fixed arc and rotates it continuously,
/// avoiding progress resets and visual blinking.
struct RingLoaderView: View {

    // MARK: - State

    /// Controls the continuous rotation animation.
    @State private var rotate = false

    // MARK: - View

    var body: some View {
        ZStack {

            // MARK: Background Ring

            Circle()
                .stroke(
                    Color.white.opacity(0.2),
                    lineWidth: 8
                )

            // MARK: Foreground Ring

            Circle()
                .trim(from: 0.15, to: 0.65)
                .stroke(
                    Color.white,
                    style: StrokeStyle(
                        lineWidth: 8,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
        }
        .aspectRatio(1, contentMode: .fit)
        .rotationEffect(.degrees(rotate ? 360 : 0))
        .animation(
            .linear(duration: 1.0)
                .repeatForever(autoreverses: false),
            value: rotate
        )
        .onAppear {
            rotate = true
        }
    }
}
