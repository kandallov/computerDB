//
//  Computer.swift
//  computerDB
//
//  Created by Alexander Kandalov on 27.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import UIKit

struct Computers: Codable {
  private let _items: FailableCodableArray<Computer>
  var items: [Computer] {
    return _items.elements
  }
  
  private enum CodingKeys : String, CodingKey {
    case _items = "items"
  }
}

struct Computer: Codable {
  var company: Company
  var id: Int
  var name: String
}

struct Company: Codable {
  var id: Int
  var name: String
}

struct FailableDecodable<Base : Decodable> : Decodable {
  
  let base: Base?
  
  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    self.base = try? container.decode(Base.self)
  }
}

struct FailableCodableArray<Element : Codable> : Codable {
  
  var elements: [Element]
  
  init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()
    
    var elements = [Element]()
    
    if let count = container.count {
      elements.reserveCapacity(count)
    }
    
    while !container.isAtEnd {
      if let element = try container
        .decode(FailableDecodable<Element>.self).base {
        
        elements.append(element)
      }
    }
    self.elements = elements
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(elements)
  }
}


