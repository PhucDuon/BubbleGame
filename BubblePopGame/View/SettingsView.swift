//
//  SettingsView.swift
//  BubblePopGame
//
//  Created by Minh Phuc Duong on 29/3/2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var countdownInput = ""
    @State private var countdownValue: Double = 60
    @State private var numberOfBubbles: Double = 15
    @State private var playerName : String = ""
    @State private var score : Int = 0
    @State private var highScore : Int = UserDefaults.standard.integer(forKey: "HighScore")
    //design layout for the setting view
    var body: some View {
            VStack{
                //enter player's name
                Text("Enter Your Name:")
                    .foregroundStyle(.mint)
                    .font(.title)
                
                TextField("Enter Name", text: $playerName)
                    .padding()
                Spacer()
                //set up game time
                Text("Game Time")
                    .foregroundStyle(.mint)
                    .font(.title)
                Slider(value: $countdownValue, in: 0...60, step: 1)
                    .padding()
                    .onChange(of: countdownValue, perform: { value in
                        countdownInput = "\(Int(value))"
                    })
                Text(" \(Int(countdownValue))")
                    .padding()
                //limit the number of bubbles appearing on the screen
                Text("Maximum bubbles")
                    .foregroundStyle(.mint)
                    .font(.title)
                Slider(value: $numberOfBubbles, in: 0...15, step: 1)
                    .padding()
                                
                Text("\(Int(numberOfBubbles))")
                                    .padding()
                //this button allows player to play game with setting above
                NavigationLink(
                    destination: BubbleGameView(playerName: playerName, score: score,numberOfBubbles: Int(numberOfBubbles), countdownInput: $countdownInput, countdownValue: $countdownValue),
                    label: {
                        HStack {
                                    Image("play")
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                                }
                    })
                
                
            }
            .padding()
        //reset number of bubbles and countdownValue are re set-up
            .onDisappear{
                UserDefaults.standard.set(playerName, forKey: "PlayerName")
            }
        }
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
