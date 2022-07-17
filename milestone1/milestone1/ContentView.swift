//
//  ContentView.swift
//  milestone1
//
//  Created by Chris Hunter-Brown on 16/07/2022.
//

import SwiftUI

private enum Move: String, Identifiable, CaseIterable {
    case rock
    case paper
    case scissors
    
    var id: Move { self }
    
    var emoji: String {
        switch self {
        case .rock:
            return "🪨"
        case .paper:
            return "📃"
        case .scissors:
            return "✂️"
        }
    }
    
    var beats: Move {
        switch self {
        case .rock:
            return .scissors
        case .paper:
            return .rock
        case .scissors:
            return .paper
        }
    }
    
    var beatenBy: Move {
        switch self {
        case .rock:
            return .paper
        case .paper:
            return .scissors
        case .scissors:
            return .rock
        }
    }
    
    static func random() -> Move {
        let index = Int.random(in: 0...2)
        return Move.allCases[index]
    }
}

struct ContentView: View {
    
    @State private var score = 0
    @State private var turnNumber = 1
    @State private var showingGameOver = false
    @State private var playerShouldWin = Bool.random()
    @State private var computerMove: Move = Move.random()
    @State private var playerMove: Move?
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Rock, Paper, Scissors!")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 15) {
                    VStack {
                        if playerShouldWin {
                            Text("How do you beat \(computerMove.rawValue)?")
                                .foregroundStyle(.secondary)
                                .font(.subheadline.weight(.heavy))
                        } else {
                            Text("How do you lose to \(computerMove.rawValue)?")
                                .foregroundStyle(.secondary)
                                .font(.subheadline.weight(.heavy))
                        }
                    }
                
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            self.playerMove = Move.allCases[number]
                            handleMove()
                        }) {
                            Text("\(Move.allCases[number].emoji)")
                                .font(.system(size: 70))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.headline)
                    .fontWeight(.heavy)
                
                Spacer()
            }
            .padding()
        }
        .alert("Game over", isPresented: $showingGameOver) {
            Button("New game") {
                self.startNewGame()
            }
        } message: {
            Text("You scored \(score) points")
        }
    }
    
    func nextMove() {
        playerShouldWin.toggle()
        computerMove = Move.random()
    }
    
    func handleMove() {
        guard let move = playerMove else { return }
        
        if playerShouldWin {
            score += computerMove.beatenBy == move ? 1 : -1
        } else {
            score += computerMove.beats == move ? 1 : -1
        }
        turnNumber += 1
        if turnNumber <= 10 {
            nextMove()
        } else {
            showingGameOver = true
        }
    }
    
    func startNewGame() {
        showingGameOver = false
        turnNumber = 1
        score = 0
        nextMove()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
