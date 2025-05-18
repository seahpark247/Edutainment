//
//  QuestionsView.swift
//  Edutainment
//
//  Created by Seah Park on 5/9/25.
//

import SwiftUI

struct QuestionsView: View {
    @EnvironmentObject var question: Question
    @State private var score = 0
    @State private var showAlert: Bool = false
    @State private var content: String = ""
    @State private var played = 0
    @State private var index = 0
    @State private var input = ""
    @State private var wrongHistory: [String] = []
    @Binding var path: NavigationPath
    
    var body: some View {
        ZStack {
            Text("").frame(maxWidth: .infinity, maxHeight: .infinity).background(.blue.gradient)
            
            VStack {
                VStack {
                    Text("What is \(question.multipleTable) x \(question.question[index]) ?").font(.largeTitle.bold())
                    
                    TextField("Input your number", text: $input)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .background(.white)
                        .cornerRadius(20)
                        .padding(.bottom, 10)
                    
                    Button { answerCheck() } label: {
                        Text("Go!").buttonStyle()
                    }
                    
                    Button("Reset Game") {
                        path = NavigationPath()
                    }

                }
                .padding()
                .background(.regularMaterial)
                .cornerRadius(20)
                .padding()
                
                HStack {
                    Text("score: \(score)")
                    Spacer()
                    Text("played: \(played) / \(question.question.count)")
                }
                .padding([.leading, .bottom, .trailing])
                .font(.title)
                .foregroundColor(.white)
                
                ForEach(wrongHistory, id: \.self) { item in
                    Text(item)
                }

            }
        }.alert(played == question.questionCounts ? "Play again" : "Enter your answer", isPresented: $showAlert) {
            Button("OK") {
                if played == question.questionCounts {
                    resetGame()
                }
            }
        } message: {
            if played == question.questionCounts {
                Text("Your score is: \(score), played: \(played)/\(question.questionCounts)")
            }
        }
    }
    
    func answerCheck() {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let number = Int(trimmed) else {
            showAlert = true
            return
        }

        if Int(input) == (question.multipleTable * question.question[index]) {
            score += 1
        } else {
            wrongHistory.append("\(question.multipleTable) * \(question.question[index]) = \(question.multipleTable * question.question[index])")
        }
        played += 1
        input = ""
        
        if played < question.questionCounts {
            index += 1
        } else {
            showAlert = true
        }
    }
    
    func resetGame() {
        path = NavigationPath()
    }
}

#Preview {
    QuestionsView(path: .constant(NavigationPath())).environmentObject(Question())
}
