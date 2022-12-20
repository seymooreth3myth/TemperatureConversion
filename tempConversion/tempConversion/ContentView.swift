//
//  ContentView.swift
//  tempConversion
//
//  Created by Fábio Carlos de Souza on 19/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var temperature = "C"
    @State private var temperatureFrom = "C"
    @State private var temperatureValue = 0.0
    
    @FocusState private var tempFocused: Bool
    let temperatureOptions = ["C", "F"]
    
    var converterTemperature: Double {
         var newTemp = 0.0
        
        switch temperatureFrom {
        case "C":
            if(temperature == "F") {
               newTemp =  (temperatureValue * 1.8) + 32.0
            } else {
                newTemp = temperatureValue
            }
        case "F":
            if(temperature == "C") {
                newTemp = (temperatureValue - 32.0) / 1.8
            } else {
                newTemp = temperatureValue
            }
        default:
            newTemp = temperatureValue
        }
        
        return newTemp
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Temperaturies", selection: $temperatureFrom) {
                        ForEach(temperatureOptions, id: \.self) {
                            Text(($0))
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("CONVERT from")
                }
                
                Section {
                    TextField("Temperature", value: $temperatureValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($tempFocused)
                } header: {
                    Text("Temperature")
                }
                
                Section {
                    Picker("Temperaturies", selection: $temperature) {
                        ForEach(temperatureOptions, id: \.self) {
                            Text(($0))
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("CONVERT TO")
                }
                
                Section {
                    Text(converterTemperature, format: .number)
                }
            }
        }
        .navigationTitle("Temperature")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    tempFocused = false
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
