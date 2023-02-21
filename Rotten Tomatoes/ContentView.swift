//
//  ContentView.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 20.02.23.
//

import SwiftUI

struct ContentView: View {
  @FetchRequest(sortDescriptors: [
    SortDescriptor(\.dateCreate, order: .reverse)
  ]) var filmReviews: FetchedResults<FilmReview>

  @State private var selectedReview: FilmReview.ID?

  var body: some View {
    NavigationSplitView {
      ReviewsSidebar(selection: $selectedReview, filmReviews: filmReviews)
    } detail: {
      if let selectedReview, let filmReview = filmReviews.first(where: { filmReview in
        filmReview.id == selectedReview
      }) {
        ReviewDetailView(filmReview: filmReview)
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
