//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Shomil Singh on 30/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button("Hello World")
            {}
            Form{
                Section{
                    Text("Enter Your name")
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
