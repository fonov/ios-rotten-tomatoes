//
//  Reviews.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 20.02.23.
//

import SwiftUI

struct Reviews: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(sortDescriptors: [
    //    SortDescriptor(\.date)
  ]) var filmReviews: FetchedResults<FilmReview>

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
    Reviews()
  }
}
