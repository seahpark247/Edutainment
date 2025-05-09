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
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
            .background(.blue.opacity(0.2))
            .cornerRadius(10)
    }
}

extension View {
    func buttonStyle() -> some View {
        self.modifier(ButtonStyle())
    }
}

struct ContentView: View {
    @State private var selectedTab: Int? = 0
    
    var body: some View {
        NavigationStack {
            Spacer()
            Text("Which multiplication table would you like to learn?").font(.largeTitle)
            
            VStack {
                ForEach(2..<13){ i in
                    NavigationLink(destination: HowManyQuestionsView()) {
                        Button("\(i)") {
                            selectTab(i)
                        }.buttonStyle()
                    }
                }
            }.padding()
        }
    }
    
    func selectTab(_ index: Int) {
        selectedTab = index
    }
    
    
}

#Preview {
    ContentView()
}
