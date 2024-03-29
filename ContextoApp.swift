import SwiftUI
import TipKit

@main
struct ContextoApp: App {
    // Manager for playing sound effects
    @State private var soundEffectManager = SoundEffectManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(soundEffectManager)
                .task {
                    // Configure tips on start
                    try? Tips.configure()
                }
        }
    }
}
