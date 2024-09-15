//
//  PlayerScoreView.swift
//  BubblePopGame
//
//  Created by Minh Phuc on 12/4/2024.
//

import SwiftUI
//design board for player score
struct PlayerScoreView: View {
    var playerScore : PlayerScore
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
                .foregroundColor(.black)
                .imageScale(.large)
            Text(playerScore.playerName)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(1)
                .truncationMode(.tail)
            Spacer()
            
            Text("\(playerScore.score)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.red)
                .padding(.all, 8)
        }
        .padding()
    }
}

struct PlayerScoreView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerScoreView(playerScore: PlayerScore(playerName: "Phuc", score: 100))
    }
}
