//
//  SmallStackView.swift
//  WeatherTZ
//
//  Created by Никита Коголенок on 26.12.21.
//

import UIKit

class SmallStackView: UIStackView {
    
    // MARK: - Variables
    private let constantAnchor: CGFloat = 0
    
    // MARK: - GUI Variables
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 17)
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - View Life Cycle
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    convenience init(with type: ImageType) {
        self.init(frame: .zero)
        
        configureSmallStackView(with: type)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods for Constraints and Add subviews
    private func setupConstraints() {
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: constantAnchor).isActive           = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constantAnchor).isActive   = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: constantAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50).isActive                = true
        
        textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: constantAnchor).isActive   = true
        textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constantAnchor).isActive   = true
        textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: constantAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: constantAnchor).isActive     = true
    }
    
    private func setupViews() {
        addSubviews(imageView, textLabel)
    }
}

// MARK: - Extension for SmallStackView
extension SmallStackView {
    func configureSmallStackView(with type: ImageType) {
        let model = SmallStackViewModel.getStackViewDetails(for: type)
        imageView.image = UIImage(systemName: model.imageName)
        textLabel.text = model.textValue
    }
}
