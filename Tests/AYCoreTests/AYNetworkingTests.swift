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
        let sessionMock = NetworkSessionMock()
        manager.session = sessionMock
        let data = Data([1, 2, 3])
        sessionMock.data = data
        let url = URL(fileURLWithPath: "url")

        manager.loadData(from: url) { result in
            expectation.fulfill()
            switch result {
            case .success(let loadedData):
                XCTAssertEqual(data, loadedData, "loaded data is nil")
            case .failure(let error):
                XCTFail(error?.localizedDescription ?? "error forming invalid result")
            }
        }
        wait(for: [expectation], timeout: 4)
    }

    func testSendData() {
        let manager = AYCore.Networking.Manager()
        let sessionMock = NetworkSessionMock()
        let mockObject = MockedData.init(id: 1, name: "Ayman")
        let mockData = try? JSONEncoder().encode(mockObject)
        sessionMock.data = mockData
        manager.session = sessionMock

        let url = URL(fileURLWithPath: "url")
        let expectation = XCTestExpectation(description: "Send data properly in-time")

        manager.sendData(to: url, body: mockObject) { result in
            expectation.fulfill()
            switch result {
            case .success(let returnedData):
                let returnedObject = try? JSONDecoder().decode(MockedData.self, from: returnedData)
                XCTAssertEqual(returnedObject, mockObject)
                break
            case .failure(let error):
                XCTFail(error?.localizedDescription ?? "Could not send object proberly")
            }
        }
    }
}

class NetworkSessionMock: NetworkSession {
    var data: Data?
    var error: Error?
    
    func get(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        completion(data, error)
    }

    func post(with request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        completion(data, error)
    }
}

struct MockedData: Codable, Equatable {
    let id: Int?
    let name: String?
}
