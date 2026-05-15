//
//  ContentView.swift
//  RouteFinder
//
//  Created by Dennis Bowen on 5/14/26.
//

import SwiftUI


struct Route: Codable {
    let routeDistanceM: Int
    let routeDuractionSec: Int
}


enum TransitOption: String, CaseIterable, Identifiable {
    case driving = "driving"
    case walking = "walking"
    case cycling = "cycling"
    
    var id: String { self.rawValue }
    
}

enum OptimizationOption: String, CaseIterable, Identifiable {
    case time = "time"
    case distance = "distance"
    
    var id: String { self.rawValue }
}

struct ContentView: View {
    
    @State var originLat: Double = 0.0
    @State var originLon: Double = 0.0
    @State var destinationLat: Double = 0.0
    @State var destinationLon: Double =  0.0
    
    @State var selectedTransit: TransitOption = .driving
    @State var selectedOptimitzation: OptimizationOption = .time

    
    
    var body: some View {
        VStack {
            
            Text("Find a Route")
                .font(.largeTitle)
            
            Spacer()
            
            VStack() {
                Text("Origin Latitude: ")
                TextField("Origin Latitude", value: $originLat, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    
                    
            }
            
            VStack {
                Text("Origin Longitude: ")
                TextField("Origin Longitude", value: $originLon, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
            }
            
            VStack() {
                Text("Destination Latitude: ")
                TextField("Destination Latitude", value: $destinationLat, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
            }
            
            VStack {
                Text("Destination Longitude: ")
                TextField("Destination Longitude", value: $destinationLon, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
            }
            
            HStack {
                Text("Transit Option: ")
                Spacer()
                Picker("Transit Option", selection: $selectedTransit) {
                    ForEach(TransitOption.allCases) { transitOption in
                        Text(transitOption.rawValue.capitalized).tag(transitOption)
                    }
                }
                .padding(.horizontal)
                .frame(height: 50)
                .frame(maxWidth: 200)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            }

            HStack {
                Text("Optimization Mode:")
                Spacer()
                Picker("Optimization Mode", selection: $selectedOptimitzation) {
                    ForEach(OptimizationOption.allCases) {optimizationOption in
                        Text(optimizationOption.rawValue.capitalized).tag(optimizationOption)
                    }
                    
                }
                .padding(.horizontal)
                .frame(height: 50)
                .frame(maxWidth: 200)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            }
            
            Spacer()
            
            Button("Find Route") {
                Task {
                    do {
                        try await findRoute()
                    } catch {
                        print("Unsuccessful")
                    }
                }
            }
            .foregroundColor(Color.white)
            .font(.headline)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .padding()
        }
        .padding()
    }
    
    func findRoute() async throws -> () {
        print($originLat)
        print($originLon)
        print($destinationLat)
        print($destinationLon)
        print($selectedTransit)
        print($selectedOptimitzation)
        
        return
    }
}

#Preview {
    ContentView()
}
