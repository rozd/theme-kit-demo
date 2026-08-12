//
//  ContentView.swift
//  ThemeKitDemo
//
//  Created by Max Rozdobudko on 2/18/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.icon)
                Text("Hello, world!")
            }
            .padding()
            .background(in: RoundedRectangle(cornerRadius: 16))
            .foregroundStyle(.onSurface)
            .backgroundStyle(.surface.card)

    }
}

#Preview {
    ContentView()
}
