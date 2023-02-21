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

  let filmReview: FilmReview?

  init() {
    filmReview = nil
  }

  init(filmReview: FilmReview) {
    self.filmReview = filmReview
  }

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
          Button(filmReview != nil ? "Update" : "Save") {
            saveFilmReview()
          }
        }
      }
    }
    .navigationTitle("Add a film review")
    .onAppear {
      if let filmReview {
        title = filmReview.title ?? ""
        director = filmReview.director ?? ""
        genre = Genres(rawValue: filmReview.genre ?? "") ?? .action
        review = filmReview.review ?? ""
        rating = Int(filmReview.rating)
      }
    }
  }

  func saveFilmReview() {
    let filmReview: FilmReview

    if let _filmReview = self.filmReview {
      filmReview = _filmReview
    } else {
      filmReview = FilmReview(context: moc)

      filmReview.id = UUID()
      filmReview.dateCreate = Date()
    }

    filmReview.title = title
    filmReview.director = director
    filmReview.genre = genre.rawValue
    filmReview.review = review
    filmReview.rating = Int16(rating)

    try? moc.save()

    dismiss()
  }
}

//struct AddReview_Previews: PreviewProvider {
//  static var previews: some View {
//    AddReviewView()
//  }
//}
