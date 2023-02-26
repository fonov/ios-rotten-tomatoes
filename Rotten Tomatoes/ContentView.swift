//
//  ContentView.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 20.02.23.
//

import CoreData
import SwiftUI

struct ContentView: View {
  @State private var selectedReview: NSManagedObjectID?

  var body: some View {
    NavigationSplitView {
      ReviewsSidebarView(selection: $selectedReview)
    } detail: {
      if let selectedReview {
        ReviewDetailView(selectedReview: selectedReview)
      } else {
        Text("Select a film review")
          .font(.title)
          .foregroundColor(.secondary)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
