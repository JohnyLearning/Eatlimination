//
//  DietSymptomsController.swift
//  Eatlimination

import Foundation
import UIKit

class DietSymptomsController: BaseDietDetailsTabBarController {
    
    var symptoms: [SymptomData]? = nil
    
    @IBOutlet weak var symptomsTable: UITableView!
    
    override func viewDidLoad() {
        loadSymptoms()
        symptomsTable.delegate = self
        symptomsTable.dataSource = self
        symptomsTable.separatorStyle = .none
    }
    
    private func loadSymptoms() {
        symptoms = symptomDataObject.findSymptoms(byDiet: dietDataObject.getActiveDiet())
    }
    
    @IBAction func goBack(_ sender: Any) {
        super.goBack()
    }
}

extension DietSymptomsController: RefreshList {
    func refresh(doit: Bool) {
        if doit {
            loadSymptoms()
            symptomsTable.reloadData()
        }
    }
}
