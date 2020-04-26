//
//  BaseEatliminationController.swift
//  Eatlimination

import Foundation
import UIKit

public class BaseEatliminationController: UIViewController {
    
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
    
}
