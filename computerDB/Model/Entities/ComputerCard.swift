//
//  ComputerCard.swift
//  computerDB
//
//  Created by Alexander Kandalov on 28.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import UIKit

struct ComputerCard: Codable {
  
  var company: CompanyInfo
  var id: Int
  var name: String
  var description: String
  var introduced: String
  var discounted: String
  var imageUrl: String
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try values.decode(Int.self, forKey: .id)
    self.name = try values.decode(String.self, forKey: .name)
    self.description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
    self.introduced = try values.decodeIfPresent(String.self, forKey: .introduced) ?? ""
    self.discounted = try values.decodeIfPresent(String.self, forKey: .discounted) ?? ""
    self.imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl) ?? "https://someplace.net"
    self.company = try values.decodeIfPresent(CompanyInfo.self, forKey: .company) ?? CompanyInfo(id: 0, name: "")
  }
}

struct CompanyInfo: Codable {
  var id: Int
  var name: String
}
