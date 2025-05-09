//
//  HowManyQuestionsView.swift
//  Edutainment
//
//  Created by Seah Park on 5/9/25.
//

import SwiftUI

struct HowManyQuestionsView: View {
    let questions: [Int] = [5, 10, 20]
    
    var body: some View {
        NavigationStack {
            Text("How many questions you want?").font(.largeTitle)
            
            VStack {
                ForEach(questions, id: \.self) { question in
                    NavigationLink(destination: QuestionsView()){
                        Button("\(question)"){}.buttonStyle()
                    }
                }
            }.padding()
        }
    }
}

#Preview {
    HowManyQuestionsView()
}
