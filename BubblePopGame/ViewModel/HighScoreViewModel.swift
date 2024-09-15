//
//  HighScoreViewModel.swift
//  BubblePopGame
//
//  Created by Minh Phuc on 23/4/2024.
//

import Foundation

class HighScoreViewModel: ObservableObject {
    @Published var playerScores: [PlayerScore] = []

    init() {
        loadPlayerScores()
    }

    func savePlayerScore(playerName: String, score: Int) {
        let newPlayerScore = PlayerScore(playerName: playerName, score: score)
        playerScores.append(newPlayerScore)
        saveScoresToUserDefaults()
    }
    //get player score
    private func loadPlayerScores() {
        if let data = UserDefaults.standard.data(forKey: "PlayerScores") {
            let decoder = JSONDecoder()
            if let decodedPlayerScores = try? decoder.decode([PlayerScore].self, from: data) {
                playerScores = decodedPlayerScores
            }
        }
    }
    //save the new score to the score board if it achieves high score(top 5)
    private func saveScoresToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(playerScores) {
            UserDefaults.standard.set(encoded, forKey: "PlayerScores")
        }
    }
}

