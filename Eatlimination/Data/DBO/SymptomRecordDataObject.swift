//
//  SymptomRecordDataObject.swift
//  Eatlimination

import Foundation
import CoreData

enum SymptomRecordCategory: Int16 {
    case green
    case yellow
    case red
}

class SymptomRecordDataObject: BaseDataObject {
    
    func create(value: String, category: SymptomRecordCategory, symptom: SymptomData) {
        let symptomRecord = SymptomRecordData(context: coreDataManager.managedObjectContext)
        symptomRecord.value = value
        symptomRecord.category = category.rawValue
        symptomRecord.timestamp = Date()
        symptomRecord.symptom = symptom
        coreDataManager.save()
    }
    
    func findRecords(bySymptom symptom: SymptomData?) -> [SymptomRecordData]? {
        if let symptom = symptom {
            let recordFetchRequest = NSFetchRequest<SymptomRecordData>(entityName: String(describing: SymptomRecordData.self))
            recordFetchRequest.predicate = NSPredicate(format: "symptom == %@", argumentArray: [symptom])
            if let records = executeFetchRequest(request: recordFetchRequest), records.count > 0 {
                return records
            }
        }
        return nil
    }
    
    private func executeFetchRequest(request: NSFetchRequest<SymptomRecordData>) -> [SymptomRecordData]? {
        var result: [SymptomRecordData]? = nil
        do {
            result = try coreDataManager.managedObjectContext.fetch(request) as [SymptomRecordData]
        } catch {
            print (error.localizedDescription)
        }
        return result
    }
    
}
