//
//  ViewController.swift
//  computerDB
//
//  Created by Alexander Kandalov on 27.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ComputersViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!

  var viewModel: ComputersViewModeling!
  private let disposeBag = DisposeBag()
  private var cardViewModel: CardViewModeling!

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 70
    setupBindings()
  }

  private func setupBindings() {
    viewModel.cellModels
      .bind(to: tableView.rx.items(cellIdentifier: "ComputerCell", cellType: ComputerCell.self)) { index, model, cell in
        cell.viewModel = model
      }.disposed(by: disposeBag)
    
    tableView.rx.itemSelected
      .map { $0.row }
      .bind(to: viewModel.cellDidSelect)
      .disposed(by: disposeBag)
    
    viewModel.presentCard
      .subscribe(onNext: { [unowned self] viewModel in
        self.cardViewModel = viewModel
        self.performSegue(withIdentifier: "toComputerCard", sender: nil)
      }).disposed(by: disposeBag)
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toComputerCard" {
      let controller = segue.destination as! ComputerCardViewController
      controller.viewModel = cardViewModel
    }
  }

}

extension ComputersViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

