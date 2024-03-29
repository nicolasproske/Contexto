import SwiftUI
import AVFoundation

@Observable
class SoundEffectManager {
    // Instance of the audio player
    private var player: AVAudioPlayer?
    
    // Play the sound effect if the correspondig file is present in the resources
    func play(soundEffect: SoundEffect) {
        guard let soundURL = Bundle.main.url(forResource: soundEffect.rawValue, withExtension: "wav") else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
            player?.play()
        } catch {
            print("Failed to load sound \(soundEffect.rawValue)")
        }
    }
}
