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
        downloadImage(imageFile: foods?[indexPath.row].image, activityIndicator: cell.activityIndicator) { imageData in
            if let _ = imageData {
                cell.foodImage?.image = imageData
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openFoodDetails(food: foods?[indexPath.row])
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
