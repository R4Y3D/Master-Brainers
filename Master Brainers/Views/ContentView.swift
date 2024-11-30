//
//  ContentView.swift
//  Master Brainers
//
//  Created by Rayed Jawad on 11/15/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var triviaManager = TriviaManager()
    @State private var selectedDifficulty: String? = nil
    @State private var numberOfQuestions: Int = 10 // Default number of questions
    
    let difficulties = ["Easy", "Medium", "Hard"]
    let categories = [
        (id: 9, name: "General Knowledge"),
        (id: 17, name: "Science & Nature"),
        (id: 18, name: "Computers"),
        (id: 23, name: "History")
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                VStack(spacing: 20) {
                    Text("Master Brainers")
                        .accentTitle()
                    
                    Text("Choose your settings!")
                        .foregroundColor(Color("AccentColor"))
                }
                
                HStack(spacing: 20) {
                    // Difficulty Picker
                    Picker("Difficulty", selection: $selectedDifficulty) {
                        Text("Any Difficulty").tag(String?.none)
                        ForEach(difficulties, id: \.self) { difficulty in
                            Text(difficulty).tag(String?.some(difficulty.lowercased()))
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    
                    // Number of Questions Stepper
                    HStack(spacing: 10) {
                        
                        HStack(spacing: 5) {
                            Stepper("", value: $numberOfQuestions, in: 1...50)
                                .labelsHidden()
                                .frame(width: 100) // Set a compact width for the Stepper
                            
                            Text("\(numberOfQuestions)")
                                .frame(width: 35) // Allow space for double-digit numbers
                                .font(.headline)
                                .foregroundColor(Color("AccentColor"))
                                .multilineTextAlignment(.center)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Category Buttons
                ForEach(categories, id: \.id) { category in
                    NavigationLink {
                        TriviaView()
                            .environmentObject(triviaManager)
                            .onAppear {
                                Task {
                                    await triviaManager.fetchTrivia(
                                        category: category.id,
                                        difficulty: selectedDifficulty,
                                        amount: numberOfQuestions
                                    )
                                }
                            }
                    } label: {
                        PrimaryButton(text: category.name)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color(red: 0.984, green: 0.929, blue: 0.847))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
