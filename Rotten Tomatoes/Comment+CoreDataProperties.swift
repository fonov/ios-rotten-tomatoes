//
//  Comment+CoreDataProperties.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 26.02.23.
//
//

import CoreData
import Foundation

public extension Comment {
  @nonobjc class func fetchRequest() -> NSFetchRequest<Comment> {
    return NSFetchRequest<Comment>(entityName: "Comment")
  }

  @NSManaged var comment: String?
  @NSManaged var createAt: Date?
  @NSManaged var origin: FilmReview?

  var wrappedComment: String {
    comment ?? "Unknown Comment"
  }

  var wrappedCreateAt: Date {
    createAt ?? .now
  }
}

extension Comment: Identifiable {}
