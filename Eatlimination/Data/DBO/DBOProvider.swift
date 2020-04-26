//
//  DBOProvider.swift
//  Eatlimination

import Foundation

class DBOProvider {
    
    private static var dietDataObject: DietDataObject? = nil
    private static var foodDataObject: FoodDataObject? = nil
    private static var symptomDataObject: SymptomDataObject? = nil
    private static var symptomRecordDataObject: SymptomRecordDataObject? = nil
    
    class func getDietDBO() -> DietDataObject {
        if dietDataObject == nil {
            dietDataObject = DietDataObject()
        }
        return dietDataObject!
    }
    
    class func getFoodDBO() -> FoodDataObject {
        if foodDataObject == nil {
            self.foodDataObject = FoodDataObject()
        }
        return foodDataObject!
    }
    
    class func getSymptomDBO() -> SymptomDataObject {
        if symptomDataObject == nil {
            self.symptomDataObject = SymptomDataObject()
        }
        return symptomDataObject!
    }
    
    class func getSymptomRecordDBO() -> SymptomRecordDataObject {
        if symptomRecordDataObject == nil {
            self.symptomRecordDataObject = SymptomRecordDataObject()
        }
        return symptomRecordDataObject!
    }
    
}
