//
//  ContentView.swift
//  iSplit
//
//  Created by M. A. Alim Mukul on 20.09.22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var numberOfPeople = 2
    
    @State private var amount = 0.0
    
    @State private var tipPercentage = 20
    
    @FocusState private var isFocused: Bool
    
    let tips = [0,10,15,20,25,30]
    
    let students = [1,2,3]
    
    // MARK: Calculation
    
    var totalPerPerson:Double {
        
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentage)
        
        let tipValueFractional = amount / 100 * tipSelection
        let grandTotal = tipValueFractional + amount
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Form {
                    
                    Section {
                        
                        // MARK: Amount Text Field
                        
                        TextField("Amount: ", value: $amount, format: .currency(code: Locale.current.currencyCode ?? "EUR"))
                            .keyboardType(.decimalPad)
                            .focused($isFocused)
                        
                        // MARK: Number of People [picker]
                        
                        Picker("Number of People:", selection: $numberOfPeople) {
                            
                            ForEach(1..<101, id: \.self) {
                                
                                Text("\($0) people")
                            }
                        }
                    }
                    
                    Section {
                        
                        // MARK: Tips percentage
                        
                        Picker("", selection: $tipPercentage, content: {
                            
                            ForEach(tips, id:\.self) {
                                
                                Text($0, format: .percent)
                            }
                        })
                        .pickerStyle(.segmented)
                    } header: {
                        Text("How much tip do you want to leave?")
                    }
                    
                    Text("Amount per head: $ \(totalPerPerson)")
                        .font(.title2)
                        .bold()
                }
                .navigationTitle("iSplit")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button("Done") {
                            isFocused = false
                        }
                    }
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
