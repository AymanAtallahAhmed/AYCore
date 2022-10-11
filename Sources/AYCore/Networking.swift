//
//  Networking.swift
//  
//
//  Created by Ayman Ata on 11/10/2022.
//

import Foundation

protocol NetworkSession {
    func get(from url: URL, completion: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func get(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let dataTask = dataTask(with: url) { data, _, error in
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
            func loadData(from url: URL, completion: @escaping (NetworkResult<Data>) -> Void) {
                session.get(from: url) { data, error in
                    let result: NetworkResult = data.map(NetworkResult<Data>.success) ?? .failure(error)
                    completion(result)
                }
            }
        }

        public enum NetworkResult<Value> {
            case success(Value)
            case failure(Error?)
        }
    }
}
