//
//  GameStatusView.swift
//  BubblePopGame
//
//  Created by Minh Phuc on 12/4/2024.
//

import SwiftUI

struct GameStatusView: View {
    var timeLeft : Double
    var score : Int
    var highScore : Int
    //design board showing on top of the bubblepop game screen
    var body: some View {
        HStack {
            GameStatusColumnView(title: "Time Left", value: "\(Int(timeLeft))")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                              
                                Spacer()
            
                            
            GameStatusColumnView(title: "Score", value: "\(score)")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                                
                                Spacer()
                            
            GameStatusColumnView(title: "High Score", value: "\(highScore)")
                                .foregroundColor(.gray)
                                Spacer()
        }
        .padding()
    }
}

struct GameStatusView_Previews: PreviewProvider {
    static var previews: some View {
        GameStatusView(timeLeft: 0, score: 0, highScore: 0)
    }
}
