//
//  ContentView.swift
//  BubblePopGame
//
//  Created by Minh Phuc Duong on 29/3/2024.
//

import SwiftUI

struct ContentView: View {
    var playerName : String?
    var score : Int?
    @State private var isFading = false
    var body: some View {
        //create the layout for the homepage
        NavigationView{
            VStack {
                //add big title
                Label("Bubble Pop", systemImage: "")
                    .foregroundStyle(.mint)
                    .font(.custom("Times New Roman", size: 50))
                    .opacity(isFading ? 0 : 1)
                                        .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
                Spacer()
                //add logo
                Image("logo")
                Spacer()
                //this button navigates player to setting page
                NavigationLink(
                    destination: SettingsView(),
                    label: {
                        Text("New Game")
                            .foregroundStyle(.mint)
                            .font(.largeTitle)
                    })
                .padding(50)
                .background(
                                Image("background")
                            )
                //this button navigates player to the high score page
                NavigationLink(
                    destination: HighScoreView(),
                    label: {
                        Text("High Score")
                            .foregroundStyle(.mint)
                            .font(.title)
                    })
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Home")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
