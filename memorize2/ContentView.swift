//
//  ContentView.swift
//  memorize2
//
//  Created by Jubhedha Shaik on 6/23/25.
//

import SwiftUI

struct CardView: View {
    let content: String
    @State private var isFaceUp = false
    @State private var faceUpColor: Color = .white

    var body: some View {
        ZStack {
            let shape = Circle()
            if isFaceUp {
                shape.fill().foregroundColor(faceUpColor)
                shape.strokeBorder(lineWidth: 1)
                Text(content)
                    .font(.largeTitle)
            } else {
                shape.fill().foregroundColor(.teal)
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
            if isFaceUp {
                faceUpColor = randomColor()
            }
        }
    }

    private func randomColor() -> Color {
        let colors: [Color] = [.brown, .blue, .green, .orange, .pink, .yellow, .red]
        return colors.randomElement() ?? .purple
    }
}



struct ContentView: View {
    @State private var emojis: [String] = []

    let animaltheme = ["🐶", "🐷", "🐰", "🦁", "🙊", "🐮", "🐔", "🐙"]
    let symboltheme = ["🩷", "❤️", "🩵", "🖤", "💔", "❤️‍🩹", "❣️", "💝"]
    let humantheme = ["👧🏼", "👦🏻", "👩🏻‍🎓", "🧛‍♂️", "👩🏻‍🚀", "👩‍💻", "🥷🏻", "🦹🏻‍♀️"]

    var body: some View {
        VStack {
            Text("Memorize")
                .font(.largeTitle)
                .bold()
                .italic()
                .padding()

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(emojis.indices, id: \.self) { index in
                        CardView(content: emojis[index])
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .padding()
            }

            Spacer()

            HStack {
                themeButton(symbol: "dog.fill", name: "Animals", emojis: animaltheme)
                Spacer()
                themeButton(symbol: "heart.fill", name: "Symbols", emojis: symboltheme)
                Spacer()
                themeButton(symbol: "figure.stand", name: "Humans", emojis: humantheme)
            }
            .padding(.horizontal)
        }
        .padding()
    }

    private func themeButton(symbol: String, name: String, emojis: [String]) -> some View {
        Button(action: {
            self.emojis = (emojis + emojis).shuffled()
        }) {
            VStack {
                Image(systemName: symbol)
                    .font(.largeTitle)
                Text(name)
                    .font(.caption)
            }
        }
    }
}
