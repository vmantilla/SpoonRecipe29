import XCTest
@testable import SpoonRecipeDemo

class RecipeViewModelTests: XCTestCase {

    // Test that fetching recipes sets isLoading to true
    func testFetchRecipesSetsIsLoading() {
        let viewModel = RecipeViewModel(apiManager: MockAPIManager())
        viewModel.fetchRecipes()
        XCTAssertTrue(viewModel.isLoading)
    }
    
    // Test that fetching recipes sets recipes when successful
    func testFetchRecipesSetsRecipes() {
        let viewModel = RecipeViewModel(apiManager: MockAPIManager())
        let expectation = XCTestExpectation(description: "Recipes loaded")
        
        viewModel.fetchRecipes()
        XCTAssertTrue(viewModel.isLoading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertEqual(viewModel.recipes.count, 2)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
    }

    
    func testFetchRecipesSetsErrorMessage() {
        let viewModel = RecipeViewModel(apiManager: MockAPIManager(returnError: true))
        let expectation = XCTestExpectation(description: "Error message set")

        viewModel.fetchRecipes()
        XCTAssertTrue(viewModel.isLoading)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertFalse(viewModel.errorMessage.isEmpty)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }


}
