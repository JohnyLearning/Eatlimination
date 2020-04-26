//
//  StartController-FoodTableDelegate.swift
//  Eatlimination

import Foundation
import UIKit
import CoreData

extension StartController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FoodCell.self), for: indexPath) as? FoodCell else {
            fatalError("Unexpected Index Path")
        }

        let food = foods[indexPath.row]

        cell.title?.text = food.title
        cell.addToDiet.tag = indexPath.row
        cell.addToDiet.setTitle(nil, for: .normal)
        var addToDietIcon: String
        var addToDietTint: UIColor
        if let _ = food.diet {
            addToDietIcon = "bookmark.fill"
            addToDietTint = UIColor.systemGreen
            cell.addToDiet.removeTarget(self, action: #selector(openDietDetails(sender:)), for: .touchUpInside)
        } else {
            addToDietIcon = "bookmark"
            addToDietTint = UIColor.systemRed
            cell.addToDiet.addTarget(self, action: #selector(openDietDetails(sender:)), for: .touchUpInside)
        }
        cell.addToDiet.setImage(UIImage(systemName: addToDietIcon), for: .normal)
        cell.addToDiet.tintColor = addToDietTint
        cell.selectionStyle = .none
        downloadImage(foodCell: cell, imageFile: food.imageUrl, index: indexPath)
        return cell
    }
    
    @objc private func openDietDetails(sender: UIButton) {
        if foods[sender.tag].diet == nil, let activeDiet = dietDataObject.loadOrCreateDiet(), let button = sender as? LoadingButton {
            button.showLoading()
            DispatchQueue.main.async {
                self.foodDataObject.addFood(toDiet: activeDiet, food: self.foods[sender.tag])
                button.hideLoading(image: UIImage(systemName: "bookmark.fill"), tintColor: UIColor.systemGreen)
                self.refresh(doit: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addFoodsController = segue.destination as? AddFoodsController {
            addFoodsController.refreshFoodsDelegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            DispatchQueue.main.async {
                FoodDataObject.delete(food: self.foods[indexPath.row])
                self.foods.remove(at: indexPath.row)
                self.refresh(doit: true)
            }
        }
    }
    
    private func downloadImage(foodCell: FoodCell, imageFile: String?, index: IndexPath) {
        if let imageFile = imageFile {
            SpoonacularApi.downloadImage(imageFile: imageFile, size: .size100) { (data, error) in
                DispatchQueue.main.async {
                    if let data = data {
                        foodCell.foodImage?.image = UIImage(data: data as Data)
                    } else {
                        foodCell.foodImage?.image = UIImage(named: "no-image-icon")
                    }
                    foodCell.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
}
