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

    let numberOfquestions = [5, 10, 15]
    
    var body: some View {
        NavigationStack {
                    Form {
                        Section {
                            Picker("Choose number to practice", selection: $chosenNumberToPractise) {
                                ForEach(2..<12) {
                                    Text("\($0)")
                                }
                            }
                        }
                        Section {
                            Picker("Choose number of questions", selection: $chosenQuestionsNumber) {
                                ForEach(numberOfquestions, id: \.self) {
                                    Text($0, format: .number)
                                }
                            }
                            .pickerStyle(.segmented)
                        } header: {
                            Text("Choose number of questions")
                        }
                    }
            .navigationTitle("Multiplication Tables")
            .toolbar {
                Button("Start") {
                    //transition to game
                    if chosenQuestionsNumber != 0 && chosenNumberToPractise != 0 {
                        isGameStarted = true
                    } else {
                        showAlert = true
                    }
                }
            }
                .alert("Choose number to practise and number of rounds", isPresented: $showAlert) {
                    Button("Ok", role: .cancel) { }
                }
        }
        .fullScreenCover(isPresented: $isGameStarted) {
            ContentView(chosenQuestionsNumber: $chosenQuestionsNumber, chosenNumberToPractise: $chosenNumberToPractise)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
