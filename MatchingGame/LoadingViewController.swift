//
//  ViewController.swift
//  MatchingGame
//
//  Created by Илья Волощик on 29.10.24.
//

import UIKit

class LoadingViewController: UIViewController {
    private lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BackImage")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var startsImageViews: [UIImageView] = {
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
    
    private lazy var loadlable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 20)
        lable.textColor = .white
        lable.textAlignment = .center
        lable.text = "Loading..."
        return lable
    }()
    
    private lazy var flameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Flame")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        addConstraint()
        startFlashingAnimation()
        navigateToMainMenuAfterDelay()
    }
    
    private func configViews() {
        view.addSubview(backImageView)
        startsImageViews.forEach { backImageView.addSubview($0) }
        [loadlable, lemonImageView, orangeImageView, cherryImageView, grapeImageView, flameImageView].forEach { backImageView.addSubview($0) }
    }
    
    private func addConstraint() {
        
        NSLayoutConstraint.activate([
            backImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            loadlable.centerXAnchor.constraint(equalTo: backImageView.centerXAnchor),
            loadlable.centerYAnchor.constraint(equalTo: backImageView.centerYAnchor),
            
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
        ])
        
        for (index, starsView) in startsImageViews.enumerated() {
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
            
            startsImageViews[2].transform = CGAffineTransform(rotationAngle: .pi)
        }
    }
    
    func startFlashingAnimation() {
        UIView.animateKeyframes(withDuration: 2.0, delay: 0, options: [.repeat, .calculationModeLinear]) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) {
                self.flameImageView.alpha = 1.0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
                self.flameImageView.alpha = 0.65
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2) {
                self.flameImageView.alpha = 0.3
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                self.flameImageView.alpha = 0.65
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                self.flameImageView.alpha = 1.0
            }
        }
        
        
    }
    
    func navigateToMainMenuAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.navigateToMainMenu()
            self.flameImageView.layer.removeAllAnimations()
        }
    }
    
    func navigateToMainMenu() {
        
    }
}

