//
//  SnapshotTesting.swift
//  RottenTomatoesReviewsTests
//
//  Created by Sergei Fonov on 25.03.23.
//

import Foundation
import SnapshotTesting
import XCTest
import SwiftUI
import CoreData
@testable import RottenTomatoesReviews

class SnapshotDemoTests: XCTestCase {
  func testRatingView() {
    let view = RatingView(rating: .constant(4))
    assertSnapshot(matching: view.toVC(), as: .image)
  }

  func testEmojiRating() {
    let view = EmojiRatingView(rating: Int16(5))
    assertSnapshot(matching: view.toVC(), as: .image)
  }

  func testSearchBar() {
    let view = SearchBar(searchText: .constant("Sergei Fonov"))
    assertSnapshot(matching: view.toVC(), as: .image)
  }

  func testContentView() {
    let moc = DataController().container.viewContext

    let filmReview1 = FilmReview(context: moc)
    filmReview1.dateCreate = Date(timeIntervalSince1970: 1500000)
    filmReview1.title = "THE INVITATION"
    filmReview1.director = "Jessica M. Thompson"
    filmReview1.genre = Genres.horror.rawValue
    filmReview1.review = "Just don't watch the trailer"
    filmReview1.rating = Int16(1)

    let view = ContentView()
      .environment(\.managedObjectContext, moc)
    assertSnapshot(matching: view.toVC(), as: .image)
  }

  func testReviewDetailView() {
    let view = ReviewDetailView_Previews.previews
    assertSnapshot(matching: view.toVC(), as: .image)
  }

  func testAddReviewView() {
    let view = AddReviewView()
    assertSnapshot(matching: view.toVC(), as: .image)
  }

  func testReviewSideBarView() {
    let moc = DataController().container.viewContext

    let filmReview1 = FilmReview(context: moc)
    filmReview1.dateCreate = Date(timeIntervalSince1970: 1500000)
    filmReview1.title = "THE INVITATION"
    filmReview1.director = "Jessica M. Thompson"
    filmReview1.genre = Genres.horror.rawValue
    filmReview1.review = "Just don't watch the trailer"
    filmReview1.rating = Int16(1)

    let view =
    NavigationView {
      ReviewsSidebarView(selection: .constant(nil))
        .environment(\.managedObjectContext, moc)
    }
    assertSnapshot(matching: view.toVC(), as: .image)
  }
}

extension SwiftUI.View {
  func toVC() -> UIViewController {
    let vc = UIHostingController(rootView: self)
    vc.view.frame = UIScreen.main.bounds
    return vc
  }
}
