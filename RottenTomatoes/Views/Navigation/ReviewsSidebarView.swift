//
//  Reviews.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 20.02.23.
//

import CoreData
import SwiftUI

struct ReviewsSidebarView: View {
  @Environment(\.managedObjectContext) var moc

  @FetchRequest(sortDescriptors: [])
  private var fetchRequest: FetchedResults<FilmReview>

  @Binding var selection: NSManagedObjectID?

  @State private var showingAddScreen = false
  @State private var sort = Sort.none

  @State private var searchText = ""
  var query: Binding<String> {
    Binding {
      searchText
    } set: { newValue in
      searchText = newValue
      fetchRequest.nsPredicate = newValue.isEmpty ? nil :
        NSPredicate(format: "title CONTAINS[c] %@ OR director CONTAINS[c] %@", newValue, newValue)
    }
  }

  var body: some View {
    VStack {
      List(selection: $selection) {
        ForEach(fetchRequest, id: \.self) { filmReview in
          NavigationLink(value: filmReview.objectID) {
            HStack {
              EmojiRatingView(rating: filmReview.rating)
                .font(.title)
              VStack(alignment: .leading) {
                Text(filmReview.wrappedTitle)
                  .font(.headline)
                Text("\(filmReview.wrappedDirector) | \(filmReview.wrappedGenre.capitalized)")
                  .foregroundColor(.secondary)
              }
            }
          }
        }
        .onDelete(perform: delete)
      }
      .searchable(text: query)
    }
    .navigationTitle("Rotten Tomatoes")
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        EditButton()
      }
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          showingAddScreen.toggle()
        } label: {
          Label("Plus", systemImage: "plus")
        }
      }
      ToolbarItem(placement: .navigationBarTrailing) {
        Menu {
          Picker("Sort", selection: $sort) {
            ForEach(Sort.allCases, id: \.self) {
              Text($0.rawValue.capitalized)
            }
          }

          #if DEBUG
          Button("Add samples", action: addSamples)
          #endif
        } label: {
          Label("Sort", systemImage: "slider.horizontal.3")
        }
      }
    }
    .sheet(isPresented: $showingAddScreen) {
      AddReviewView()
    }
    .onChange(of: sort) { _ in
      switch sort {
      case .asc:
        fetchRequest.sortDescriptors = [SortDescriptor(\FilmReview.dateCreate)]
      case .desc:
        fetchRequest.sortDescriptors = [SortDescriptor(\FilmReview.dateCreate, order: .reverse)]
      default:
        fetchRequest.sortDescriptors = []
      }
    }
  }

  #if DEBUG
  func addSamples() {
    createFilmReviewSamples(moc)

    if moc.hasChanges {
      try? moc.save()
    }
  }
  #endif

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

struct ReviewsSidebarView_Previews: PreviewProvider {
  static let moc = DataController().container.viewContext

  static var previews: some View {
    #if DEBUG
    createFilmReviewSamples(moc)
    #endif

    return NavigationView {
      ReviewsSidebarView(selection: .constant(nil))
        .environment(\.managedObjectContext, moc)
    }
  }
}
