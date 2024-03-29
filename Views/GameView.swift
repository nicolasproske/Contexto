import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var game: Game
    
    // The current guess of the user
    @State private var currentGuess = ""
    
    // A list of words guessed by the user
    @State private var currentGuesses = [Guess]()
    
    // The filtered and sorted guesses
    private var filteredSortedGuesses: [Guess] {
        currentGuesses
            .filter({ $0.index == -1 || $0.index > 9}) // Return only if index is -1 or greater than 9
            .sorted(by: { ($0.index < $1.index) }) // Sort by ascending index
            .sorted(by: { $0.index != -1 && $1.index == -1 }) // Sort indices of value -1 at the end
    }
    
    // Indicates if the searched word is guessed correctly
    @State private var isFinished = false
    
    // The current points of the user
    @State private var currentPoints = 0
    
    // The elapsed time
    @State private var currentTime = 0
    
    // The timer to update the elapsed time every second
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // The tip presented to explain the game
    private let howToPlayTip = HowToPlayTip()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    logo
                    
                    Group {
                        // Show congratulations only if the game is finished
                        if isFinished {
                            congratulations
                            Divider()
                        }
                        
                        badges
                        searchedWord
                        
                        // Show the input field only if the game is not finished
                        if !isFinished {                        
                            GuessView(game: game, guess: $currentGuess, guesses: $currentGuesses, points: $currentPoints, isFinished: $isFinished) { 
                                finishGame()
                            }
                        }
                    }
                    .fontDesign(.rounded)
                    
                    Divider()
                    
                    HStack {                        
                        TopTenNeighborsView(neighbors: game.topTenSortedNeighbors, points: $currentPoints)
                        
                        // Show the guessed words by the user only if present
                        if !filteredSortedGuesses.isEmpty {
                            GuessesView(guesses: filteredSortedGuesses)
                        }
                    }
                    .disabled(isFinished)
                }
                .padding(.horizontal, 50)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    toolbarContent
                }
                .onChange(of: game, initial: false) { oldGame, newGame in
                    // Ensure that the game has changed
                    if oldGame != newGame {
                        setupNewGame()
                    }
                }
            }
        }
    }
}

extension GameView {
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) { 
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.gray)
            }
        }
    }
    
    private var logo: some View {
        ZStack {
            Image("Logo_Base")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
            
            Image("Logo_Top")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
        }
        .foregroundStyle(.primary)
        .frame(maxWidth: 350)
        .padding(.horizontal, 50)
        .padding(.vertical, 30)
        .popoverTip(howToPlayTip, arrowEdge: .bottom)
    }
    
    private var congratulations: some View {
        VStack(spacing: 15) {
            Text("🎉")
                .font(.system(size: 64))
            
            Text("Congratulations, well done!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button {
                dismiss()
            } label: {
                Text("Back to main menu")
                    .prominentButton()
            }
        }
    }
    
    private var badges: some View {
        HStack {
            StopwatchView(seconds: currentTime)
                .onReceive(timer) { _ in
                    withAnimation { 
                        currentTime += 1
                    }
                }
            
            InfoBadgeView(title: "Guessed Neighbors", value: "\(currentGuesses.filter({ $0.index != -1 }).count)")
            
            PointsView(points: currentPoints)
        }
    }
    
    private var searchedWord: some View {
        VStack(spacing: 15) {
            Text("The searched word is \(game.searchWord.context)")
            
            HStack {
                ForEach(Array(game.searchWord.rawValue.enumerated()), id: \.offset) { index, character in
                    Text(isFinished ? String(character) : "?")
                        .contentTransition(.numericText())
                        .font(.title3)
                        .foregroundStyle(.white)
                        .textCase(.uppercase)
                        .fontWeight(.bold)
                        .frame(width: 24, height: 24)
                        .padding(10)
                        .background(SSCColor.allCases[index % SSCColor.allCases.count].color)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
        }
    }
}

extension GameView {
    // Setup a new game by resetting all values to default and starting the timer
    private func setupNewGame() {
        currentGuess = ""
        currentGuesses = []
        
        isFinished = false
        currentPoints = 0
        
        startTimer()
    }
    
    // Finish the game by setting isFinished and stopping the timer
    private func finishGame() {
        withAnimation {
            isFinished = true
        }
        
        stopTimer()
    }
    
    // Start the timer
    private func startTimer() {
        currentTime = 0
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    // Stop the timer by cancelling the activity
    private func stopTimer() {
        timer.upstream.connect().cancel()
    }
}
