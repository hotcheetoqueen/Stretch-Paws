//
//  ShowView.swift
//  Stretch+Paws
//
//  Created by Jessica Perelman on 11/26/22.
//

import SwiftUI

struct ShowView: View {
    var body: some View {
        ZStack {
            Color("Secondary")
                .ignoresSafeArea()
            Text("Purrrfect!")
                .font(.title)
        }
    }
}

struct ShowView_Previews: PreviewProvider {
    static var previews: some View {
        ShowView()
    }
}
