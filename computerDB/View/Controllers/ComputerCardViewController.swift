//
//  ComputerCardViewController.swift
//  computerDB
//
//  Created by Alexander Kandalov on 29.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ComputerCardViewController: UIViewController {
  
  @IBOutlet weak var companyNameLabel: UILabel!
  @IBOutlet weak var introducedLabel: UILabel!
  @IBOutlet weak var discountedLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  @IBOutlet weak var computerImageView: UIImageView!
  
  @IBOutlet weak var companyPlaceholderLabel: UILabel!
  @IBOutlet weak var introducedPlaceholderLabel: UILabel!
  @IBOutlet weak var discountedPlaceholderLabel: UILabel!
  @IBOutlet weak var descriptionPlaceholderLabel: UILabel!
  
  var viewModel: CardViewModeling!
  var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupBindings()
  }
  
  private func setupBindings() {
    viewModel.computerCard
      .map { $0.computerName }
      .bind(to: self.rx.title)
      .disposed(by: disposeBag)
    
    viewModel.computerCard
      .map { [weak self] in if $0.companyName == "" { self?.companyPlaceholderLabel.text = "" }
        return $0.companyName }
      .bind(to: companyNameLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.computerCard
      .map { [weak self] in if $0.introduced == "" { self?.introducedPlaceholderLabel.text = "" }
        return $0.introduced }
      .bind(to: introducedLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.computerCard
      .map { [weak self] in if $0.discounted == "" { self?.discountedPlaceholderLabel.text = "" }
        return $0.discounted }
      .bind(to: discountedLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.computerCard
      .map { [weak self] in if $0.description == "" { self?.descriptionPlaceholderLabel.text = "" }
        return $0.description }
      .bind(to: descriptionLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.photo
      .bind(to: computerImageView.rx.image)
      .disposed(by: disposeBag)
  }
  
}
