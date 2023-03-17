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
      if selectedReview != nil {
        ReviewDetailView(selectedReview: $selectedReview)
      } else {
        Text("Select a film review")
          .font(.title)
          .foregroundColor(.secondary)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static let moc = DataController().container.viewContext

  static var previews: some View {
    createFilmReviewSamples(moc)

    return ContentView()
      .environment(\.managedObjectContext, moc)
  }
}
