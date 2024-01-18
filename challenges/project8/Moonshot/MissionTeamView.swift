//
//  MissionTeam.swift
//  project8
//
//  Created by Chris Hunter-Brown on 13/05/2023.
//

import Foundation
import SwiftUI

struct MissionTeamView: View {
    let crewMembers: [MissionView.CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crewMembers, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        Image(crewMember.astronaut.id)
                            .resizable()
                            .frame(width: 104, height: 72)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .strokeBorder(.white, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(crewMember.astronaut.name)
                                .foregroundStyle(.white)
                                .font(.headline)
                            Text(crewMember.role)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
        }
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let crewMembers = astronauts.values.map {
        return MissionView.CrewMember(role: "Astronaut", astronaut: $0)
    }
    return MissionTeamView(crewMembers: crewMembers)
            .preferredColorScheme(.dark)
}
