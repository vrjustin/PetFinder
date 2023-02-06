//
//  BreedCell.swift
//  PetFinder
//
//  Created by Justin Maronde on 10/20/22.
//

import Foundation
import UIKit

class BreedCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    
    var viewModel: BreedViewModel? {
        didSet {
            configure()
        }
    }
        
    private let breedImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .yellow
        
        return iv
    }()
    
    internal let breedNameLabel: UILabel = {
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
        contentView.backgroundColor = .yellow
        
        contentView.addSubview(breedImageView)
        breedImageView.setDimensions(height: 48, width: 48)
        breedImageView.layer.cornerRadius = 48 / 2
        breedImageView.centerY(inView: self.contentView)
        breedImageView.anchor(left: contentView.leftAnchor, paddingLeft: 8)
        
        contentView.addSubview(breedNameLabel)
        breedNameLabel.centerY(inView: breedImageView, leftAnchor: breedImageView.rightAnchor, paddingLeft: 8)
        breedNameLabel.anchor(right: contentView.rightAnchor, paddingLeft: 4)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - HELPERS
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        
        let placeHolderImage = UIImage(named: "DogImage-Placeholder")
        breedImageView.image = placeHolderImage
        
        breedNameLabel.text = viewModel.name
    }
    
}
