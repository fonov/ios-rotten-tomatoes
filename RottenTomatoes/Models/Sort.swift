//
//  Sort.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 25.02.23.
//

import Foundation

enum Sort: String, CaseIterable {
  case none = "random"
  case desc = "newer"
  case asc = "older"
}
