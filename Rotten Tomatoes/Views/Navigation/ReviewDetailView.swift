//
//  DetailReviewView.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 21.02.23.
//

import CoreData
import SwiftUI

struct ReviewDetailView: View {
  var filmReview: FilmReview

  var body: some View {
    let genre = Genres(rawValue: filmReview.genre ?? "") ?? .action

    ScrollView {
      ZStack(alignment: .bottomTrailing) {
        genre.getImage()
          .resizable()
          .scaledToFit()

        Text(genre.rawValue.uppercased())
          .font(.caption)
          .fontWeight(.black)
          .padding(8)
          .foregroundColor(.white)
          .background {
            Color.black.opacity(0.75)
          }
          .clipShape(Capsule())
          .offset(x: -5, y: -5)
      }

      Text(filmReview.director ?? "Unknown Director")
        .font(.title)
        .foregroundColor(.secondary)

      Text(filmReview.review ?? "No review")
        .padding()

      RatingView(rating: .constant(Int(filmReview.rating)))
        .padding()
    }
    .navigationTitle(filmReview.title ?? "Unknown film")
    .navigationBarTitleDisplayMode(.inline)
  }
}
