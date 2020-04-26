//
//  DietDetailsController.swift
//  Eatlimination

import Foundation
import UIKit

class DietFoodsController: BaseDietDetailsTabBarController {
    
    var newFoods: [FoodData]? = nil
    var foods: [FoodData]? = nil
        
    @IBOutlet weak var foodsCollection: UICollectionView!
    
    @IBOutlet weak var deletePlace: RecycleBinFoodDropView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foods = foodDataObject.findFoods(byDiet: dietDataObject.getActiveDiet())
        foodsCollection.delegate = self
        foodsCollection.dataSource = self
        foodsCollection.dragDelegate = self
        foodsCollection.dragInteractionEnabled = true
        view.addInteraction(UIDropInteraction(delegate: self))
    }

    @IBAction func goBack(_ sender: Any) {
        goBack()
    }
}
