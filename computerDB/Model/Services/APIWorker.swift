//
//  APIWorker.swift
//  computerDB
//
//  Created by Alexander Kandalov on 27.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import RxSwift
import RxCocoa

protocol APIWorking {
  func getComputers(_ pageNumber: Int) -> Observable<Computers>
  func getComputerCard(_ computerId: Int) -> Observable<ComputerCard>
}

class APIWorker: APIWorking {
  
  private let netWorker: NetWorking
  
  init(netWorker: NetWorking) {
    self.netWorker = netWorker
  }
  
  func getComputers(_ pageNumber: Int) -> Observable<Computers> {
    let urlString = "http://testwork.nsd.naumen.ru/rest/computers"
    return netWorker.buildRequest(method: "GET", url: urlString, params: [("p", "\(pageNumber)")])
      .map { data in
        let computers = try JSONDecoder().decode(Computers.self, from: data)
        return computers
     }
   }
  
  func getComputerCard(_ computerId: Int) -> Observable<ComputerCard> {
    let stringUrl = "http://testwork.nsd.naumen.ru/rest/computers/\(computerId)"
    return netWorker.buildRequest(method: "GET", url: stringUrl, params: [])
      .map { data in
        let computerCard = try JSONDecoder().decode(ComputerCard.self, from: data)
        return computerCard
    }
  }

}
