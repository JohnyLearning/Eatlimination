//
//  AddSymptomsController-TableDelegate.swift
//  Eatlimination

import Foundation
import UIKit

extension AddSymptomsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symptoms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AddSymptomCell.self)) as! AddSymptomCell
        
        let symptomInfo = symptoms[indexPath.row]
        cell.symptomAddAction.tag = indexPath.row
        cell.name.text = symptomInfo.name
        cell.selectionStyle = .none
        if let imageName = symptomInfo.imageName {
            cell.symptomImage.image = UIImage(named: imageName)
        }
        var addToDietIcon: String
        var addToDietTint: UIColor
        if let _ = symptomInfo.diet {
            addToDietIcon = "bookmark.fill"
            addToDietTint = UIColor.systemGreen
            cell.symptomAddAction.addTarget(self, action: #selector(removeSymptomFromDiet(sender:)), for: .touchUpInside)
        } else {
            addToDietIcon = "bookmark"
            addToDietTint = UIColor.systemRed
            cell.symptomAddAction.addTarget(self, action: #selector(addSymptomToDiet(sender:)), for: .touchUpInside)
        }
        cell.symptomAddAction.setImage(UIImage(systemName: addToDietIcon), for: .normal)
        cell.symptomAddAction.tintColor = addToDietTint
        
        return cell
    }
    
    @objc private func addSymptomToDiet(sender: UIButton) {
        if let activeDiet = dietDataObject.loadOrCreateDiet(), let button = sender as? LoadingButton {
            button.showLoading()
            DispatchQueue.main.async {
                self.symptomDataObject.addSymptom(toDiet: activeDiet, symptom: self.symptoms[sender.tag])
                button.hideLoading(image: UIImage(systemName: "bookmark.fill"), tintColor: .systemGreen)
                self.changesMade = true
            }
        }
    }
    
    @objc private func removeSymptomFromDiet(sender: UIButton) {
        if let button = sender as? LoadingButton {
            button.showLoading()
            DispatchQueue.main.async {
                self.symptomDataObject.removeFromDiet(symptom: self.symptoms[sender.tag])
                button.hideLoading(image: UIImage(systemName: "bookmark"), tintColor: .systemRed)
                self.changesMade = true
            }
        }
    }
    
}
