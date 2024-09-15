//
//  BubbleModel.swift
//  BubblePopGame
//
//  Created by Minh Phuc on 13/4/2024.
//

import Foundation
import SwiftUI

struct Bubble: Identifiable, Equatable {
    var id = UUID()
    var position: CGPoint
    var color: Color
    var points: Int

    init(position: CGPoint, color: Color, points: Int) {
           self.position = position
           self.color = color
           self.points = points
       }
}
