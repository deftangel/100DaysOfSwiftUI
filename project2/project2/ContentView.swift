//
//  ContentView.swift
//  project2
//
//  Created by Chris Hunter-Brown on 20/07/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    @State private var showingGameOver = false
    @State private var questionNumber = 1
    
    @State private var flagIndexTapped = 0
    @State private var rotationDegrees = 0.0
    @State private var scaleFactor = 1.0
    @State private var opacityFactor = 1.0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            self.flagTapped(number)
                        }) {
                            FlagImage(imageName: self.countries[number])
                                .scaleEffect(flagIndexTapped == number ? 1.0 : scaleFactor)
                                .opacity(flagIndexTapped == number ? 1.0 : opacityFactor)
                                .rotation3DEffect(.degrees(flagIndexTapped == number ? rotationDegrees : 0), axis: (x: 0, y: 1, z: 0))

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
        }.alert(isPresented: $showingScore, content: {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue"), action: {
                self.checkGameOver()
            }))
        })
        .alert("Game over", isPresented: $showingGameOver) {
            Button("New game") {
                self.startNewGame()
            }
        } message: {
            Text("You scored \(score) points")
        }
    }
    
    func flagTapped(_ number: Int) {
        
        flagIndexTapped = number
        
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
            scoreMessage = "Your score is \(score)"
        } else {
            score -= 1
            scoreTitle = "Wrong"
            scoreMessage = "That's the flag of \(countries[number])"
        }
        
        withAnimation {
            rotationDegrees += 360
            scaleFactor = 0.75
            opacityFactor = 0.25
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            self.showingScore = true
        }

    }
    
    func checkGameOver() {
        questionNumber += 1
        if questionNumber > 8 {
            showingGameOver = true
        } else {
            askQuestion()
        }
    }
    
    func startNewGame() {
        questionNumber = 1
        score = 0
        askQuestion()
    }
    
    func askQuestion() {
        withAnimation {
            scaleFactor = 1.0
            opacityFactor = 1.0
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct FlagImage: View {
    var imageName: String
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
