import SwiftUI

struct ContentView: View {
    @Environment(SoundEffectManager.self) private var soundEffectManager
    
    // The current game, nil by default
    @State private var currentGame: Game? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            sscDivider
            
            ScrollView {
                VStack {
                    sscLogo
                    sscBadge
                    
                    title
                    frameworkBadges
                    description
                    
                    NewGameView(game: $currentGame)
                        .sheet(item: $currentGame) {
                            // Set currentGame to nil on dismiss
                            currentGame = nil
                        } content: { currentGame in
                            GameView(game: currentGame)
                                .environment(soundEffectManager)
                        }
                }
                .multilineTextAlignment(.center)
                .padding(.vertical, 100)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}

extension ContentView {    
    private var sscDivider: some View {        
        HStack(spacing: 0) {
            ForEach(SSCColor.allCases) { sscColor in
                Rectangle()
                    .fill(sscColor.color)
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(height: 15)
    }
    
    private var sscLogo: some View {
        Image("SSC_Logo")
            .resizable()
            .scaledToFit()
            .frame(width: 256, height: 256)
    }
    
    private var sscBadge: some View {
        Text("Swift Student Challenge 2024")
            .capsule()
            .padding(.top, 40)
            .foregroundStyle(.white)
    }
    
    private var title: some View {
        VStack(spacing: 10) {
            Text("Introducing Contexto")
                .font(.system(size: 72))
                .fontWeight(.semibold)
            
            Text("An interactive context-related word quiz game that utilizes the latest technologies in natural language processing")
                .font(.title2)
                .frame(maxWidth: 650)
        }
        .foregroundStyle(.white)
    }
    
    private var frameworkBadges: some View {
        HStack(spacing: 15) {
            Spacer()
            
            Text("Natural Language")
                .coloredCapsule(color: SSCColor.orange.color)
            
            Text("AVFoundation")
                .coloredCapsule(color: SSCColor.pink.color)
            
            Text("SwiftUI")
                .coloredCapsule(color: SSCColor.lightBlue.color)
            
            Text("TipKit")
                .coloredCapsule(color: SSCColor.lightGreen.color)
            
            Spacer()
        }
        .padding(.vertical, 35)
    }
    
    private var description: some View {
        VStack(spacing: 30) {
            Text("Welcome to this year's WWDC24 Swift Student Challenge! I'm very proud to present you my very first submission called Contexto. I wanted to take part in this challenge to deepen my newly gained coding skills and learn more about the amazing world of app development with Swift and SwiftUI.")
            
            Text("Let's get started right away by pressing the button below. I wish you lots of fun and look forward to your feedback!")
        }
        .foregroundStyle(.gray)
        .frame(maxWidth: 650)
        .padding(.bottom, 50)
    }
}
