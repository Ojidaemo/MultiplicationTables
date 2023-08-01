//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Vitali Martsinovich on 2023-07-28.
//

import SwiftUI

struct ContentView: View {
    
    @State private var score = 0
    @State private var roundQuestion = ""
    @State private var correctAnswer = 0
    @State private var tappedButton = -1
    @State private var answersArray: [Int] = []
    @Binding var chosenQuestionsNumber: Int
    @Binding var chosenNumberToPractise: Int
    
    // for alert
    @State private var showingScore = false
    @State private var scoreTitle = ""
    //for restarting game
    @State private var gameOver = false
    @State private var isNewGamePressed = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.black, .blue, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack {
                    Text("Multiplication Table")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Text("Questions left: \(chosenQuestionsNumber)")
                        .foregroundColor(.gray)
                        .padding(.top, -10)
                    Spacer()
                    Text("\(roundQuestion)").font(.title).bold()
                        .foregroundColor(.white)
                    Spacer()
                    VStack(spacing: 15) {
                        Text("What is the correct answer?")
                            .font(.title2)
                            .foregroundColor(.white)
                        ForEach(answersArray, id: \.self) { number in
                            Button("\(number)") {
                                buttonTapped(number)
                            }
                            .frame(width: 150, height: 20)
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .scaleEffect(tappedButton == -1 || tappedButton == number ? 1.0 : 0.75)
                            .animation(.default, value: tappedButton)
                        }
                    }
                    Spacer()
                    Text("Score \(score)")
                        .font(.title)
                        .padding(.bottom, 20)
                        .foregroundColor(.white)
                }
            }
            .toolbar {
                Button("New game") {
                    isNewGamePressed = true
                }
                .buttonStyle(.bordered)
            }
        }
        .fullScreenCover(isPresented: $isNewGamePressed) {
            SettingsView()
        }
        .onAppear(perform: generateQuestion)
        .alert(scoreTitle, isPresented: $showingScore) {
            if gameOver {
                Button("Play Again", action: resetGame)
            } else {
                Button("Continue", action: generateQuestion)
            }
        } message: {
            if gameOver {
                Text("Game Over! Your final score is \(score)")
            } else {
                Text("Your score is \(score)")
            }
        }
    }
    
    func generateQuestion() {
        let rightSideOperand = Int.random(in: 1...10)
        roundQuestion = "\(chosenNumberToPractise + 2) x \(rightSideOperand) = ???"
        correctAnswer = (chosenNumberToPractise + 2) * rightSideOperand
        answersArray = [correctAnswer, correctAnswer + 2, correctAnswer + 4, correctAnswer - 2]
        answersArray.shuffle()
    }
    
    func buttonTapped(_ number: Int) {
        chosenQuestionsNumber -= 1
        tappedButton = number
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! The correct answer is \(correctAnswer)"
        }
        if chosenQuestionsNumber == 0 {
            gameOver = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            showingScore = true
        }
    }
    
    func resetGame() {
        isNewGamePressed = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(chosenQuestionsNumber: .constant(0), chosenNumberToPractise: .constant(0))
    }
}
