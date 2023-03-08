//
//  FilmReview+CoreDataProperties.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 26.02.23.
//
//

import CoreData
import Foundation

public extension FilmReview {
  @nonobjc class func fetchRequest() -> NSFetchRequest<FilmReview> {
    NSFetchRequest<FilmReview>(entityName: "FilmReview")
  }

  @NSManaged var dateCreate: Date?
  @NSManaged var director: String?
  @NSManaged var genre: String?
  @NSManaged var id: UUID?
  @NSManaged var rating: Int16
  @NSManaged var review: String?
  @NSManaged var title: String?
  @NSManaged var comment: NSSet?

  internal var wrappedTitle: String {
    title ?? "Unknown film"
  }

  internal var wrappedDirector: String {
    director ?? "Unknown Director"
  }

  internal var wrappedReview: String {
    review ?? "No review"
  }

  internal var wrappedGenre: String {
    genre ?? "Unknown Genre"
  }

  internal var commentArray: [Comment] {
    let set = comment as? Set<Comment> ?? []
    return set.sorted {
      $0.wrappedCreateAt > $1.wrappedCreateAt
    }
  }
}

// MARK: Generated accessors for comment

public extension FilmReview {
  @objc(addCommentObject:)
  @NSManaged func addToComment(_ value: Comment)

  @objc(removeCommentObject:)
  @NSManaged func removeFromComment(_ value: Comment)

  @objc(addComment:)
  @NSManaged func addToComment(_ values: NSSet)

  @objc(removeComment:)
  @NSManaged func removeFromComment(_ values: NSSet)
}

extension FilmReview: Identifiable {}
