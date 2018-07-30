//
//  ComputerCardViewModel.swift
//  computerDB
//
//  Created by Alexander Kandalov on 28.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import UIKit

protocol ComputerCardModeling {
  var computerName: String { get }
  var description: String { get }
  var companyName: String { get }
  var introduced: String { get }
  var discounted: String { get }
}

class ComputerCardModel: ComputerCardModeling {
  
  var computerName: String
  var description: String
  var companyName: String
  var introduced: String
  var discounted: String
  
  init(computerCard: ComputerCard) {
    self.computerName = computerCard.name
    self.description = computerCard.description
    self.companyName = computerCard.company.name
    self.introduced = computerCard.introduced
    self.discounted = computerCard.discounted
  }
  
}
