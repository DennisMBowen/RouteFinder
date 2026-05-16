//
//  ContentView.swift
//  RouteFinder
//
//  Created by Dennis Bowen on 5/14/26.
//

import SwiftUI


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
                        try await findRoute(
                            originLat: originLat,
                            originLon: originLon,
                            destinationLat: destinationLat,
                            destinationLon: destinationLon,
                            transitOption: selectedTransit.rawValue,
                            optimizationOption: selectedOptimitzation.rawValue
                        )
                    } catch RequestError.invalidURL {
                        print("Invalid URL")
                    } catch RequestError.invalidResponse {
                        print("Invalid response")
                    } catch RequestError.invalidData {
                        print("Invalid data")
                    } catch {
                        print("Errors encountered")
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
    
    func findRoute(
        originLat: Double,
        originLon: Double,
        destinationLat: Double,
        destinationLon: Double,
        transitOption: String,
        optimizationOption: String
    ) async throws -> () {
//        print(originLat)
//        print(originLon)
//        print(destinationLat)
//        print(destinationLon)
//        print(transitOption)
//        print(optimizationOption)
        
        
//        let endpoint = "http://127.0.0.1:5000/find-nearest-dog-park?q=\(addressNum)%20\(street)%20\(city)%20\(state)%20\(zip)"
        
//        let endpoint = "http://classwork.engr.oregonstate.edu:45533/find-route?origin_lat=44.5545673&origin_lon=-123.2845478&destination_lat=44.5642592&destination_lon=-123.2754931&transit=driving&optimization=time
        let endpoint = "http://127.0.0.1:5000/find-route?origin_lat=\(originLat)&origin_lon=\(originLon)&destination_lat=\(destinationLat)&destination_lon=\(destinationLon)&transit_mode=\(transitOption)&optimization_mode=\(optimizationOption)"
        
        print(endpoint)
        
        guard let url = URL(string: endpoint) else {
            throw RequestError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw RequestError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let routeResult = try decoder.decode(Route.self, from: data)
            print(routeResult.route_distance_m)
            print(routeResult.route_duration_sec)
            return
        } catch {
            throw RequestError.invalidData
        }
    }
}

struct Route: Codable {
    let route_distance_m: String
    let route_duration_sec: String
    
}

enum RequestError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

#Preview {
    ContentView()
}
