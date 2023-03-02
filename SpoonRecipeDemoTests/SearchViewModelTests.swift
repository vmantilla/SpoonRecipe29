//
//  SearchViewModelTests.swift
//  SpoonRecipeDemoTests
//
//  Created by RAVIT SAS on 1/03/23.
//

import XCTest
@testable import SpoonRecipeDemo

import XCTest
@testable import SpoonRecipeDemo

class SearchViewModelTests: XCTestCase {

    func testSearchRecipes() {
        // Given
        let viewModel = SearchViewModel(apiManager: MockAPIManager())
        viewModel.keyword = "chicken"

        let expectation = XCTestExpectation(description: "Search completed")

        // When
        viewModel.searchRecipes()

        // Then
        XCTAssertTrue(viewModel.isLoading)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertEqual(viewModel.recipes.count, 2)
            XCTAssertEqual(viewModel.errorMessage, "")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testSearchRecipesWithEmptyKeyword() {
        // Given
        let viewModel = SearchViewModel(apiManager: MockAPIManager())
        viewModel.keyword = ""

        // When
        viewModel.searchRecipes()

        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.recipes.count, 0)
        XCTAssertEqual(viewModel.errorMessage, "")
    }

    func testSearchRecipesWithError() {
        // Given
        let viewModel = SearchViewModel(apiManager: MockAPIManager(returnError: true))
        viewModel.keyword = "chicken"

        let expectation = XCTestExpectation(description: "Search completed")

        // When
        viewModel.searchRecipes()

        // Then
        XCTAssertTrue(viewModel.isLoading)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertEqual(viewModel.recipes.count, 0)
            XCTAssertFalse(viewModel.errorMessage.isEmpty)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
}
