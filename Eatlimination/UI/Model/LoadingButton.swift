//
//  LoadingButton.swift
//  Eatlimination
//  Reference: https://stackoverflow.com/questions/36539650/display-activity-indicator-inside-uibutton

import Foundation
import UIKit

class LoadingButton: UIButton {
    
    var originalButtonText: String?
    var originalImage: UIImage?
    var originalTint: UIColor?
    var activityIndicator: UIActivityIndicatorView!

    func showLoading() {
        originalButtonText = titleLabel?.text
        originalImage = imageView?.image
        originalTint = imageView?.tintColor
        setTitle("", for: .normal)
        setImage(nil, for: .normal)

        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }

        showSpinning()
    }

    func hideLoading(image: UIImage? = nil, tintColor: UIColor? = nil) {
        setTitle(originalButtonText, for: .normal)
        if let image = image {
            setImage(image, for: .normal)
            self.tintColor = tintColor ?? originalTint
        } else {
            setImage(originalImage, for: .normal)
            self.tintColor = originalTint
        }
        activityIndicator.stopAnimating()
    }

    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .lightGray
        return activityIndicator
    }

    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        addConstraint(xCenterConstraint)

        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        addConstraint(yCenterConstraint)
    }

}
