//
//  AddFoodsController-TableDelegate.swift
//  Eatlimination

import Foundation
import UIKit

extension AddFoodsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AddFoodCell.self)) as! AddFoodCell
        
        let foodInfo = foods?[indexPath.row]
        cell.name.text = foodInfo?.name
        cell.foodImage.image = nil
        cell.selectionStyle = .none
        downloadImage(foodCell: cell, imageFile: foods?[indexPath.row].image, index: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openFoodDetails(food: foods?[indexPath.row])
    }
    
    private func downloadImage(foodCell: AddFoodCell, imageFile: String?, index: IndexPath) {
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
    
    private func openFoodDetails(food: SpoonFoodAuto?) {
        if let food = food {
            performSegue(withIdentifier: "showFoodDetail", sender: food)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFoodDetail", let foodDetailController = segue.destination as? FoodDetailController, let food = sender as? SpoonFoodAuto {
            foodDetailController.onCompleteDelegate = self
            foodDetailController.prepare(food: food)
        }
    }

}
