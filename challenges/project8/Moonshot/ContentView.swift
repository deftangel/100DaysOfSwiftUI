//
//  ContentView.swift
//  project8
//
//  Created by Chris Hunter-Brown on 29/04/2023.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showAsList = true

    var body: some View {
        NavigationStack {
            Group {
                if showAsList {
                    ListView(missions: missions, astronauts: astronauts)
                } else {
                    GridView(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                    showAsList.toggle()
                } label: {
                    Image(systemName: showAsList ? "square.grid.2x2" : "list.bullet")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct ListView: View {
    
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
            List(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack() {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .padding()
                        
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.title2)
                                .foregroundColor(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.5))
                        }
                    }
                }
                .listRowBackground(Color.darkBackground)
            }
            .listStyle(.plain)
        }
}

struct GridView: View {
    
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()

                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                        )
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

#Preview {
    return ContentView()
}
