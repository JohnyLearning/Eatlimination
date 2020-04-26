//
//  InitialData.swift
//  Eatlimination

import Foundation

class InitialData {
    
    private static let defaults = UserDefaults.standard
    private static let symptomDataObject: SymptomDataObject = DBOProvider.getSymptomDBO()
    private static let USER_DEFAULTS_PARAM = "dataInitialized"
    
    // symptoms
    private static var symptoms = [
        ("100", "High blood pressure", "Common condition in which the long-term force of the blood against your artery walls is high enough that it may eventually cause health problems", "hbp.png"),
        ("200", "Heart rate", "The speed of the heartbeat measured by the number of contractions of the heart per minute", "heartrate.png"),
        ("300", "Headache", "The symptom of pain in the face, head, or neck", "headache.png"),
        ("400", "Tinea Versicolor", "Fungal infection of the skin, caused by a type of yeast that naturally lives on your skin.", "tineaversicolor.png")
    ]
    
    class func initializeSymptomsData() {
        if (defaults.bool(forKey: InitialData.USER_DEFAULTS_PARAM) == false) {
            symptoms.forEach {
                try? symptomDataObject.create(id: $0.0, name: $0.1, description: $0.2, image: $0.3)
            }
            defaults.set(true, forKey: InitialData.USER_DEFAULTS_PARAM)
        }
    }
    
}
