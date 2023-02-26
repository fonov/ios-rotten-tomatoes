//
//  DetailReviewView.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 21.02.23.
//

import CoreData
import SwiftUI

struct ReviewDetailView: View {
  var selectedReview: NSManagedObjectID

  @Environment(\.managedObjectContext) var moc
  @Environment(\.dismiss) var dismiss

  @State private var showingDeleteAlert = false
  @State private var showingAddScreen = false

  @FetchRequest var filmReviews: FetchedResults<FilmReview>

  @State private var isDeleteFilmReview = false
  @State private var commentText = ""

  init(selectedReview: NSManagedObjectID) {
    self.selectedReview = selectedReview

    _filmReviews = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "SELF == %@", selectedReview))
  }

  var filmReview: FilmReview {
    guard let filmReview = filmReviews.first else {
      fatalError("can't find film review")
    }

    return filmReview
  }

  var body: some View {
    let genre = Genres(rawValue: filmReview.wrappedGenre) ?? .action

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

      Text(filmReview.wrappedDirector)
        .font(.title)
        .foregroundColor(.secondary)

      if let dateCreate = filmReview.dateCreate {
        HStack {
          Text("Created at")
          Text(dateCreate, format: .dateTime)
        }
      }

      Text(filmReview.wrappedReview)
        .padding()

      RatingView(rating: .constant(Int(filmReview.rating)))
        .padding()

      VStack(alignment: .leading) {
        TextField("Leave comment", text: $commentText)
        Button("Add comment") {
          let comment = Comment(context: moc)
          comment.comment = commentText
          comment.createAt = Date()
          comment.origin = filmReview

          if moc.hasChanges {
            try? moc.save()
          }

          commentText = ""
        }
        ForEach(filmReview.commentArray, id: \.self) { comment in
          VStack(alignment: .leading) {
            Text(comment.wrappedComment)
            Text(comment.wrappedCreateAt, style: .date)
              .padding(.top, 2)
          }
          .padding(.vertical)
        }
      }
      .padding()
    }
    .onDisappear {
      // TODO: Programmatically dismiss on remove
      if isDeleteFilmReview {
        deleteReview()
      }
    }
    .navigationTitle(filmReview.wrappedTitle)
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          showingDeleteAlert.toggle()
        } label: {
          Label("Delete the film review", systemImage: "trash")
        }
        .alert("Delete the film review?", isPresented: $showingDeleteAlert) {
          Button("Delete", role: .destructive, action: deleteReviewRequest)
          Button("Cancel", role: .cancel) {}
        } message: {
          Text("Are you sure?")
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

  func deleteReviewRequest() {
    isDeleteFilmReview = true

    // TODO: fix dismiss action
    dismiss()
  }

  func deleteReview() {
    moc.delete(filmReview)

    if moc.hasChanges {
      try? moc.save()
    }
  }
}
