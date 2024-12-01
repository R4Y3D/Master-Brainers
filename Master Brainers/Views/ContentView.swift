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
    @State private var Brain:String = "Brain"
    
    let difficulties = ["Easy", "Medium", "Hard"]
    let categories = [
        (id: 9, name: "General Knowledge"),
        (id: 17, name: "Science & Nature"),
        (id: 18, name: "Computers"),
        (id: 23, name: "History"),
        (id: 26, name: "Celebrities"),
        (id: 20, name: "Mythology"),
        (id: 19, name: "Mathematics"),
        (id: 12, name: "Music")
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Title Section
                VStack(spacing: 10) {
                    Text("Master Brainers")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("AccentColor"))
                    
                    Text("Choose your settings!")
                        .font(.title2)
                        .foregroundColor(Color("AccentColor"))
                }
                
                // Difficulty Picker and Stepper Section
                VStack(spacing: 20) {
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
                            Stepper("", value: $numberOfQuestions, in: 1...50)
                                .labelsHidden()
                                .frame(width: 100) // Compact width for the Stepper
                            
                            Text("\(numberOfQuestions)")
                                .frame(width: 35) // Allow space for double-digit numbers
                                .font(.headline)
                                .foregroundColor(Color("AccentColor"))
                                .multilineTextAlignment(.center)
                        }
                    }
                }
                .padding(.horizontal)
                .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                .cornerRadius(10)
                .shadow(radius: 2)
                
                
                Spacer()
                //Image Holder
                Image(Brain)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                Spacer()
                let categoryColors: [Int: Color] = [
                                    9: Color.green,
                                    17: Color.red,
                                    18: Color.purple,
                                    23: Color.orange,
                                    26: Color.pink,
                                    20: Color.yellow
                                ]

                // 2x2 Grid for Categories
                LazyVGrid(
                    columns: [GridItem(.flexible()), GridItem(.flexible())],
                    spacing: 20
                ) {
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
                            PrimaryButton(text: category.name,
                                          background:categoryColors[category.id] ?? Color.blue

                            )
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.984, green: 0.929, blue: 0.847))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
