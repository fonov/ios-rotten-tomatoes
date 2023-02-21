//
//  AddReview.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 20.02.23.
//

import CoreData
import SwiftUI

struct AddReviewView: View {
  @Environment(\.managedObjectContext) var moc
  @Environment(\.dismiss) var dismiss

  @State private var title = ""
  @State private var director = ""
  @State private var genre: Genres = .action
  @State private var review = ""
  @State private var rating: Int = 1

  var body: some View {
    VStack {
      Form {
        Section {
          TextField("Title", text: $title)
          TextField("Direction", text: $director)

          Picker("Genre", selection: $genre) {
            ForEach(Genres.allCases, id: \.self) { genre in
              Text(genre.rawValue)
            }
          }
        }
        Section {
          TextEditor(text: $review)
          RatingView(rating: $rating)
            .frame(height: 30)
        } header: {
          Text("Write a review")
        }
        Section {
          Button("Save") {
            saveFilmReview()
          }
        }
      }
    }
    .navigationTitle("Add a film review")
  }

  func saveFilmReview() {
    let filmReview = FilmReview(context: moc)
    filmReview.id = UUID()
    filmReview.title = title
    filmReview.director = director
    filmReview.genre = genre.rawValue
    filmReview.review = review
    filmReview.rating = Int16(rating)
    filmReview.dateCreate = Date()

    try? moc.save()

    dismiss()
  }
}

struct AddReview_Previews: PreviewProvider {
  static var previews: some View {
    AddReviewView()
  }
}
