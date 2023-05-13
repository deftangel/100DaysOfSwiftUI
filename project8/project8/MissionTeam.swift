//
//  MissionTeam.swift
//  project8
//
//  Created by Chris Hunter-Brown on 13/05/2023.
//

import Foundation
import SwiftUI

struct MissionTeam: View {
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
                                .foregroundColor(.white)
                                .font(.headline)
                            Text(crewMember.role)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
        }
    }
}

struct MissionTeam_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        let crewMembers = astronauts.values.map {
            return MissionView.CrewMember(role: "Astronaut", astronaut: $0)
        }
        
        MissionTeam(crewMembers: crewMembers)
            .preferredColorScheme(.dark)
    }
}
