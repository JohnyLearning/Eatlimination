//
//  RecycleBinFoodDropView.swift
//  Eatlimination

import Foundation
import UIKit

class RecycleBinFoodDropView: UIImageView, UIDropInteractionDelegate {
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: UIImage.self) { foods in
            if let foods = foods as? [FoodData] {
                // try to delete
                if let food = foods.first {
                    FoodDataObject.delete(food: food)
                }
            }
        }
    }

}
