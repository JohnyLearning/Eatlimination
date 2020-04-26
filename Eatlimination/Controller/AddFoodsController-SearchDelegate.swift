//
//  AddFoodsController-SearchDelegate.swift
//  Eatlimination

import Foundation
import UIKit

extension AddFoodsController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            populateFoods(query: searchText)
        }
    }
    
    private func populateFoods(query: String) {
        SpoonacularApi.searchAutocomplete(query: query) { (data, error) in
            self.activityIndicator.startAnimating()
            DispatchQueue.main.async {
                if let data = data {
                    self.foods = data
                    self.tableView.reloadData()
                } else {
                    self.showError(title: "Search", message: error?.localizedDescription)
                }
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
}
