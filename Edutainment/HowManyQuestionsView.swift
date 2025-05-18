//
//  HowManyQuestionsView.swift
//  Edutainment
//
//  Created by Seah Park on 5/9/25.
//

import SwiftUI

struct HowManyQuestionsView: View {
    @EnvironmentObject var question: Question
    let questions: [Int] = [5, 10, 20]
    @Binding var path: NavigationPath

    var body: some View {
        VStack {
            Text("How many questions do you want?")
                .font(.largeTitle)
                .padding()

            VStack {
                ForEach(questions, id: \.self) { num in
                    Button("\(num)") {
                        question.questionCounts = num
                        question.question = (0..<num).map { _ in Int.random(in: 2...9) }
                        question.answer = question.question.map { $0 * question.multipleTable }

                        path.append("questions")
                    }
                    .buttonStyle()
                }
            }
            .padding()
        }
    }
}

#Preview {
    HowManyQuestionsView(path: .constant(NavigationPath())).environmentObject(Question())
}
