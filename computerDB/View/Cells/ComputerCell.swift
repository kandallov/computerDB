//
//  ComputerCell.swift
//  computerDB
//
//  Created by Alexander Kandalov on 27.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import RxSwift

class ComputerCell: UITableViewCell {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var companyLabel: UILabel!
  
  private var disposeBag: DisposeBag? = DisposeBag()
  
  var viewModel: ComputerCellModeling? {
    didSet {
      let disposeBag = DisposeBag()
      guard let viewModel = viewModel else { return }
      
      nameLabel.text = viewModel.name
      companyLabel.text = viewModel.company
      
      self.disposeBag = disposeBag
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    viewModel = nil
    disposeBag = nil
  }
  
}
