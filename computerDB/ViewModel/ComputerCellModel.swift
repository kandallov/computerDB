//
//  ComputerCellModel.swift
//  computerDB
//
//  Created by Alexander Kandalov on 27.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import RxSwift

protocol ComputerCellModeling {
  var name: String { get }
  var company: String { get }
}

class ComputerCellModel: ComputerCellModeling {
  
  let name: String
  let company: String
  
  init(apiworker: APIWorking, computer: Computer) {
    self.name = computer.name
    self.company = computer.company.name
  }
  
}
