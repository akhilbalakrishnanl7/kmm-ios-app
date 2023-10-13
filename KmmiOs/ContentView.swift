//
//  ContentView.swift
//  KmmiOs
//
//  Created by Akhil.b on 13/10/23.
//

import SwiftUI
import shared

struct ContentView: View {
    var body: some View {
        let greet = Greeting()
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(greet.greet())
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
