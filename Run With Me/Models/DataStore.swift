//
//  DataStore.swift
//  Run With Me
//
//  Created by Allen Jue on 11/20/22.
//

import Foundation
import SwiftUI

/// Class to maintain persistent data with the app, which loads upon opening and saves when closing
class DataStore: ObservableObject {
    @Published var runs: [Run] = []
    
    /// Generates file URL for the document runs.data
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("runs.data")
    }
    
    /// Loads the file from user's documents directory
    static func load(completion: @escaping (Result<[Run], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                /// decodes data from the file and returns it
                let decodedData = try JSONDecoder().decode([Run].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    /// Saves the current runs, encodes them, and writes them to the user's runs.data file
    static func save(runs: [Run], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let encodedData = try JSONEncoder().encode(runs)
                let fileURL = try fileURL()
                try encodedData.write(to: fileURL)
                DispatchQueue.main.async {
                    completion(.success(runs.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
