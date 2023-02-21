//
//  Genres.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 20.02.23.
//

import SwiftUI

enum Genres: String, CaseIterable {
  case horror = "Horror"
  case comedy = "Comedy"
  case action = "Action"
  case drama = "Drama"
  case adventure = "Adventure"

  func getImage() -> Image {
    switch self {
    case .horror:
      return Image("NosferatuShadow")
    case .comedy:
      return Image("screen_shot_2019-06-21_at_2.16.03_pm")
    case .action:
      return Image("John-Wick")
    case .drama:
      return Image("magnolia-final")
    case .adventure:
      return Image("Adventure-Genre-800x445")
    default:
      return Image(systemName: "film")
    }
  }
}
