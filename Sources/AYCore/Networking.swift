//
//  Networking.swift
//  
//
//  Created by Ayman Ata on 11/10/2022.
//

import Foundation

protocol NetworkSession {
    func get(from url: URL, completion: @escaping (Data?, Error?) -> Void)
    func post(with request: URLRequest, completion: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func get(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let dataTask = dataTask(with: url) { data, _, error in
            completion(data, error)
        }
        dataTask.resume()
    }

    func post(with request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        let dataTask = dataTask(with: request) { data, _, error in
            completion(data, error)
        }
        dataTask.resume()
    }
}

extension AYCore {
    public class Networking {
        /// Manager class responsible for handling netowk calls.
        /// - Warning: This class must be created before using any public API.
        public class Manager {
            public init() {}
            internal var session: NetworkSession = URLSession.shared

            /// Interacts with live internet to retreive data from the given url.
            /// - Parameters:
            ///   - url: A *URL* object you with to fetch data from.
            ///   - completion: Returns a result object contains opential data or error while fetching.
            public func loadData(from url: URL, completion: @escaping (NetworkResult<Data>) -> Void) {
                session.get(from: url) { data, error in
                    let result: NetworkResult = data.map(NetworkResult<Data>.success) ?? .failure(error)
                    completion(result)
                }
            }

            /// Sends data to the given url.
            /// - Warning: Make sure that the provided URL is accespting a POST route.
            /// - Parameters:
            ///    - url: Location you wish to send data to.
            ///    - body: The object that you want to send over network to the given url.
            ///    - completion: Returns a result object contains opential data or error while sending data.
            public func sendData<I: Codable>(to url: URL, body: I, completion: @escaping (NetworkResult<Data>) -> Void) {
                var request = URLRequest(url: url)
                do {
                    let httpBody = try JSONEncoder().encode(body)
                    request.httpBody = httpBody
                    request.httpMethod = "POST"
                    session.post(with: request) { data, error in
                        let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                        completion(result)
                    }
                } catch let err {
                    return completion(.failure(err))
                }
            }
        }

        public enum NetworkResult<Value> {
            case success(Value)
            case failure(Error?)
        }
    }
}
