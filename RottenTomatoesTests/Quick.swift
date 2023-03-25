//
//  Quick.swift
//  RottenTomatoesReviewsTests
//
//  Created by Sergei Fonov on 25.03.23.
//

import Foundation
import Quick
import Nimble

class QuickDemoTests: QuickSpec {
  override func spec() {
    describe("QuickDemoTests") {
      it("2 + 2 should equal 4") {
        expect(2 + 2).to(equal(4))
      }

      context("Math operation") {
        it("addition") {
          expect(10+10) == 20
        }
        it("comparison") {
          expect(100.00001) ≈ 100
        }
      }
    }
  }
}
