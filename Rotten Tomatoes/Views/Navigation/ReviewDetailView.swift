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

  @Environment(\.managedObjectContext) var moc
  @Environment(\.dismiss) var dismis
  @State private var showingDeleteAlert = false

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
    .alert("Delete the film review?", isPresented: $showingDeleteAlert) {
      Button("Delete", role: .destructive, action: deliteReview)
      Button("Cancel", role: .cancel) {}
    } message: {
      Text("Are you sure?")
    }
    .navigationTitle(filmReview.title ?? "Unknown film")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      Button {
        showingDeleteAlert.toggle()
      } label: {
        Label("Delete the film review", systemImage: "trash")
      }
    }
  }

  func deliteReview() {
    moc.delete(filmReview)

    try? moc.save()

    dismis()
  }
}
