//
//  Rotten_TomatoesUITests.swift
//  Rotten TomatoesUITests
//
//  Created by Sergei Fonov on 20.02.23.
//

import XCTest

final class Rotten_TomatoesUITests: XCTestCase {
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testFilmReview() throws {
    // UI tests must launch the application that they test.
    let app = XCUIApplication()
    setupSnapshot(app)
    app.launch()

    // Use XCTAssert and related functions to verify your tests produce the correct results.

    snapshot("0Launch")

//    app.navigationBars["Rotten Tomatoes"]/*@START_MENU_TOKEN@*/.buttons["Sort"]/*[[".otherElements[\"Sort\"].buttons[\"Sort\"]",".buttons[\"Sort\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//
//    snapshot("Menu")

    app.navigationBars["Rotten Tomatoes"]/*@START_MENU_TOKEN@*/.buttons["Plus"]/*[[".otherElements[\"Plus\"].buttons[\"Plus\"]",".buttons[\"Plus\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//    app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["Action"]/*[[".cells",".buttons[\"Genre, Action\"].staticTexts[\"Action\"]",".staticTexts[\"Action\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()

    snapshot("Adding_film_review")

    let collectionViewsQuery = app.collectionViews
    let element = collectionViewsQuery.children(matching: .cell).element(boundBy: 5).children(matching: .other).element(boundBy: 1).children(matching: .other).element
    element.children(matching: .other).element.children(matching: .image).matching(identifier: "tomato").element(boundBy: 2).tap()

    snapshot("Set_rating")

    collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Update"]/*[[".cells.buttons[\"Update\"]",".buttons[\"Update\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

    snapshot("Film_review_list")
  }

  func testLaunchPerformance() throws {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
      // This measures how long it takes to launch your application.
      measure(metrics: [XCTApplicationLaunchMetric()]) {
        XCUIApplication().launch()
      }
    }
  }
}
