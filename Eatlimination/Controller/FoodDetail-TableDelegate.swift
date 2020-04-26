//
//  FoodDetail-TableDelegate.swift
//  Eatlimination

import Foundation
import UIKit

extension FoodDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AddFoodCell.self), for: indexPath) as? AddFoodCell else {
            fatalError("Unexpected Index Path")
        }

        // Fetch Quote
//        let quote = fetchedResultsController.object(at: indexPath)

//        // Configure Cell
//        cell.authorLabel.text = quote.author
//        cell.contentsLabel.text = quote.contents

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UILabel()
        headerView.backgroundColor = .black
        headerView.textColor = .white
        headerView.textAlignment = .center
        headerView.text = "Tests performed"
        return headerView
    }
    
}
