//
//  CardViewModel.swift
//  computerDB
//
//  Created by Alexander Kandalov on 28.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import RxSwift

protocol CardViewModeling {
  //MARK: - Output
  var computerCard: Observable<ComputerCardModel> { get }
  var photo: Observable<UIImage> { get }
}

class CardViewModel: CardViewModeling {
  //MARK: - Output
  var computerCard: Observable<ComputerCardModel>
  var photo: Observable<UIImage>
  
  init(networker: NetWorking, apiworker: APIWorking, currentComputer: Computer) {
    let computerId = currentComputer.id
    let searchResult = Observable.just(ComputerCard.self)
      .flatMapLatest { _ in
        return apiworker.getComputerCard(computerId) }
      .observeOn(MainScheduler.instance)
      .share(replay: 1)
    
    computerCard = searchResult
      .map { computer in
        ComputerCardModel(computerCard: computer)
      }
    
    let photoPlaceholder = #imageLiteral(resourceName: "placeholder")
      photo = searchResult
        .map { computer in
          let imageUrl = computer.imageUrl
          return imageUrl }
        .flatMapLatest { imageUrl in
          return networker.photoGet(url: imageUrl)
            .catchErrorJustReturn(photoPlaceholder)
        }
    }
  
}
