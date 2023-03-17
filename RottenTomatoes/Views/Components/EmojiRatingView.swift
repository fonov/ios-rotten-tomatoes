//
//  EmojiRatingView.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 21.02.23.
//

import SwiftUI

struct EmojiRatingView: View {
  let rating: Int16

  var body: some View {
    emoji
      .padding(5)
      .background(Circle().foregroundColor(color))
  }

  var emoji: Text {
    switch rating {
    case 1:
      return Text("🙈")
    case 2:
      return Text("☹️")
    case 3:
      return Text("🤨")
    case 4:
      return Text("😄")
    default:
      return Text("🤩")
    }
  }

  var color: Color {
    switch rating {
    case 1:
      return .red
    case 2:
      return .orange
    case 3:
      return .cyan
    case 4:
      return .indigo
    default:
      return .accentColor
    }
  }
}

struct EmojiRatingView_Previews: PreviewProvider {
  static var previews: some View {
    HStack {
      ForEach(1 ..< 6) {
        EmojiRatingView(rating: Int16($0))
      }
    }
  }
}
