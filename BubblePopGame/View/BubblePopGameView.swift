////
////  BubblePopGameView.swift
////  BubblePopGame
////
////  Created by Minh Phuc on 13/4/2024.
////
//
import SwiftUI

struct BubbleGameView: View {
    @StateObject var viewModel: BubbleViewModel
    @ObservedObject var high : HighScoreViewModel
    var playerName: String
    @Binding private var countdownInput: String
    @Binding private var countdownValue : Double
    @State private var isGameFinished = false
    @State private var navigationPath = NavigationPath()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//initializing part
    init(playerName: String, score: Int, numberOfBubbles: Int, countdownInput: Binding<String>, countdownValue: Binding<Double>) {
        self.playerName = playerName
        self._countdownInput = countdownInput
        self._countdownValue = countdownValue
        _viewModel = StateObject(wrappedValue: BubbleViewModel(screensize: UIScreen.main.bounds.size, score: score, numberOfBubbles: numberOfBubbles))
        self._high = ObservedObject(wrappedValue: HighScoreViewModel())
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            //showing small board on bubblegame screen
            VStack {
                HStack {
                    GameStatusView(timeLeft: countdownValue, score: viewModel.score, highScore: viewModel.highScore)
                        .padding()
                    Spacer()
                }
                //this part shows bubbles
                ZStack {
                    ForEach(viewModel.bubbles) { bubble in
                        Circle()
                            .fill(bubble.color)
                            .frame(width: 80, height: 80)
                            .position(bubble.position)
                            .onTapGesture {
                                viewModel.popBubble(bubble)
                            }
                            .animation(.easeOut, value: viewModel.bubbles)
                            .transition(.scale)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200)
                    }
                }
                
                Spacer()
                
            }
            .padding(.top, 50)
            .edgesIgnoringSafeArea(.top)
        //this message will pop up when game is finished, it will show the final score
            .alert(isPresented: $isGameFinished) {
                Alert(
                    title: Text("Game Over"),
                    message: Text("Your final score is \(viewModel.score)"),
                    dismissButton: .default(Text("Close")) {}
                )
            }
        //when game is finised, it will lead player to high score board
            .navigationDestination(for: PlayerScore.self) { playerScore in
                HighScoreView(playerName: playerScore.playerName, score: playerScore.score)
                    .navigationBarBackButtonHidden(true)
            }
        //run the game
            .onReceive(timer) { _ in
                if countdownValue > 0 && !isGameFinished {
                    countdownValue -= 1
                    countdownInput = "\(Int(countdownValue))"
                    viewModel.generateBubble()
                } else {
                    self.end()
                }
            }
            //handle when player press back button, it should save the score
            .onDisappear() {
                guard !isGameFinished else {return}
                self.timer.upstream.connect().cancel()
                isGameFinished = true
                if playerName != "" {
                    high.savePlayerScore(playerName: playerName, score: viewModel.score)
                } else {
                    high.savePlayerScore(playerName: "Unknown Player", score: viewModel.score)
                }
            }
        }
    }
            //end game
    private func end() {
        self.timer.upstream.connect().cancel()
        isGameFinished = true
        let playerScore = PlayerScore(playerName: playerName, score: viewModel.score)
        navigationPath.append(playerScore)
    }
}
