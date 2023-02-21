//
//  Reviews.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 20.02.23.
//

import SwiftUI

struct ReviewsSidebarView: View {
  @Environment(\.managedObjectContext) var moc

  @State private var showingAddScreen = false
  @Binding var selection: FilmReview.ID?

  let filmReviews: FetchedResults<FilmReview>

  var body: some View {
    VStack {
      List(selection: $selection) {
        ForEach(filmReviews) { filmReview in
          NavigationLink(value: filmReview.id) {
            HStack {
              EmojiRatingView(rating: filmReview.rating)
                .font(.title)
              VStack(alignment: .leading) {
                Text(filmReview.title ?? "Unknown Title")
                  .font(.headline)
                Text("\(filmReview.director ?? "Unknown Director") | \(filmReview.genre?.capitalized ?? "Unknown Genre")")
                  .foregroundColor(.secondary)
              }
            }
          }
        }
        .onDelete(perform: delete)
      }
    }
    .navigationTitle("Rotten Tomatoes")
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        EditButton()
      }
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

// struct Reviews_Previews: PreviewProvider {
//  static var previews: some View {
//    ReviewsSidebar(selection: <#T##Binding<FilmReview.ID?>#>, filmReviews: <#T##FetchedResults<FilmReview>#>)
//  }
// }
