//
//  Rotten_TomatoesApp.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 20.02.23.
//

import SwiftUI

@main
struct Rotten_TomatoesApp: App {
  @StateObject private var dataController = DataController()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, dataController.container.viewContext)
    }
  }
}
