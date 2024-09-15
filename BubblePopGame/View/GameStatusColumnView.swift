//
//  GameStatusColumnView.swift
//  BubblePopGame
//
//  Created by Minh Phuc on 12/4/2024.
//

import SwiftUI
//design board for player score
struct GameStatusColumnView: View {
    var title : String
    var value : String
    var body: some View {
        VStack {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
            Text(value)
                .font(.title3)
        }
    }
}

struct GameStatusColumnView_Previews: PreviewProvider {
    static var previews: some View {
        GameStatusColumnView(title: "", value: "21")
    }
}
