//
//  NetworkConstants.swift
//  WisdomLeaf
//
//  Created by Atul Gupta on 02/05/23.
//

import Foundation

class APIConstants {
    static let baseURL = URL(string: "https://picsum.photos")!
    static let photosEndpoint = baseURL.appendingPathComponent("v2/list")
    
    static func photosURL(page: Int, limit: Int = 20) -> URL {
        var components = URLComponents(url: photosEndpoint, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "page", value: "\(page)"),
                                 URLQueryItem(name: "limit", value: "\(limit)")]
        return components.url!
    }
}
