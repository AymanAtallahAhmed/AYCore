//
//  AYNetworkingTests.swift
//  
//
//  Created by Ayman Ata on 11/10/2022.
//

import XCTest
@testable import AYCore

final class AYNetworkingTests: XCTestCase {

    func testLoadData() {
        let manager = AYCore.Networking.Manager()
        let expectation = XCTestExpectation(description: "Data called")
        guard let url = URL(string: "https://raywenderlich.com") else {
            XCTFail("Could not get a valid url")
            return
        }
        
        manager.loadData(from: url) { result in
            expectation.fulfill()
            switch result {
            case .success(let loadedData):
                XCTAssertNotNil(loadedData, "loaded data is nil")
            case .failure(let error):
                XCTFail(error?.localizedDescription ?? "error forming invalid result")
            }
        }
        wait(for: [expectation], timeout: 4)
    }
}
