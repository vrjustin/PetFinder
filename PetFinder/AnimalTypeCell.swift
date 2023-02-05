//
//  AnimalTypeCell.swift
//  PetFinder
//
//  Created by Justin Maronde on 10/18/22.
//

import Foundation
import UIKit

class AnimalTypeCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    
    var viewModel: AnimalTypeViewModel? {
        didSet {
            configure()
        }
    }
        
    internal let animalTypeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .yellow
        
        return iv
    }()
    
    internal let animalTypeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    // MARK: - LIFECYCLE
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        //TODO: remove debugging color..
        contentView.backgroundColor = .green
        
        contentView.addSubview(animalTypeImageView)
        animalTypeImageView.setDimensions(height: 48, width: 48)
        animalTypeImageView.layer.cornerRadius = 48 / 2
        animalTypeImageView.centerY(inView: self.contentView)
        animalTypeImageView.anchor(left: contentView.leftAnchor, paddingLeft: 8)
        
        contentView.addSubview(animalTypeLabel)
        animalTypeLabel.centerY(inView: animalTypeImageView, leftAnchor: animalTypeImageView.rightAnchor, paddingLeft: 8)
        animalTypeLabel.anchor(right: contentView.rightAnchor, paddingLeft: 4)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - HELPERS
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        
        animalTypeImageView.image = viewModel.image
        animalTypeLabel.text = viewModel.name
    }
}
