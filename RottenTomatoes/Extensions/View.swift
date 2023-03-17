//
//  View.swift
//  Rotten Tomatoes
//
//  Created by Fonov Sergei on 08.03.2023.
//

import SwiftUI

extension View {
  func debugAction(_ closure: () -> Void) -> Self {
    #if DEBUG
    closure()
    #endif

    return self
  }

  func debugPrint(_ value: Any) -> Self {
    debugAction {
      print(value)
    }
  }

  func debugModifier<T: View>(_ modifier: (Self) -> T) -> some View {
    #if DEBUG
    return modifier(self)
    #else
    return self
    #endif
  }

  func debugBorder(_ color: Color = .red, width: CGFloat = 1) -> some View {
    debugModifier {
      $0.border(color, width: width)
    }
  }

  func debugBackground(_ color: Color = .red) -> some View {
    debugModifier {
      $0.background(color)
    }
  }
}
