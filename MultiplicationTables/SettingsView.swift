//
//  SettingsView.swift
//  MultiplicationTables
//
//  Created by Vitali Martsinovich on 2023-07-28.
//

import SwiftUI

struct SettingsView: View {
    @State private var isGameStarted = false
    @State private var showAlert = false
    @State var chosenQuestionsNumber = 0
    @State var chosenNumberToPractise = 0
    @State private var numberToPracticeLabelText = "Not selected"
    
    
    let numberOfquestions = [5, 10, 15]
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.black, .blue, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack {
                    Text("Multiplication Table")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Spacer()
                    VStack(spacing: 20) {
                        
                        Section(header: Text("Select number to practice").foregroundColor(.white)) {
                            Menu {
                                Picker("", selection: $chosenNumberToPractise) {
                                    ForEach(2..<12) {
                                        Text("\($0)")
                                    }
                                }
                            } label: {
                                Text("\(chosenNumberToPractise == 0 ? "Not selected" : "\(chosenNumberToPractise + 2)")")
                            }
                        }
                        .foregroundColor(.yellow)
                        Section(header: Text("Select number of questions").foregroundColor(.white)) {
                            Picker("", selection: $chosenQuestionsNumber) {
                                ForEach(numberOfquestions, id: \.self) {
                                    Text($0, format: .number)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    Spacer()
                }
            }
            .toolbar {
                Button("Start") {
                    //transition to game
                    if chosenQuestionsNumber != 0 && chosenNumberToPractise != 0 {
                        isGameStarted = true
                    } else {
                        showAlert = true
                    }
                }
                .buttonStyle(.bordered)
            }
            .alert("Choose number to practise and number of rounds", isPresented: $showAlert) {
                Button("Ok", role: .cancel) { }
            }
            .fullScreenCover(isPresented: $isGameStarted) {
                ContentView(chosenQuestionsNumber: $chosenQuestionsNumber, chosenNumberToPractise: $chosenNumberToPractise)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
