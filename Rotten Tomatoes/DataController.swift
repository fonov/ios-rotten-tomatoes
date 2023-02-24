//
//  DataController.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 20.02.23.
//

import CoreData

class DataController: ObservableObject {
  let container = NSPersistentContainer(name: "RottenTomatoes")

  init() {
    container.loadPersistentStores { _, error in
      if let error {
        fatalError(error.localizedDescription)
      }

      self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
  }
}
