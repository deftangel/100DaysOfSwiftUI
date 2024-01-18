//
//  ContentView.swift
//  Navigation
//
//  Created by Chris Hunter-Brown on 16/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var title = "SwiftUI"

    var body: some View {
        NavigationStack {
            Text("Hello, world!")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DetailView: View {
    var number: Int
    @Binding var path: [Int]
    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Home") {
                    path.removeAll()
                }
            }
    }
}

#Preview {
    ContentView()
}
