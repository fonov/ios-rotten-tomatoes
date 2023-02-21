//
//  Reviews.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 20.02.23.
//

import SwiftUI

struct ReviewsView: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(sortDescriptors: [
    //    SortDescriptor(\.date)
  ]) var filmReviews: FetchedResults<FilmReview>

  @State private var showingAddScreen = false

  var body: some View {
    VStack {
      List {
        ForEach(filmReviews) { filmReview in
          HStack {
            Text(String(filmReview.rating))
            Text(filmReview.title ?? "")
          }
        }
        .onDelete(perform: delete)
      }
    }
    .navigationTitle("Rotten Tomatoes")
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          showingAddScreen.toggle()
        } label: {
          Label("Plus", systemImage: "plus")
        }
      }
    }
    .sheet(isPresented: $showingAddScreen) {
      AddReviewView()
    }
  }

  func delete(at offset: IndexSet) {
    for index in offset {
      let filmReview = filmReviews[index]
      moc.delete(filmReview)
    }

    try? moc.save()
  }
}

struct Reviews_Previews: PreviewProvider {
  static var previews: some View {
    ReviewsView()
  }
}
