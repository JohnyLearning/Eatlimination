//
//  DietDataObject.swift
//  Eatlimination

import Foundation
import CoreData

class DietDataObject: BaseDataObject {
    
    func create() -> DietData {
        let diet = DietData(context: coreDataManager.managedObjectContext)
        diet.active = true
        diet.started = Date()
        coreDataManager.save()
        return diet
    }
    
    func getActiveDiet() -> DietData? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName(entity: DietData.self))
        let activeDietPredicate = NSPredicate(format: "active == %@", NSNumber(value: true))
        fetchRequest.predicate = activeDietPredicate
        if let activeDiet = try? coreDataManager.managedObjectContext.fetch(fetchRequest) as? [DietData], activeDiet.count > 0 {
            return activeDiet[0]
        } else {
            return nil
        }
    }
    
    func loadOrCreateDiet() -> DietData? {
        if let diet = getActiveDiet() {
            return diet
        } else {
            return create()
        }
    }
    
}
