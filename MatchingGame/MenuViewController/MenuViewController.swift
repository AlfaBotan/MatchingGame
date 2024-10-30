//
//  MenuViewController.swift
//  MatchingGame
//
//  Created by Илья Волощик on 29.10.24.
//

import UIKit
import SafariServices

final class MenuViewController: UIViewController {
    
    private lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BackImage")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var starsImageViews: [UIImageView] = {
        return (0..<3).map { _ in
            let imageView = UIImageView(image: UIImage(named: "Stars"))
            imageView.contentMode = .scaleToFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }
    }()
    
    private lazy var lemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Lemon")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var orangeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Orange")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var cherryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Cherry")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var grapeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Grape")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var hatImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Hat")
        return imageView
    }()
    
    private lazy var flameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Flame")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var firstGameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.5
        button.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        button.addTarget(self, action: #selector(firstGameButtonPress), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var bottomShadowViewForGame: UIView = {
        let shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.layer.masksToBounds = true
        shadowView.layer.cornerRadius = 5
        return shadowView
    }()
    
    private lazy var middleShadowViewForGame: UIView = {
        let shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.layer.masksToBounds = true
        shadowView.layer.cornerRadius = 5
        return shadowView
    }()
    
    private lazy var topShadowViewForGame: UIView = {
        let shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.layer.masksToBounds = true
        shadowView.layer.cornerRadius = 5
        return shadowView
    }()
    
    private lazy var gameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        let customFont = UIFont(name: "Multiround Pro", size: 20)
        label.font = customFont
        label.textAlignment = .center
        label.text = "GAME #1"
        return label
    }()
    
    private lazy var privacyPolicyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 7.5
        button.layer.borderWidth = 1.5
        button.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        button.addTarget(self, action: #selector(openPrivacyPolicy), for: .touchUpInside)
        button.setTitle("PRIVACY POLICY", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Multiround Pro", size: 12)
        return button
    }()
    
    private lazy var bottomShadowViewForPrivacy: UIView = {
        let shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.layer.masksToBounds = true
        shadowView.layer.cornerRadius = 5
        return shadowView
    }()
    
    private lazy var middleShadowViewForPrivacy: UIView = {
        let shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.layer.masksToBounds = true
        shadowView.layer.cornerRadius = 5
        return shadowView
    }()
    
    private lazy var topShadowViewForPrivacy: UIView = {
        let shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.layer.masksToBounds = true
        shadowView.layer.cornerRadius = 5
        return shadowView
    }()
    
    private let bottomGradientLayerForGame = CAGradientLayer()
    private let middleGradientLayerForGame = CAGradientLayer()
    private let topGradientLayerForGame = CAGradientLayer()
    private let bottomGradientLayerForPrivacyPolicy = CAGradientLayer()
    private let middleGradientLayerForPrivacyPolicy = CAGradientLayer()
    private let topGradientLayerForPrivacyPolicy = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        addConstraint()
        addGradients()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bottomGradientLayerForGame.frame = bottomShadowViewForGame.bounds
        middleGradientLayerForGame.frame = middleShadowViewForGame.bounds
        topGradientLayerForGame.frame = topShadowViewForGame.bounds
        
        bottomGradientLayerForPrivacyPolicy.frame = bottomShadowViewForPrivacy.bounds
        middleGradientLayerForPrivacyPolicy.frame = middleShadowViewForPrivacy.bounds
        topGradientLayerForPrivacyPolicy.frame = topShadowViewForPrivacy.bounds
    }
    
    private func configViews() {
        view.addSubview(backImageView)
        starsImageViews.forEach { backImageView.addSubview($0) }
        
        [lemonImageView,
         orangeImageView,
         cherryImageView,
         grapeImageView,
         flameImageView,
         hatImageView].forEach { backImageView.addSubview($0) }
        
        [bottomShadowViewForGame,
         middleShadowViewForGame,
         topShadowViewForGame,
         gameLabel,
         firstGameButton,
         bottomShadowViewForPrivacy,
         middleShadowViewForPrivacy,
         topShadowViewForPrivacy,
         privacyPolicyButton].forEach { view.addSubview($0) }
    }
    
    private func addConstraint() {
        
        NSLayoutConstraint.activate([
            backImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            lemonImageView.widthAnchor.constraint(equalToConstant: 50),
            lemonImageView.heightAnchor.constraint(equalToConstant: 55),
            lemonImageView.leadingAnchor.constraint(equalTo: backImageView.leadingAnchor, constant: 25),
            lemonImageView.bottomAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: -250),
            
            orangeImageView.widthAnchor.constraint(equalToConstant: 95),
            orangeImageView.heightAnchor.constraint(equalToConstant: 80),
            orangeImageView.trailingAnchor.constraint(equalTo: backImageView.trailingAnchor),
            orangeImageView.bottomAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: -70),
            
            cherryImageView.widthAnchor.constraint(equalToConstant: 130),
            cherryImageView.heightAnchor.constraint(equalToConstant: 120),
            cherryImageView.trailingAnchor.constraint(equalTo: backImageView.trailingAnchor),
            cherryImageView.bottomAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: -330),
            
            grapeImageView.widthAnchor.constraint(equalToConstant: 90),
            grapeImageView.heightAnchor.constraint(equalToConstant: 85),
            grapeImageView.trailingAnchor.constraint(equalTo: backImageView.trailingAnchor, constant: -40),
            grapeImageView.topAnchor.constraint(equalTo: backImageView.topAnchor, constant: 90),
            
            flameImageView.widthAnchor.constraint(equalToConstant: 330),
            flameImageView.heightAnchor.constraint(equalToConstant: 460),
            flameImageView.centerXAnchor.constraint(equalTo: backImageView.centerXAnchor),
            flameImageView.topAnchor.constraint(equalTo: backImageView.topAnchor, constant: -50),
            
            hatImageView.widthAnchor.constraint(equalToConstant: 360),
            hatImageView.heightAnchor.constraint(equalToConstant: 360),
            hatImageView.centerXAnchor.constraint(equalTo: backImageView.centerXAnchor),
            hatImageView.topAnchor.constraint(equalTo: backImageView.topAnchor, constant: 150),
            
            bottomShadowViewForGame.widthAnchor.constraint(equalToConstant: 194),
            bottomShadowViewForGame.heightAnchor.constraint(equalToConstant: 50),
            bottomShadowViewForGame.centerXAnchor.constraint(equalTo: backImageView.centerXAnchor),
            bottomShadowViewForGame.topAnchor.constraint(equalTo: hatImageView.bottomAnchor, constant: 0),
            
            middleShadowViewForGame.widthAnchor.constraint(equalToConstant: 176),
            middleShadowViewForGame.heightAnchor.constraint(equalToConstant: 50),
            middleShadowViewForGame.centerXAnchor.constraint(equalTo: backImageView.centerXAnchor),
            middleShadowViewForGame.topAnchor.constraint(equalTo: hatImageView.bottomAnchor, constant: 0),
            
            topShadowViewForGame.widthAnchor.constraint(equalToConstant: 150),
            topShadowViewForGame.heightAnchor.constraint(equalToConstant: 50),
            topShadowViewForGame.centerXAnchor.constraint(equalTo: backImageView.centerXAnchor),
            topShadowViewForGame.topAnchor.constraint(equalTo: hatImageView.bottomAnchor, constant: 0),
            
            gameLabel.widthAnchor.constraint(equalToConstant: 150),
            gameLabel.heightAnchor.constraint(equalToConstant: 50),
            gameLabel.centerXAnchor.constraint(equalTo: backImageView.centerXAnchor),
            gameLabel.topAnchor.constraint(equalTo: hatImageView.bottomAnchor, constant: 0),
            
            firstGameButton.widthAnchor.constraint(equalToConstant: 210),
            firstGameButton.heightAnchor.constraint(equalToConstant: 60),
            firstGameButton.centerXAnchor.constraint(equalTo: bottomShadowViewForGame.centerXAnchor),
            firstGameButton.centerYAnchor.constraint(equalTo: bottomShadowViewForGame.centerYAnchor),
            
            bottomShadowViewForPrivacy.widthAnchor.constraint(equalToConstant: 155),
            bottomShadowViewForPrivacy.heightAnchor.constraint(equalToConstant: 30),
            bottomShadowViewForPrivacy.centerXAnchor.constraint(equalTo: backImageView.centerXAnchor),
            bottomShadowViewForPrivacy.centerYAnchor.constraint(equalTo: firstGameButton.centerYAnchor, constant: 70),
            
            middleShadowViewForPrivacy.widthAnchor.constraint(equalToConstant: 140),
            middleShadowViewForPrivacy.heightAnchor.constraint(equalToConstant: 30),
            middleShadowViewForPrivacy.centerXAnchor.constraint(equalTo: backImageView.centerXAnchor),
            middleShadowViewForPrivacy.centerYAnchor.constraint(equalTo: firstGameButton.centerYAnchor, constant: 70),
            
            topShadowViewForPrivacy.widthAnchor.constraint(equalToConstant: 115),
            topShadowViewForPrivacy.heightAnchor.constraint(equalToConstant: 30),
            topShadowViewForPrivacy.centerXAnchor.constraint(equalTo: backImageView.centerXAnchor),
            topShadowViewForPrivacy.centerYAnchor.constraint(equalTo: firstGameButton.centerYAnchor, constant: 70),
            
            privacyPolicyButton.widthAnchor.constraint(equalToConstant: 165),
            privacyPolicyButton.heightAnchor.constraint(equalToConstant: 30),
            privacyPolicyButton.centerXAnchor.constraint(equalTo: bottomShadowViewForPrivacy.centerXAnchor),
            privacyPolicyButton.centerYAnchor.constraint(equalTo: bottomShadowViewForPrivacy.centerYAnchor)
        ])
        
        for (index, starsView) in starsImageViews.enumerated() {
            NSLayoutConstraint.activate([
                starsView.heightAnchor.constraint(equalToConstant: 225),
                starsView.widthAnchor.constraint(equalToConstant: 350)
            ])
            
            if index == 0 {
                NSLayoutConstraint.activate([
                    starsView.leadingAnchor.constraint(equalTo: backImageView.leadingAnchor, constant: -30),
                    starsView.bottomAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: -100)
                ])
            } else if index == 1 {
                NSLayoutConstraint.activate([
                    starsView.leadingAnchor.constraint(equalTo: backImageView.leadingAnchor, constant: -120),
                    starsView.topAnchor.constraint(equalTo: backImageView.topAnchor, constant: 50)
                ])
            } else if index == 2 {
                NSLayoutConstraint.activate([
                    starsView.trailingAnchor.constraint(equalTo: backImageView.trailingAnchor, constant: 30),
                    starsView.topAnchor.constraint(equalTo: backImageView.topAnchor, constant: 275)
                ])
            }
            
            starsImageViews[2].transform = CGAffineTransform(rotationAngle: .pi)
        }
    }
    
    private func addGradients() {
        bottomGradientLayerForGame.colors = [
            UIColor(red: 0/255, green: 148/255, blue: 255/255, alpha: 0.4).cgColor,
            UIColor(red: 0/255, green: 45/255, blue: 87/255, alpha: 0.4).cgColor
        ]
        bottomGradientLayerForGame.startPoint = CGPoint(x: 0.5, y: 0.0)
        bottomGradientLayerForGame.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        bottomShadowViewForGame.layer.insertSublayer(bottomGradientLayerForGame, at: 0)
        
        middleGradientLayerForGame.colors = [
            UIColor(red: 0/255, green: 148/255, blue: 255/255, alpha: 0.5).cgColor,
            UIColor(red: 0/255, green: 45/255, blue: 87/255, alpha: 0.5).cgColor
        ]
        middleGradientLayerForGame.startPoint = CGPoint(x: 0.5, y: 0.0)
        middleGradientLayerForGame.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        middleShadowViewForGame.layer.insertSublayer(middleGradientLayerForGame, at: 0)
        
        topGradientLayerForGame.colors = [
            UIColor(red: 0/255, green: 148/255, blue: 255/255, alpha: 1).cgColor,
            UIColor(red: 0/255, green: 45/255, blue: 87/255, alpha: 1).cgColor
        ]
        topGradientLayerForGame.startPoint = CGPoint(x: 0.5, y: 0.0)
        topGradientLayerForGame.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        topShadowViewForGame.layer.insertSublayer(topGradientLayerForGame, at: 0)
        
        //
        
        bottomGradientLayerForPrivacyPolicy.colors = [
            UIColor(red: 255/255, green: 0/255, blue: 3/255, alpha: 0.4).cgColor,
            UIColor(red: 87/255, green: 0/255, blue: 1/255, alpha: 0.4).cgColor
        ]
        bottomGradientLayerForPrivacyPolicy.startPoint = CGPoint(x: 0.5, y: 0.0)
        bottomGradientLayerForPrivacyPolicy.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        bottomShadowViewForPrivacy.layer.insertSublayer(bottomGradientLayerForPrivacyPolicy, at: 0)
        
        middleGradientLayerForPrivacyPolicy.colors = [
            UIColor(red: 255/255, green: 0/255, blue: 3/255, alpha: 0.5).cgColor,
            UIColor(red: 87/255, green: 0/255, blue: 1/255, alpha: 0.5).cgColor
        ]
        middleGradientLayerForPrivacyPolicy.startPoint = CGPoint(x: 0.5, y: 0.0)
        middleGradientLayerForPrivacyPolicy.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        middleShadowViewForPrivacy.layer.insertSublayer(middleGradientLayerForPrivacyPolicy, at: 0)
        
        topGradientLayerForPrivacyPolicy.colors = [
            UIColor(red: 255/255, green: 0/255, blue: 3/255, alpha: 1).cgColor,
            UIColor(red: 87/255, green: 0/255, blue: 1/255, alpha: 1).cgColor
        ]
        topGradientLayerForPrivacyPolicy.startPoint = CGPoint(x: 0.5, y: 0.0)
        topGradientLayerForPrivacyPolicy.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        topShadowViewForPrivacy.layer.insertSublayer(topGradientLayerForPrivacyPolicy, at: 0)
    }
    
    @objc
    private func firstGameButtonPress() {
        print("Game")
    }
    
    @objc
    private func openPrivacyPolicy() {
        guard let url = URL(string: "https://www.linkedin.com/company/rooh-co/") else { return }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        
        navigationController?.pushViewController(safariVC, animated: true)
    }
}

extension MenuViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        navigationController?.popViewController(animated: true)
    }
}
