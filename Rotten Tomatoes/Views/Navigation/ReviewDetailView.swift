//
//  DetailReviewView.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 21.02.23.
//

import CoreData
import SwiftUI

struct ReviewDetailView: View {
  var selectedReview: FilmReview.ID

  @Environment(\.managedObjectContext) var moc
  @Environment(\.dismiss) var dismis
  @State private var showingDeleteAlert = false
  @State private var showingAddScreen = false

  @FetchRequest(sortDescriptors: [
    SortDescriptor(\.dateCreate, order: .reverse),
  ]) var filmReviews: FetchedResults<FilmReview>

  var filmReview: FilmReview {
    filmReviews.first(where: { $0.id == selectedReview }) ?? filmReviews[0]
  }

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

      if let dateCreate = filmReview.dateCreate {
        HStack {
          Text("Created at")
          Text(dateCreate, format: .dateTime)
        }
      }

      Text(filmReview.review ?? "No review")
        .padding()

      RatingView(rating: .constant(Int(filmReview.rating)))
        .padding()
    }
    .alert("Delete the film review?", isPresented: $showingDeleteAlert) {
      Button("Delete", role: .destructive, action: deleteReview)
      Button("Cancel", role: .cancel) {}
    } message: {
      Text("Are you sure?")
    }
    .navigationTitle(filmReview.title ?? "Unknown film")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          showingDeleteAlert.toggle()
        } label: {
          Label("Delete the film review", systemImage: "trash")
        }
      }
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          showingAddScreen.toggle()
        } label: {
          Text("Edit")
        }
        .sheet(isPresented: $showingAddScreen) {
          AddReviewView(filmReview: filmReview)
        }
      }
    }
  }

  func deleteReview() {
    moc.delete(filmReview)

    try? moc.save()

    dismis()
  }
}
