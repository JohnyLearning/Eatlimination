//
//  SymptomDataObject.swift
//  Eatlimination

import Foundation
import CoreData

enum SymptomDataError: Error {
    case SymptomAlreadyExists(String)
}

class SymptomDataObject: BaseDataObject {
    
    func create(id: String, name: String, description: String? = nil, image: String? = nil) throws {
        guard findSymptom(byId: id) == nil else {
            throw SymptomDataError.SymptomAlreadyExists("Symptom already exists.")
        }
        let symptom = SymptomData(context: coreDataManager.managedObjectContext)
        symptom.id = id
        symptom.name = name
        symptom.desc = description
        symptom.imageName = image
        coreDataManager.save()
    }
    
    func findSymptom(byId id: String?) -> SymptomData? {
        var symptom: SymptomData? = nil
        if let id = id {
            let symptomFetchRequest = NSFetchRequest<SymptomData>(entityName: String(describing: SymptomData.self))
            symptomFetchRequest.predicate = NSPredicate(format: "id == %@", argumentArray: [id])
            if let symptoms = executeFetchRequest(request: symptomFetchRequest), symptoms.count > 0 {
                symptom = symptoms[0]
            }
        }
        return symptom
    }
    
    func findSymptoms(byDiet diet: DietData? = nil) -> [SymptomData]? {
        if let diet = diet {
            let symptomFetchRequest = NSFetchRequest<SymptomData>(entityName: String(describing: SymptomData.self))
            symptomFetchRequest.predicate = NSPredicate(format: "diet == %@", argumentArray: [diet])
            if let symptoms = executeFetchRequest(request: symptomFetchRequest), symptoms.count > 0 {
                return symptoms
            }
        }
        return nil
    }
    
    func getAllSymptoms() -> [SymptomData]? {
        let symptomFetchRequest = NSFetchRequest<SymptomData>(entityName: String(describing: SymptomData.self))
        if let symptoms = executeFetchRequest(request: symptomFetchRequest), symptoms.count > 0 {
            return symptoms
        }
        return nil
    }
    
    func addSymptom(toDiet diet: DietData, symptom: SymptomData) {
        symptom.diet = diet
        coreDataManager.save()
    }
    
    func removeFromDiet(symptom: SymptomData) {
        symptom.diet = nil
        coreDataManager.save()
    }
    
    private func executeFetchRequest(request: NSFetchRequest<SymptomData>) -> [SymptomData]? {
        var result: [SymptomData]? = nil
        do {
            result = try coreDataManager.managedObjectContext.fetch(request) as [SymptomData]
        } catch {
            print (error.localizedDescription)
        }
        return result
    }
    
}
