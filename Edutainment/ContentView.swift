//
//  ContentView.swift
//  Edutainment
//
//  Created by Seah Park on 5/9/25.
//

import SwiftUI

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .padding(4)
            .padding(.horizontal, 4)
            .background(.blue.opacity(0.2))
            .cornerRadius(10)
    }
}

extension View {
    func buttonStyle() -> some View {
        self.modifier(ButtonStyle())
    }
}

class Question: ObservableObject {
    @Published var multipleTable: Int = 2
    @Published var questionCounts: Int = 5
    @Published var question: [Int] = [2,3,4,5,6]
    @Published var answer: [Int] = [4,6,8,10,12]
}

struct ContentView: View {
    @StateObject var question = Question()
    @State private var path = NavigationPath()
    let layout = [
        GridItem(.adaptive(minimum: 70))
    ]
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Spacer()
                Text("Which multiplication table would you like to learn?")
                    .font(.largeTitle)
                
                LazyVGrid(columns: layout, spacing: 16) {
                    ForEach(2..<13) { i in
                        Button("\(i)") {
                            question.multipleTable = i
                            path.append("howMany")
                        }
                        .buttonStyle()
                    }
                }
                .padding()
                Spacer()
            }
            .navigationDestination(for: String.self) { value in
                switch value {
                case "howMany":
                    HowManyQuestionsView(path: $path).environmentObject(question)
                case "questions":
                    QuestionsView(path: $path).environmentObject(question)
                default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
