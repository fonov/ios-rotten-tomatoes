//
//  RatingView.swift
//  Rotten Tomatoes
//
//  Created by Sergei Fonov on 21.02.23.
//

import SwiftUI

struct RatingView: View {
  @Binding var rating: Int

  var label = ""
  var maximumRating = 5

  var onImage = Image("tomato")
  var offImage: Image?

  var onColor: Color = .white
  var offColor: Color = .accentColor

  var body: some View {
    HStack {
      if label.isEmpty == false {
        Text(label)
      }

      ForEach(1 ..< maximumRating + 1) { number in
        image(for: number)
          .resizable()
          .frame(width: 30, height: 30)
          .colorMultiply(colorMultiply(for: number))
          .onTapGesture {
            withAnimation {
              rating = number
            }
          }
      }
    }
  }

  func image(for number: Int) -> Image {
    if number > rating {
      return offImage ?? onImage
    } else {
      return onImage
    }
  }

  func colorMultiply(for number: Int) -> Color {
    number > rating ? offColor : onColor
  }
}

struct RatingView_Previews: PreviewProvider {
  static var previews: some View {
    RatingView(rating: .constant(4))
  }
}
