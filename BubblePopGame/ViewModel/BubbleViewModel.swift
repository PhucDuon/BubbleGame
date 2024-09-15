//
//  BubbleViewModel.swift
//  BubblePopGame
//
//  Created by Minh Phuc on 14/4/2024.
//

import Foundation
import UIKit
import SwiftUI
//initializing part
class BubbleViewModel: ObservableObject {
    @Published var bubbles: [Bubble] = []
    @Published var score : Int = 0
    @Published var numberOfBubbles : Int
    @Published  var highScore : Int
    private let bubbleSize = CGSize(width: 80, height: 80)
    private var shouldAddBubbles : Bool = false
    private var lastPoppedBubble : Bubble?
    private var timer: Timer?
    let screenSize:CGSize
    //initializing part
    init(screensize: CGSize, score: Int, numberOfBubbles: Int) {
        self.screenSize = screensize
        self.score = score
        self.numberOfBubbles = numberOfBubbles
        self.highScore = UserDefaults.standard.integer(forKey: "HighScore")
        starter()
    }
    //setup the probability of the appearence for each type of bubbles
    private func randomColor() -> Color {
        let randomNumber = Int.random(in: 1...100)
        switch randomNumber {
        case 1...40:
            return .red
        case 41...70:
            return .pink
        case 71...85:
            return .green
        case 86...95:
            return .blue
        default:
            return .black
        }
    }
    //calculate the point for each type of bubble
    private func calculatePoints(for color: Color) -> Int {
        switch color {
        case .red:
            return 1
        case .pink:
            return 2
        case .green:
            return 5
        case .blue:
            return 8
        case .black:
            return 10
        default:
            return 0
        }
    }
    //set up the game
    func starter() {
        guard self.numberOfBubbles > 0 else {return}
        let firstNoBubbles = Int.random(in: 1...numberOfBubbles)
        for _ in 0...firstNoBubbles {
            generateBubble()
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.reloadBubbles()
        }
    }
    //refresh the number of bubbles every second
     func reloadBubbles() {
         if shouldAddBubbles {
             guard bubbles.count < numberOfBubbles else {return}
             let NoToAdd = Int.random(in: 1...(numberOfBubbles - bubbles.count))
             for _ in 0..<NoToAdd {
                 generateBubble()
             }
         } else {
             self.bubbles = self.bubbles.filter{_ in Bool.random()}
         }
         shouldAddBubbles.toggle()
        }

    //create the bubble
    func generateBubble() {
        guard bubbles.count < numberOfBubbles else { return }
        
        let bubbleDiameter = CGFloat.random(in: 60...100)
        let bubbleRadius = bubbleDiameter / 2.0
        //ensure bubbles are fully displayed on screen
        let minX = bubbleRadius + 10
        let maxX = screenSize.width - bubbleRadius - 10
        let minY = bubbleRadius
        let maxY = screenSize.height - bubbleRadius - 200
        //create bubble
        let position = CGPoint(x: CGFloat.random(in: minX...maxX),
                               y: CGFloat.random(in: minY...maxY))
        let color = randomColor()
        let points = calculatePoints(for: color)
        let bubble = Bubble(position: position, color: color, points: points)
        
        guard !isOverlap(bubble.position) else { return generateBubble() }
        
        bubbles.append(bubble)
    }

        //this allows users to pop the bubble and calculate the point when player pop the bubble
    func popBubble(_ bubble: Bubble) {
        var pointGet = calculatePoints(for: bubble.color )
        //calculate bonus point if players got a streak
        if let lastBubble = lastPoppedBubble, lastBubble.color == bubble.color {
            pointGet = Int((Double(calculatePoints(for: bubble.color)) * 1.5).rounded())
        }
        score+=pointGet
        //update high score if player breaks high score
        if score > highScore {
            highScore = score
            UserDefaults.standard.set(highScore, forKey: "HighScore")
        }
        
        self.bubbles = self.bubbles.filter{ $0.id != bubble.id }
        lastPoppedBubble = bubble //update new last popped bubble
        }
    
    //avoid the bubbles on the screen overlap each other
    private func isOverlap(_ position: CGPoint) -> Bool {
        let bubbleDiameter = bubbleSize.width
        let minDis = CGFloat(bubbleDiameter)
        for bubble in bubbles {
            let dis = sqrt(pow(bubble.position.x - position.x,2) + pow(bubble.position.y - position.y, 2))
            if dis < minDis {
                return true
            }
        }
        return false
    }
//end the game
    func end() {
        timer?.invalidate()
        timer = nil
    }
}

