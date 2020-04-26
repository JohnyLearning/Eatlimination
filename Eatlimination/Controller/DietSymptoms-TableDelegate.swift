//
//  DietSymptoms-TableDelegate.swift
//  Eatlimination

import Foundation
import UIKit

extension DietSymptomsController: UITableViewDelegate, UITableViewDataSource, OnComplete {
    
    func execute() {
        symptomsTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symptoms?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DietSymptomCell.self), for: indexPath) as? DietSymptomCell else {
            fatalError("Unexpected Index Path")
        }

        if let symptom = symptoms?[indexPath.row] {
            cell.name.text = symptom.name
            cell.selectionStyle = .none
            if let imageName = symptom.imageName {
                cell.symptomImage.image = UIImage(named: imageName)
            }
            cell.createRecord.tag = indexPath.row
            cell.createRecord.addTarget(self, action: #selector(addSymptomRecord(sender:)), for: .touchUpInside)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let symptom = symptoms?[indexPath.row] {
            showSymptomRecordings(symptom: symptom)
        }
    }
    
    @objc private func showSymptomRecordings(symptom: SymptomData) {
        performSegue(withIdentifier: "showSymptomRecordings", sender: symptom)
    }
    
    @objc private func addSymptomRecord(sender: UIButton) {
        if let symptom = symptoms?[sender.tag] {
            performSegue(withIdentifier: "showSymptomDetail", sender: symptom)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSymptomDetail", let symptomDetailController = segue.destination as? SymptomDetailController, let symptom = sender as? SymptomData {
            symptomDetailController.onCompleteDelegate = self
            symptomDetailController.prepare(symptom: symptom)
        } else if let addSymptomController = segue.destination as? AddSymptomsController {
            addSymptomController.onCompleteDelegate = self
        } else if segue.identifier == "showSymptomRecordings", let symptomRecordingsController = segue.destination as? SymptomRecordingsController, let symptom = sender as? SymptomData {
            symptomRecordingsController.symptom = symptom
        }
    }
    
    
}
