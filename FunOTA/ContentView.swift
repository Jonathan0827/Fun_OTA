//
//  ContentView.swift
//  FunOTA
//
//  Created by 임준협 on 1/5/24.
//

import SwiftUI
import LocalConsole

let consoleManager = LCManager.shared
struct ContentView: View {
    var body: some View {
        VStack {
            Button(action: {
                installApp(true)
            }, label: {
                Text("Install latest version of Fun")
            })
            Button(action: {
                installApp(false)
            }, label: {
                Text("Install latest version of FunOTA")
            })
        }
        .padding()
        .onAppear {
            consoleManager.isVisible = true
        }
    }
}
