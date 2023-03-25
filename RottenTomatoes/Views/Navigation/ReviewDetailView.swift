//
//  DetailReviewView.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 21.02.23.
//

import CoreData
import SwiftUI

struct ReviewDetailView: View {
  @Binding var selectedReview: NSManagedObjectID?

  @Environment(\.managedObjectContext) var moc

  @State private var showingDeleteAlert = false
  @State private var showingAddScreen = false

  @FetchRequest var filmReviews: FetchedResults<FilmReview>

  @State private var isDeleteFilmReview = false
  @State private var commentText = ""

  init(selectedReview: Binding<NSManagedObjectID?>) {
    _selectedReview = selectedReview

    guard let selected = selectedReview.wrappedValue else {
      fatalError("can't find film review")
    }

    _filmReviews = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "SELF == %@", selected))
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
        .debugBorder()

      RatingView(rating: .constant(Int(filmReview.rating)))
        .padding()
        .debugBorder()

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
//              .debugBackground()
            Text(comment.wrappedCreateAt, style: .date)
//              .debugBackground()

              .padding(.top, 2)
          }
          .padding(.vertical)
        }
      }
      .padding()
    }
    .onDisappear {
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

    selectedReview = nil
  }

  func deleteReview() {
    moc.delete(filmReview)

    if moc.hasChanges {
      try? moc.save()
    }
  }
}

struct ReviewDetailView_Previews: PreviewProvider {
  static let moc = DataController().container.viewContext

  static var previews: some View {
    let filmReview = FilmReview(context: moc)
    filmReview.dateCreate = Date(timeIntervalSince1970: 16e8)
    filmReview.title = "THE INVITATION"
    filmReview.director = "Jessica M. Thompson"
    filmReview.genre = Genres.horror.rawValue
    filmReview.review = "Just don't watch the trailer"
    filmReview.rating = Int16(1)

    let comment = Comment(context: moc)
    comment.comment = "some comment"
    comment.createAt = Date()
    comment.origin = filmReview

    return ReviewDetailView(selectedReview: .constant(Optional(filmReview.objectID)))
      .environment(\.managedObjectContext, moc)
  }
}
