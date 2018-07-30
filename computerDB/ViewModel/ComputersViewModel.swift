//
//  ComputersViewModel.swift
//  computerDB
//
//  Created by Alexander Kandalov on 27.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ComputersViewModeling {
  // MARK: - Input
  var pageNumber: PublishSubject<Int> { get }
  var cellDidSelect: PublishSubject<Int> { get }
  // MARK: - Output
  var cellModels: Observable<[ComputerCellModeling]> { get }
  var presentCard: Observable<CardViewModeling> { get }
}

class ComputersViewModel: ComputersViewModeling {
  // MARK: - Input
  var pageNumber: PublishSubject<Int> = PublishSubject<Int>()
  let cellDidSelect: PublishSubject<Int> = PublishSubject<Int>()
  // MARK: - Output
  let cellModels: Observable<[ComputerCellModeling]>
  let presentCard: Observable<CardViewModeling>
  
  init(networker: NetWorking, apiworker: APIWorking) {
    let searchResult = Observable.just(Computers.self)
      .flatMapLatest { _ in
        return apiworker.getComputers(3) }
      .observeOn(MainScheduler.instance)
      .share(replay: 1)
  
    cellModels = searchResult.map { computers in
      computers.items.map { computer in
        ComputerCellModel(apiworker: apiworker, computer: computer) }
    }
    
    presentCard = cellDidSelect
      .withLatestFrom(searchResult) { cell, results in
        (cell, results) }
      .map { cell, results in
        CardViewModel(networker: networker, apiworker: apiworker, currentComputer: results.items[cell]) }
  }
}
