//
//  ApiManager.swift
//  MovieList
//
//  Created by karthik on 19/02/24.
//

import Foundation


class ApiManager {
    static func fetchMovieList(from url: URL, completion: @escaping (Result<MovieListResponse, Error>) -> Void) {
        fetchData(from: url, completion: completion)
    }

    private static func fetchData<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "Data is nil", code: 0, userInfo: nil)))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }

        dataTask.resume()
    }
}



