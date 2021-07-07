//
//  FoodDetailController.swift
//  Eatlimination

import Foundation
import UIKit

class FoodDetailController: BaseEatliminationController {
    
    weak var onCompleteDelegate: OnComplete?
    
    private static let errorTitle: String = "Food Details"
    
    private var food: SpoonFoodAuto? = nil
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func prepare(food: SpoonFoodAuto) {
        self.food = food
    }
            
    override func viewDidLoad() {
        name.text = food?.name
        if let imageFile = food?.image {
            downloadImage(imageFile: imageFile, activityIndicator: activityIndicator, imageSize: .size500) { imageData in
                if let _ = imageData {
                    self.photo.image = imageData
                }
            }
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addFood(_ sender: Any) {
        if let food = self.food {
            do {
                try foodDataObject.create(name: food.name, externalId: String(food.id), imageUrl: food.image)
                self.onCompleteDelegate?.execute()
                self.dismiss(animated: true)
            } catch FoodDataError.FoodAlreadyExists(let errorMessage) {
                showError(title: FoodDetailController.errorTitle, message: errorMessage)
            } catch {
                showError(title: FoodDetailController.errorTitle, message: "Something went wrong.")
            }
        }
    }
    
}
