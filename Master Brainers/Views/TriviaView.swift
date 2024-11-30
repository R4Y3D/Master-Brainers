//
//  TriviaView.swift
//  Master Brainers
//
//  Created by Rayed Jawad on 11/17/24.
//

import SwiftUI

struct TriviaView: View {
    @EnvironmentObject var triviaManager: TriviaManager
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            if triviaManager.reachedEnd {
                VStack(spacing: 20) {
                    Text("Trivia Game")
                        .accentTitle()

                    Text("Congratulations, you completed the game! 🥳")
                        .multilineTextAlignment(.center)
                        .font(.title2)
                    
                    Text("You scored \(triviaManager.score) out of \(triviaManager.length)")
                        .font(.headline)
                        .foregroundColor(Color("AccentColor"))

                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        PrimaryButton(text: "Back to Main Menu")
                    }
                }
                .foregroundColor(Color("AccentColor"))
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 0.984, green: 0.929, blue: 0.847))
            } else {
                QuestionView()
                    .environmentObject(triviaManager)
            }
        }
    }
}

struct TriviaView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaView()
            .environmentObject(TriviaManager())
    }
}
