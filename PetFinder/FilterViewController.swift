//
//  FilterViewController.swift
//  PetFinder
//
//  Created by Justin Maronde on 2/13/23.
//

import Foundation
import UIKit

class FilterViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    private let zipCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Zipcode: "
        label.setHeight(48)
        label.backgroundColor = .yellow
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let zipCodeTextFieldValue: UITextField = {
        let tf = UITextField()
        tf.placeholder = "48188"
        tf.setDimensions(height: 48, width: 160)
        tf.backgroundColor = .gray
        return tf
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Search Distance: "
        label.setHeight(48)
        label.backgroundColor = .yellow
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let distanceSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 25
        slider.isContinuous = true
        slider.tintColor = .systemBlue
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return slider
    }()
    
    // MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - HELPERS
    
    private func setupUI() {
        view.backgroundColor = .green
        configureSearchFields()
    }

    private func configureSearchFields() {
        print("configureSearchFields")
        
        view.addSubview(zipCodeLabel)
        zipCodeLabel.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 32, paddingLeft: 16)
        
        view.addSubview(zipCodeTextFieldValue)
        zipCodeTextFieldValue.anchor(top: view.topAnchor, left: zipCodeLabel.rightAnchor, right: view.rightAnchor ,paddingTop: 32, paddingLeft: 8, paddingRight: 16)
        
        view.addSubview(distanceLabel)
        distanceLabel.anchor(top: zipCodeLabel.bottomAnchor, left: view.leftAnchor, paddingTop: 32, paddingLeft: 16)
        
        view.addSubview(distanceSlider)
        distanceSlider.anchor(top: distanceLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
    }
    
    // MARK: - ACTIONS
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        let value = sender.value
        //Send a notification to our observer that the value has changed.
        NotificationCenter.default.post(name: AnimalsViewController.filterValueChanged, object: value)
    }


}
