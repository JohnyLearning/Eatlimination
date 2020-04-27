//
//  BaseEatliminationController.swift
//  Eatlimination

import Foundation
import UIKit

public class BaseEatliminationController: UIViewController {
    
    private static let noImageName = "no-image-icon"
    
    var foodDataObject: FoodDataObject
    var dietDataObject: DietDataObject
    var symptomDataObject: SymptomDataObject
    var symptomRecordingDataObject: SymptomRecordDataObject
    
    required init?(coder: NSCoder) {
        foodDataObject = DBOProvider.getFoodDBO()
        dietDataObject = DBOProvider.getDietDBO()
        symptomDataObject = DBOProvider.getSymptomDBO()
        symptomRecordingDataObject = DBOProvider.getSymptomRecordDBO()
        super.init(coder: coder)
    }
    
    func showError(title: String, message: String?) {
        let alertVC = UIAlertController(title: title, message: message ?? "Something went wrong!", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func downloadImage(imageFile: String?, activityIndicator: UIActivityIndicatorView, imageSize: SpoonacularApi.ImageSize = .size100, completion: @escaping (UIImage?) -> Void) {
        if let imageFile = imageFile {
            activityIndicator.startAnimating()
            SpoonacularApi.downloadImage(imageFile: imageFile, size: imageSize) { (data, error) in
                DispatchQueue.main.async {
                    if let data = data {
                        completion(UIImage(data: data as Data))
                    } else {
                        completion(UIImage(named: BaseEatliminationController.noImageName))
                    }
                    activityIndicator.stopAnimating()
                }
            }
        } else {
            completion(UIImage(named: BaseEatliminationController.noImageName))
        }
    }
    
}
