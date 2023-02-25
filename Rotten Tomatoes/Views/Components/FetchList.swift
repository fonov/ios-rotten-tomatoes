//
//  FilteredList.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 25.02.23.
//

import CoreData
import SwiftUI

struct FetchList<T: NSManagedObject, Context: View>: View {
  @Environment(\.managedObjectContext) var moc

  @FetchRequest var fetchRequest: FetchedResults<T>

  let content: (T) -> Context

  init(searchKey: String, searchValue: String, sort _: Sort, @ViewBuilder content: @escaping (T) -> Context) {
    var predicate: NSPredicate?
    if !searchValue.isEmpty {
      predicate = NSPredicate(format: "%K CONTAINS[c] %@", searchKey, searchValue)
    }

    _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: predicate)
    self.content = content
  }

  var body: some View {
    ForEach(fetchRequest, id: \.self) { item in
      content(item)
    }
    .onDelete(perform: delete)
  }

  func delete(at offset: IndexSet) {
    for index in offset {
      let item = fetchRequest[index]
      moc.delete(item)
    }

    if moc.hasChanges {
      try? moc.save()
    }
  }
}

extension FetchList where T: FilmReview {
  init(searchKey: String, searchValue: String, sort: Sort, @ViewBuilder content: @escaping (T) -> Context) {
    var predicate: NSPredicate?
    if !searchValue.isEmpty {
      predicate = NSPredicate(format: "%K CONTAINS[c] %@", searchKey, searchValue)
    }

    var sortDescriptor: SortDescriptor<T>?

    switch sort {
    case .asc:
      sortDescriptor = SortDescriptor(\.dateCreate)
    case .desc:
      sortDescriptor = SortDescriptor(\.dateCreate, order: .reverse)
    default:
      break
    }

    _fetchRequest = FetchRequest<T>(sortDescriptors: [sortDescriptor].compactMap { $0 }, predicate: predicate)
    self.content = content
  }
}

// struct FilteredList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredList()
//    }
// }
