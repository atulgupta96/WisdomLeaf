//
//  Photo.swift
//  WisdomLeaf
//
//  Created by Atul Gupta on 02/05/23.
//

import Foundation

struct Photo: Codable {
    let id: Int
    let width, height: Double
    let author: String
    let url, downloadUrl: String
    var isChecked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadUrl = "download_url" //Can also do this using JSON Decoder parsing strategy
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        author = try container.decode(String.self, forKey: .author)
        url = try container.decode(String.self, forKey: .url)
        downloadUrl = try container.decode(String.self, forKey: .downloadUrl)
        width = try container.decode(Double.self, forKey: .width)
        height = try container.decode(Double.self, forKey: .height)
        
        if let id = try? container.decode(String.self, forKey: .id), let id = Int(id) {
            self.id = id
            
        } else {
            self.id = -1
        }
    }
}
