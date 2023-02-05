//
//  AnimalCell.swift
//  PetFinder
//
//  Created by Justin Maronde on 2/5/23.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class AnimalCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    
    var viewModel: AnimalViewModel? {
        didSet {
            configure()
        }
    }
    
    private let smallImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .yellow
        
        iv.image = UIImage(named: "DogImage-Placeholder")
        return iv
    }()
    
    private let animalNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name: "
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let animalNameValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Animal Name HERE"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let adoptableStatusValueLabel: UILabel = {
        let label = UILabel()
        label.text = "not adoptable"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    
    // MARK: - LIFECYCLE
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        //TODO: Remove Debugging color..
        contentView.backgroundColor = .cyan
        
        contentView.addSubview(smallImageView)
        smallImageView.setDimensions(height: 84, width: 84)
        smallImageView.centerY(inView: contentView, leftAnchor: contentView.leftAnchor, paddingLeft: 8)
        
        contentView.addSubview(animalNameLabel)
        animalNameLabel.anchor(top: contentView.topAnchor, left: smallImageView.rightAnchor, paddingTop: 8, paddingLeft: 8)
        contentView.addSubview(animalNameValueLabel)
        animalNameValueLabel.anchor(top: contentView.topAnchor, left: animalNameLabel.rightAnchor, paddingTop: 8, paddingLeft: 8)
        
        contentView.addSubview(adoptableStatusValueLabel)
        adoptableStatusValueLabel.anchor(top: animalNameLabel.bottomAnchor, left: smallImageView.rightAnchor, paddingLeft: 8)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - HELPERS
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        
        animalNameValueLabel.text = viewModel.name
        adoptableStatusValueLabel.text = viewModel.adoptableStatus
        
        ////move to a new function.
        guard let imageURLStr = viewModel.smallPhoto else { return }
        
        AF.request(imageURLStr).responseImage { response in
            if case .success(let image) = response.result {
                self.smallImageView.image = image
            }
        }
        ////
        
    }
}
