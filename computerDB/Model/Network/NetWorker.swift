//
//  NetWorker.swift
//  computerDB
//
//  Created by Alexander Kandalov on 27.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import RxSwift
import RxCocoa

protocol NetWorking {
  func buildRequest(method: String, url: String, params: [(String, String)]) -> Observable<Data>
  func photoGet(url: String) -> Observable<UIImage>
}

final class NetWorker: NetWorking {
  
  func buildRequest(method: String, url: String, params: [(String, String)]) -> Observable<Data> {
    let baseUrl = URL(string: url)!
    var request = URLRequest(url: baseUrl)
    let queryItems = params.map { URLQueryItem(name: $0.0, value: $0.1) }
    let urlComponents = NSURLComponents(url: baseUrl, resolvingAgainstBaseURL: true)!
    urlComponents.queryItems = queryItems
    request.url = urlComponents.url
    request.httpMethod = method
    
    return URLSession.shared.rx.data(request: request).map { $0 }
  }
  
  func photoGet(url: String) -> Observable<UIImage> {
    let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let urlForRequest = URL(string: urlString)!
    let requesrt = URLRequest(url: urlForRequest)
    
    return URLSession.shared.rx.data(request: requesrt).map { UIImage(data: $0) ?? UIImage() }
  }
  
}
