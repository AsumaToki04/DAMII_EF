//
//  AppServices.swift
//  DAMII_EF
//
//  Created by DAMII on 23/12/24.
//

import Foundation
import Alamofire

struct AppServices {
    static let shared = AppServices()
    private let baseUrl = "https://api.unsplash.com"
    private let searchPhotosUrl: String
    private let token: String = "jvvQc1372DVYEAZHBWEpWzAXrz65EdTux1YoGpztbsY"
    
    private init() {
        searchPhotosUrl = "\(baseUrl)/search/photos"
    }
    
    func getPhotosList(query: String) async throws -> [Result] {
        try await withCheckedThrowingContinuation { continuation in
            let headers: HTTPHeaders = [
                "Authorization": "Client-ID \(token)"
            ]
            
            AF.request("\(searchPhotosUrl)?page=1&query=\(query)", headers: headers)
                .validate()
                .responseDecodable(of: Photo.self) { response in
                    switch response.result {
                    case .success(let photo):
                        continuation.resume(returning: photo.results)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
