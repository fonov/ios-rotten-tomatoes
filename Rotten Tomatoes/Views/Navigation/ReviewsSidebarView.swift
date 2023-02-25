//
//  Reviews.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 20.02.23.
//

import SwiftUI

struct ReviewsSidebarView: View {
  @Binding var selection: FilmReview.ID?

  @State private var showingAddScreen = false

  @State private var search = ""
  @State private var sort = Sort.none

  var body: some View {
    VStack {
      SearchBar(searchText: $search)
      List(selection: $selection) {
        FetchList(searchKey: "title", searchValue: search, sort: sort) { (filmReview: FilmReview) in
          NavigationLink(value: filmReview.id) {
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
      }
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
        } label: {
          Label("Sort", systemImage: "slider.horizontal.3")
        }
      }
    }
    .sheet(isPresented: $showingAddScreen) {
      AddReviewView()
    }
  }
}

// struct Reviews_Previews: PreviewProvider {
//  static var previews: some View {
//    ReviewsSidebar(selection: <#T##Binding<FilmReview.ID?>#>, filmReviews: <#T##FetchedResults<FilmReview>#>)
//  }
// }
