//
//  QuestionView.swift
//  Master Brainers
//
//  Created by Rayed Jawad on 11/17/24.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var triviaManager: TriviaManager
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 40) {
            HStack {
                // Back Button
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(Color("AccentColor"))
                        .font(.title)
                }
                
                // Title
                Text("Trivia Game")
                    .font(.headline)
                    .foregroundColor(Color("AccentColor"))
                
                Spacer()
                
                // Question Number
                Text("\(triviaManager.index + 1) of \(triviaManager.length)")
                    .foregroundColor(Color("AccentColor"))
                    .fontWeight(.heavy)
            }
            
            ProgressBar(progress: triviaManager.progress)
                .frame(height: 10)
                .padding(.vertical)

            VStack(alignment: .leading, spacing: 20) {
                Text(triviaManager.question)
                    .font(.system(size: 22))
                    .bold()
                    .foregroundColor(.black)
                    .lineLimit(nil)

                ForEach(triviaManager.answerChoices, id: \.id) { answer in
                    AnswerRow(answer: answer)
                        .environmentObject(triviaManager)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Button {
                triviaManager.goToNextQuestion()
            } label: {
                PrimaryButton(
                    text: "Next",
                    background: triviaManager.answerSelected ? Color("AccentColor") : Color.gray.opacity(0.5)
                )
            }
            .disabled(!triviaManager.answerSelected)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(red: 0.984, green: 0.929, blue: 0.847))
        .navigationBarHidden(true)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
            .environmentObject(TriviaManager())
    }
}
