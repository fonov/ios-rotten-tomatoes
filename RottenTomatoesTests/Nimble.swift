//
//  Nimble.swift
//  RottenTomatoesReviewsTests
//
//  Created by Sergei Fonov on 23.03.23.
//

import Foundation
import XCTest
import Nimble

final class NimbleDemoTests: XCTestCase {
  func testNimbleCase1() {
    let squawk = "Squee!"
    expect(squawk).to(equal("Squee!"))
  }

  func testNimbleCase2() {
    let greeting = "Hi!"
    expect(greeting).toNot(equal("Oh, hello there!"))
    expect(greeting).notTo(equal("Oh, hello there!"))
  }

  func testNimbleCase3() {
    expect(2 + 2).to(equal(4), description: "Make sure you created proper expect")
  }

  func testNimbleCase4() {
    expect(2023) == 2023
    expect(2023) != 2022
    expect(2023) > 1996
    expect(1996) < 2023
    expect(8) >= 8
    expect(3) <= 3
  }

  func testNimbleCase5() {
    let exception = NSException(name: NSExceptionName.internalInconsistencyException, reason: "Mars isn't habituated", userInfo: ["Earth": "habituated"])
    expect { exception.raise() }.to(raiseException())

    expect { exception.raise() }.to(raiseException(named: NSExceptionName.internalInconsistencyException))
    expect { exception.raise() }.to(raiseException(named: NSExceptionName.internalInconsistencyException, reason: "Mars isn't habituated"))
    expect { exception.raise() }.to(raiseException(named: NSExceptionName.internalInconsistencyException, reason: "Mars isn't habituated", userInfo: ["Earth": "habituated"]))
  }

  func testNimbleCase6() {
    var animals: [String] = []
    animals.append("Elephant")
    animals.append("Gorilla")
    animals.append("Puma")

    expect(animals).toAlways(contain("Elephant", "Puma"))
    expect(animals).toNever(contain("Tiger"))

    expect(animals).toEventually(contain("Gorilla"), timeout: .seconds(3))
    expect(animals).toNotEventually(contain("Lion"), timeout: .seconds(3), pollInterval: .milliseconds(200))
  }

  func testNimbleCase7() {
    class AnimalClass: Animal {
      var kind: String = ""
    }
    struct AnimalStruct: Animal {
      var kind: String = ""
    }

    let animalClass = AnimalClass()
    expect(animalClass).to(beAKindOf(Animal.self))
    expect(animalClass).to(beAKindOf(AnimalClass.self))
    expect(animalClass).toNot(beAKindOf(AnimalStruct.self))

    expect(animalClass).notTo(beAnInstanceOf(Animal.self))
    expect(animalClass).to(beAnInstanceOf(AnimalClass.self))
    expect(animalClass).toNot(beAnInstanceOf(AnimalStruct.self))

    let animalStruct = AnimalStruct()
    expect(animalStruct).to(beAKindOf(Animal.self))
    expect(animalStruct).to(beAKindOf(AnimalStruct.self))
    expect(animalStruct).toNot(beAKindOf(AnimalClass.self))

    expect(animalStruct).notTo(beAnInstanceOf(Animal.self))
    expect(animalStruct).to(beAnInstanceOf(AnimalStruct.self))
    expect(animalStruct).toNot(beAnInstanceOf(AnimalClass.self))
  }

  func testNimbleCase8() {
    class SpecialAnimal {}

    let specialAnimal = SpecialAnimal()
    let specialAnimalSecond = specialAnimal

    expect(specialAnimal).to(beIdenticalTo(specialAnimalSecond))
    expect(specialAnimal) === specialAnimalSecond
  }

  func testNimbleCase9() {
    expect(9.001).to(beCloseTo(9, within: 0.001))
    expect(9.001) ≈ (9, 0.001)
    expect(9.001) ≈ 9 ± 0.001
    expect(9.001) == 9 ± 0.001

    expect([0.0, 2.0]) ≈ [0.00001, 2.00001]
  }

  func testNimbleCase10() {
    expect(true).to(beTrue())
    expect(false).to(beFalse())

    let actual: String? = nil
    expect(actual).to(beNil())
  }

  func testNimbleCase11() {
    expect { precondition(false) }.to(throwAssertion())
    expect { fatalError("DB can't init") }.to(throwAssertion())
  }

  func testNimbleCase12() {
    enum myError: Error {
      case `default`
    }

    expect { throw myError.default }.to(throwError())
    expect { throw myError.default }.to(throwError(myError.default))
    expect { throw myError.default }.to(throwError(errorType: myError.self))
  }

  func testNimbleCase13() {
    expect([] as [Int]).to(beEmpty())
    expect("hello!").to(beginWith("hel"))
    expect("world!").to(endWith("ld!"))

    expect(5).to(beWithin(1...10))
    expect(5).toNot(beWithin(4..<5))

    expect([1, 2, 3, 4, 5]).to(allPass { $0 < 10 })
    expect([1, 2, 3, 4, 5]).to(allPass(beLessThan(6)))
  }

  func testNimbleCase14() {
    expect([1, 2, 3]).to(haveCount(3))
    expect([1, 2, 3]).notTo(haveCount(10))
  }

  func testNimbleCase15() {
    let aResult: Result<String, Error> = .success("Hooray!")

    expect(aResult).to(beSuccess())
    expect(aResult).to(beSuccess { value in
      expect(value).to(equal("Hooray!"))
    })

    enum AnError: Error {
      case somethingGoingWrong
    }

    let otherResult: Result<String, Error> = .failure(AnError.somethingGoingWrong)

    expect(otherResult).to(beFailure())
    expect(otherResult).to(beFailure { value in
      expect(value).to(matchError(AnError.somethingGoingWrong))
    })
  }

  func testNimbleCase16() {
    expect(10).to(satisfyAnyOf(beLessThan(15), beGreaterThan(5)))
    expect(10).to(beLessThan(15) || beGreaterThan(5))
  }
}

protocol Animal {
  var kind: String { get set }
}
