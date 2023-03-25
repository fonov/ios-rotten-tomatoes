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

    let traitDarkMode = UITraitCollection(userInterfaceStyle: .dark)
    assertSnapshot(matching: view.toVC(), as: .image(on: .iPhone12, traits: traitDarkMode))
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

  func testRatingViewSet2() {
    let view = RatingView(rating: .constant(4))
    assertSnapshot(matching: view.toVC(), as: .recursiveDescription)
    assertSnapshot(matching: view.toVC(), as: .image(on: .iPhone13Mini(.landscape)))
    assertSnapshot(matching: view.toVC(), as: .recursiveDescription(on: .iPhone13Mini(.landscape)))
  }

  func testUrlRequest() {
    let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("Fonov Sergei", forHTTPHeaderField: "X-MY-NAME")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    assertSnapshot(matching: request, as: .raw)
  }

  func testFilmReview() {
    var filmReview = FilmReviewStruct()
    filmReview.dateCreate = Date(timeIntervalSince1970: 1500000)
    filmReview.title = "THE INVITATION"
    filmReview.director = "Jessica M. Thompson"
    filmReview.genre = Genres.horror.rawValue
    filmReview.review = "Just don't watch the trailer"
    filmReview.rating = Int16(1)

    assertSnapshot(matching: filmReview, as: .json)
    assertSnapshot(matching: filmReview, as: .plist)
    assertSnapshot(matching: filmReview, as: .dump)
  }
}

extension SwiftUI.View {
  func toVC() -> UIViewController {
    let vc = UIHostingController(rootView: self)
    vc.view.frame = UIScreen.main.bounds
    return vc
  }
}

struct FilmReviewStruct: Codable {
  var dateCreate: Date?
  var director: String?
  var genre: String?
  var id: UUID?
  var rating: Int16?
  var review: String?
  var title: String?
}
