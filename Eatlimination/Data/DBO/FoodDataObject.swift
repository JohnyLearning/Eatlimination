//
//  FoodDataObject.swift
//  Eatlimination

import Foundation
import CoreData

enum FoodDataError: Error {
    case FoodAlreadyExists(String)
}

class FoodDataObject: BaseDataObject {
    
    func create(name: String, externalId: String? = nil, imageUrl: String? = nil, imageData: Data? = nil) throws {
        guard findFood(byExternalId: externalId) == nil else {
            throw FoodDataError.FoodAlreadyExists("Food already exists.")
        }
        let food = FoodData(context: coreDataManager.managedObjectContext)
        food.title = name
        food.imageUrl = imageUrl
        food.externalId = externalId
        food.image = imageData
        food.createdAt = Date()
        coreDataManager.save()
    }
    
    /*
     Returns foods by diet.
     If diet is null return all foods.
     */
    func findFoods(byDiet diet: DietData? = nil) -> [FoodData]? {
        let foodFetchRequest = NSFetchRequest<FoodData>(entityName: "FoodData")
        foodFetchRequest.sortDescriptors = []
        if let diet = diet {
            foodFetchRequest.predicate = NSPredicate(format: "diet == %@", argumentArray: [diet])
        }
        return executeFetchRequest(request: foodFetchRequest)
    }
    
    func findFood(byExternalId id: String?) -> FoodData? {
        var food: FoodData? = nil
        if let id = id {
            let foodFetchRequest = NSFetchRequest<FoodData>(entityName: "FoodData")
            foodFetchRequest.predicate = NSPredicate(format: "externalId == %@", argumentArray: [id])
            if let foods = executeFetchRequest(request: foodFetchRequest), foods.count > 0 {
                food = foods[0]
            }
        }
        return food
    }
    
    func addFood(toDiet diet: DietData, food: FoodData) {
        food.diet = diet
        coreDataManager.save()
    }
    
    func removeFromDiet(food: FoodData) {
        food.diet = nil
        coreDataManager.save()
    }
    
    class func delete(food: FoodData) {
        CoreDataManager.instance.managedObjectContext.delete(food)
        CoreDataManager.instance.save()
    }
    
    private func executeFetchRequest(request: NSFetchRequest<FoodData>) -> [FoodData]? {
        var result: [FoodData]? = nil
        do {
            result = try coreDataManager.managedObjectContext.fetch(request) as [FoodData]
        } catch {
            print (error.localizedDescription)
        }
        return result
    }
    
    
}
