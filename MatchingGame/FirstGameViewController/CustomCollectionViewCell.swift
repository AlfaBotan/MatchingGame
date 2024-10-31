//
//  CustomCollectionViewCell.swift
//  MatchingGame
//
//  Created by Илья Волощик on 30.10.24.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let Identifier = "CustomCollectionViewCell"
    
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "Icon9")
        return imageView
    }()
    
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    var flag: Bool = false
    var image: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addAndSetUpSubviews()
        setUpConstraints()
    }
    
    private func addAndSetUpSubviews() {
        contentView.addSubview(iconView)
        iconView.addSubview(topImageView)
        
        self.isUserInteractionEnabled = true
        contentView.isUserInteractionEnabled = true
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            topImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            iconView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func setUpIconImage(image: UIImage?) {
        iconView.image = image
        self.image = image
    }
    
    func openIcon() {
        if !flag {
            UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [.calculationModeLinear]) {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) {
                    self.topImageView.alpha = 0.8
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
                    self.topImageView.alpha = 0.6
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2) {
                    self.topImageView.alpha = 0.4
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                    self.topImageView.alpha = 0.2
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                    self.topImageView.alpha = 0
                }
            }
            flag = true
        }
    }
    
    func closeIcon() {
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [.calculationModeLinear]) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) {
                self.topImageView.alpha = 0.2
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
                self.topImageView.alpha = 0.4
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2) {
                self.topImageView.alpha = 0.6
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                self.topImageView.alpha = 0.8
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                self.topImageView.alpha = 1
            }
        }
        flag = false
    }
    
    func resetCell() {
        iconView.image = nil
        image = nil
        closeIcon()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

