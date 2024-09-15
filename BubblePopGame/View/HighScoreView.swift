//
//  HighScoreView.swift
//  BubblePopGame
//
//  Created by Minh Phuc Duong on 29/3/2024.

import SwiftUI

struct HighScoreView: View {
    @StateObject var highScoreViewModel = HighScoreViewModel()
    var playerName: String?
    var score: Int?

    var body: some View {
        VStack {
            Label("High Score Board", systemImage: "")
                .foregroundStyle(.blue)
                .font(.largeTitle)
            Spacer()
            //create a list of player's score
            List(highScoreViewModel.playerScores.sorted(by: { $0.score > $1.score }).prefix(5)) { playerScore in
                PlayerScoreView(playerScore: playerScore)
            }
            Spacer()
        }
        .onAppear {
            if let playerName = playerName, let score = score, score >= 0 {
                if playerName.isEmpty {
                    highScoreViewModel.savePlayerScore(playerName: "Unknown Player", score: score)
                } else {
                    highScoreViewModel.savePlayerScore(playerName: playerName, score: score)
                }
            }
        }
    }
}
