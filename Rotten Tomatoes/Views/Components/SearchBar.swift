//
//  SearchBar.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 25.02.23.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
  @Binding var searchText: String

  class Coordinator: NSObject, UISearchBarDelegate {
    @Binding var searchText: String

    init(searchText: Binding<String>) {
      _searchText = searchText
    }

    func searchBar(_: UISearchBar, textDidChange searchText: String) {
      self.searchText = searchText
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      searchBar.resignFirstResponder()
    }
  }

  func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
    let searchBar = UISearchBar(frame: .zero)
    searchBar.delegate = context.coordinator
    searchBar.placeholder = "Search"
    return searchBar
  }

  func updateUIView(_ uiView: UISearchBar, context _: UIViewRepresentableContext<SearchBar>) {
    uiView.text = searchText
  }

  func makeCoordinator() -> SearchBar.Coordinator {
    return Coordinator(searchText: $searchText)
  }
}

struct SearchBar_Previews: PreviewProvider {
  static var previews: some View {
    SearchBar(searchText: .constant(""))
  }
}
