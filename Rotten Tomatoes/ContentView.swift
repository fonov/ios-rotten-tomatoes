//
//  ContentView.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 20.02.23.
//

import SwiftUI

struct ContentView: View {
  @State private var isPresent = false

  var body: some View {
    NavigationSplitView {
      Reviews()
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button {
              isPresent = true
            } label: {
              Label("Plus", systemImage: "plus")
            }
          }
        }
        .sheet(isPresented: $isPresent) {
          AddReview()
        }
    } detail: {}
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
