//
//  FilmReview+CoreDataProperties.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 23.02.23.
//
//

import CoreData
import Foundation

public extension FilmReview {
  @nonobjc class func fetchRequest() -> NSFetchRequest<FilmReview> {
    return NSFetchRequest<FilmReview>(entityName: "FilmReview")
  }

  @NSManaged var dateCreate: Date?
  @NSManaged var director: String?
  @NSManaged var genre: String?
  @NSManaged var id: UUID?
  @NSManaged var rating: Int16
  @NSManaged var review: String?
  @NSManaged var title: String?

  var wrappedTitle: String {
    title ?? "Unknown film"
  }

  var wrappedDirector: String {
    director ?? "Unknown Director"
  }

  var wrappedReview: String {
    review ?? "No review"
  }

  var wrappedGenre: String {
    genre ?? "Unknown Genre"
  }
}

extension FilmReview: Identifiable {}
