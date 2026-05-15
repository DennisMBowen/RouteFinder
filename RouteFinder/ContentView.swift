//
//  ContentView.swift
//  RouteFinder
//
//  Created by Dennis Bowen on 5/14/26.
//

import SwiftUI


enum TransitOption: String, CaseIterable, Identifiable {
    case driving
    case walking
    case cycling
    
    var id: String { self.rawValue }
    
}

enum OptimizationOption: String, CaseIterable, Identifiable {
    case time
    case distance
    
    var id: String { self.rawValue }
}

struct ContentView: View {
    
//    @State var originLat: Float
//    @State var originLon: Float
//    @State var destinationLat: Float
//    @State var destinationLon: Float
    
    @State var selectedTransit: TransitOption = .driving
    @State var selectedOptimitzation: OptimizationOption = .time

    
    
    var body: some View {
        VStack {
            Text("Transit Option: ")
            Picker("Transit Option", selection: $selectedTransit) {
                ForEach(TransitOption.allCases) { transitOption in
                    Text(transitOption.rawValue.capitalized).tag(transitOption)
                }
            }
            Text("Optimization Mode:")
            Picker("Optimization Mode", selection: $selectedOptimitzation) {
                ForEach(OptimizationOption.allCases) {optimizationOption in
                    Text(optimizationOption.rawValue.capitalized).tag(optimizationOption)
                }
            }


        }
        .padding()
    }
}

struct Route: Codable {
    let routeDistanceM: Int
    let routeDuractionSec: Int
}

#Preview {
    ContentView()
}
