//
//  AnswerButton.swift
//  Master Brainers
//
//  Created by Rayed Jawad on 11/29/24.
//

import SwiftUI

struct AnswerButton: View {
    var answer: Answer
    
    var body: some View {
        Text(answer.text)
            .padding()
            .frame(maxWidth: .infinity)
            .background(answer.isCorrect ? Color.green : Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.horizontal)
    }
}
