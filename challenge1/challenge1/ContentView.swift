//
//  ContentView.swift
//  Challenge 1
//
//  Created by Chris Hunter-Brown on 17/07/2021.
//

import SwiftUI

struct ContentView: View {
    
    enum Unit: String, CaseIterable, Identifiable {
        case m = "m"
        case km = "km"
        case ft = "ft"
        case yd = "yd"
        case mi = "mi"
        
        var id: Unit { self }
        
        var unitLength: UnitLength {
            switch self {
            case .m:
                return UnitLength.meters
            case .km:
                return UnitLength.kilometers
            case .ft:
                return UnitLength.feet
            case .yd:
                return UnitLength.yards
            case .mi:
                return UnitLength.miles
            }
        }
    }
    
    @State private var distance = 0
    @State private var inputUnits = Unit.m
    @State private var outputUnits = Unit.km
    
    var convertedDistance: String {
        var measurement = Measurement(value: Double(distance), unit: inputUnits.unitLength)
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 2
        measurement.convert(to: outputUnits.unitLength)
        let newMeasurement = measurement.converted(to: outputUnits.unitLength)
        return newMeasurement.description
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Distance", value: $distance, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                Section(header:Text("Units to convert from")) {
                    Picker("Units in", selection: $inputUnits) {
                        ForEach(Unit.allCases, content: { unit in
                            Text(unit.rawValue)
                        })
                    }.pickerStyle(SegmentedPickerStyle())
                    .tag("Units in")
                }
                
                Section(header:Text("Units to convert from")) {
                    Picker("Units out", selection: $outputUnits) {
                        ForEach(Unit.allCases, content: { unit in
                            Text(unit.rawValue)
                        })
                    }.pickerStyle(SegmentedPickerStyle())
                    .tag("Units out")
                }
                
                Section(header:Text("Converted distance")) {
                    Text("\(convertedDistance)")
                }
                
            }.navigationTitle("Distance converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
