//
//  ContentView.swift
//  Stretch+Paws
//
//  Created by Jessica Perelman on 11/26/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination:
                    ShowView()) {
                    Text("Downward Dog")
                }

            }.listStyle(.grouped)
                .navigationBarTitle("Stretch + Paws")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
