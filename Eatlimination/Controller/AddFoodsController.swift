//
//  AddFoodsController.swift
//  Eatlimination

import Foundation
import UIKit

class AddFoodsController: BaseEatliminationController {
    
    weak var refreshFoodsDelegate: RefreshList?
    
    var foods: [SpoonFoodAuto]?
    
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        searchBar.delegate = self
    }

}

extension AddFoodsController: OnComplete {
    func execute() {
        refreshFoodsDelegate?.refresh()
        self.navigationController?.popViewController(animated: true)
    }
}
