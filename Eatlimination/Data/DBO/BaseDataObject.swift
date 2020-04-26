//
//  BaseDataObject.swift
//  Eatlimination

import Foundation

class BaseDataObject {
    
    var coreDataManager: CoreDataManager
    
    init() {
        coreDataManager = CoreDataManager.instance
    }
    
    func entityName<T>(entity: T.Type) -> String {
        return String(describing: entity.self)
    }
    
}
