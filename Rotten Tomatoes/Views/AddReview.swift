//
//  AddReview.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 20.02.23.
//

import CoreData
import SwiftUI

struct AddReview: View {
  @Environment(\.managedObjectContext) var moc
  @Environment(\.dismiss) var dismiss

  @State private var title = ""
  @State private var director = ""
  @State private var genre: Genres = .unknown
  @State private var review = ""
  @State private var rating: Rating = .unknown

  var body: some View {
    VStack {
      Form {
        Section {
          TextField("Title", text: $title)
          TextField("Direction", text: $director)
        }
        Section {
          Picker("Genre", selection: $genre) {
            ForEach(Genres.allCases, id: \.self) { genre in
              Text(genre.rawValue)
            }
          }
        }
        Section {
          TextEditor(text: $review)
          Picker("Rating", selection: $rating) {
            ForEach(Rating.allCases, id: \.self) { rate in
              Label("\(rate.rawValue)", systemImage: "apple.logo")
            }
          }
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
    filmReview.rating = rating.rawValue
    filmReview.dateCreate = Date()

    try? moc.save()

    dismiss()
  }
}

struct AddReview_Previews: PreviewProvider {
  static var previews: some View {
    AddReview()
  }
}
