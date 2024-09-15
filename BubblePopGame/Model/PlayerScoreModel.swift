//
//  PlayerModel.swift
//  BubblePopGame
//
//  Created by Minh Phuc on 8/4/2024.
//

import Foundation
struct PlayerScore:Identifiable, Codable, Hashable  {
    var id = UUID()
    let playerName :String
    var score : Int         
}
