//
//  SettingViewController.swift
//  MatchingGame
//
//  Created by Илья Волощик on 31.10.24.
//

import UIKit

final class SettingViewController: UIViewController {
    
    private lazy var frameForSettings: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "FrameForSettings")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var resumeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 7.5
        button.layer.borderWidth = 1.5
        button.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        button.addTarget(self, action: #selector(resumeTapped), for: .touchUpInside)
        button.setTitle("RESUME", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Multiround Pro", size: 20)
        return button
    }()
    
    private lazy var bottomShadowViewForResume: UIView = {
        let shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.layer.masksToBounds = true
        shadowView.layer.cornerRadius = 5
        return shadowView
    }()
    
    private lazy var middleShadowViewForResume: UIView = {
        let shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.layer.masksToBounds = true
        shadowView.layer.cornerRadius = 5
        return shadowView
    }()
    
    private lazy var topShadowViewForResume: UIView = {
        let shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.layer.masksToBounds = true
        shadowView.layer.cornerRadius = 5
        return shadowView
    }()
    
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 7.5
        button.layer.borderWidth = 1.5
        button.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        button.addTarget(self, action: #selector(goToMenuTapped), for: .touchUpInside)
        button.setTitle("MAIN MENU", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Multiround Pro", size: 20)
        return button
    }()
    
    private lazy var bottomShadowViewForMenu: UIView = {
        let shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.layer.masksToBounds = true
        shadowView.layer.cornerRadius = 5
        return shadowView
    }()
    
    private lazy var middleShadowViewForMenu: UIView = {
        let shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.layer.masksToBounds = true
        shadowView.layer.cornerRadius = 5
        return shadowView
    }()
    
    private lazy var topShadowViewForMenu: UIView = {
        let shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.layer.masksToBounds = true
        shadowView.layer.cornerRadius = 5
        return shadowView
    }()
    
    private let delegate: GoToMenuDelegate
    private var actionButtons: [UIButton] = []
    private var gradientViews: [UIView] = []
    private let gradientLayerForButtons = CAGradientLayer()
    private let bottomGradientLayerForResume = CAGradientLayer()
    private let middleGradientLayerForResume = CAGradientLayer()
    private let topGradientLayerForResume = CAGradientLayer()
    private let bottomGradientLayerForMenu = CAGradientLayer()
    private let middleGradientLayerForMenu = CAGradientLayer()
    private let topGradientLayerForMenu = CAGradientLayer()
    
    private let onIcons: [String] = ["volume.2.fill",
                                    "iphone.gen1.radiowaves.left.and.right"]
    private let offIcons: [String] = ["volume.slash.fill",
                                    "iphone.gen1"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        configViews()
        setUpConstraints()
        addGradient()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in gradientViews {
            if let gradientLayer = view.layer.sublayers?.first as? CAGradientLayer {
                gradientLayer.frame = view.bounds
            }
        }
        
        bottomGradientLayerForResume.frame = bottomShadowViewForResume.bounds
        middleGradientLayerForResume.frame = middleShadowViewForResume.bounds
        topGradientLayerForResume.frame = topShadowViewForResume.bounds
        
        bottomGradientLayerForMenu.frame = bottomShadowViewForMenu.bounds
        middleGradientLayerForMenu.frame = middleShadowViewForMenu.bounds
        topGradientLayerForMenu.frame = topShadowViewForMenu.bounds
    }
    
    init(delegate: GoToMenuDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configViews(){
        view.addSubview(frameForSettings)
        [bottomShadowViewForResume,
         middleShadowViewForResume,
         topShadowViewForResume,
         resumeButton,
         bottomShadowViewForMenu,
         middleShadowViewForMenu,
         topShadowViewForMenu,
         menuButton].forEach({view.addSubview($0)})
        
        for _ in 0..<2 {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = 7
            view.layer.masksToBounds = true
            view.widthAnchor.constraint(equalToConstant: 40).isActive = true
            view.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            gradientViews.append(view)
            self.view.addSubview(view)
        }
        
        for _ in 0..<2 {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tintColor = .white
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
            button.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
            button.layer.borderWidth = 2
            button.widthAnchor.constraint(equalToConstant: 52.5).isActive = true
            button.heightAnchor.constraint(equalToConstant: 52.5).isActive = true
            actionButtons.append(button)
            view.addSubview(button)
        }
        
        let isSoundOn = UserDefaults.standard.bool(forKey: "isSoundOn")
        var icons: [String] = []
        if isSoundOn {
            icons = onIcons
        } else {
            icons = offIcons
        }
        let actions: [Selector] = [#selector(toogleSound),
                                   #selector(toogleVibration)]
        
        for (index, button) in actionButtons.enumerated() {
            button.setImage(UIImage(systemName: icons[index])?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 16, weight: .heavy)), for: .normal)
            button.addTarget(self, action: actions[index], for: .touchUpInside)
        }
    }
    
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
            frameForSettings.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10),
            frameForSettings.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            frameForSettings.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            frameForSettings.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250),
            
            gradientViews[0].trailingAnchor.constraint(equalTo: frameForSettings.centerXAnchor, constant: -50),
            gradientViews[0].topAnchor.constraint(equalTo: frameForSettings.centerYAnchor, constant: 30),
            
            gradientViews[1].leadingAnchor.constraint(equalTo: frameForSettings.centerXAnchor, constant: 50),
            gradientViews[1].topAnchor.constraint(equalTo: gradientViews[0].topAnchor),
            
            actionButtons[0].centerXAnchor.constraint(equalTo: gradientViews[0].centerXAnchor),
            actionButtons[0].centerYAnchor.constraint(equalTo: gradientViews[0].centerYAnchor),
            
            actionButtons[1].centerXAnchor.constraint(equalTo: gradientViews[1].centerXAnchor),
            actionButtons[1].centerYAnchor.constraint(equalTo: gradientViews[1].centerYAnchor),
            
            bottomShadowViewForResume.centerXAnchor.constraint(equalTo: frameForSettings.centerXAnchor),
            bottomShadowViewForResume.centerYAnchor.constraint(equalTo: frameForSettings.topAnchor, constant: 90),
            bottomShadowViewForResume.widthAnchor.constraint(equalToConstant: 194),
            bottomShadowViewForResume.heightAnchor.constraint(equalToConstant: 50),
            
            middleShadowViewForResume.centerXAnchor.constraint(equalTo: bottomShadowViewForResume.centerXAnchor),
            middleShadowViewForResume.centerYAnchor.constraint(equalTo: bottomShadowViewForResume.centerYAnchor),
            middleShadowViewForResume.widthAnchor.constraint(equalToConstant: 176),
            middleShadowViewForResume.heightAnchor.constraint(equalToConstant: 50),
            
            topShadowViewForResume.centerXAnchor.constraint(equalTo: bottomShadowViewForResume.centerXAnchor),
            topShadowViewForResume.centerYAnchor.constraint(equalTo: bottomShadowViewForResume.centerYAnchor),
            topShadowViewForResume.widthAnchor.constraint(equalToConstant: 150),
            topShadowViewForResume.heightAnchor.constraint(equalToConstant: 50),
            
            resumeButton.widthAnchor.constraint(equalToConstant: 210),
            resumeButton.heightAnchor.constraint(equalToConstant: 60),
            resumeButton.centerXAnchor.constraint(equalTo: bottomShadowViewForResume.centerXAnchor),
            resumeButton.centerYAnchor.constraint(equalTo: bottomShadowViewForResume.centerYAnchor),
            
            bottomShadowViewForMenu.centerXAnchor.constraint(equalTo: frameForSettings.centerXAnchor),
            bottomShadowViewForMenu.centerYAnchor.constraint(equalTo: frameForSettings.topAnchor, constant: 180),
            bottomShadowViewForMenu.widthAnchor.constraint(equalToConstant: 194),
            bottomShadowViewForMenu.heightAnchor.constraint(equalToConstant: 50),
            
            middleShadowViewForMenu.centerXAnchor.constraint(equalTo: bottomShadowViewForMenu.centerXAnchor),
            middleShadowViewForMenu.centerYAnchor.constraint(equalTo: bottomShadowViewForMenu.centerYAnchor),
            middleShadowViewForMenu.widthAnchor.constraint(equalToConstant: 176),
            middleShadowViewForMenu.heightAnchor.constraint(equalToConstant: 50),
            
            topShadowViewForMenu.centerXAnchor.constraint(equalTo: bottomShadowViewForMenu.centerXAnchor),
            topShadowViewForMenu.centerYAnchor.constraint(equalTo: bottomShadowViewForMenu.centerYAnchor),
            topShadowViewForMenu.widthAnchor.constraint(equalToConstant: 150),
            topShadowViewForMenu.heightAnchor.constraint(equalToConstant: 50),
            
            menuButton.widthAnchor.constraint(equalToConstant: 210),
            menuButton.heightAnchor.constraint(equalToConstant: 60),
            menuButton.centerXAnchor.constraint(equalTo: bottomShadowViewForMenu.centerXAnchor),
            menuButton.centerYAnchor.constraint(equalTo: bottomShadowViewForMenu.centerYAnchor),
        ])
    }
    
    private func addGradient() {
        let gradientColors: [CGColor] = [
            UIColor(red: 255/255, green: 0/255, blue: 3/255, alpha: 1).cgColor,
            UIColor(red: 87/255, green: 0/255, blue: 1/255, alpha: 1).cgColor
        ]
        
        for (_, view) in gradientViews.enumerated() {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = gradientColors
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            
            gradientLayer.frame = view.bounds
            
            view.layer.insertSublayer(gradientLayer, at: 0)
            
            view.layoutIfNeeded()
        }
        
        bottomGradientLayerForResume.colors = [
            UIColor(red: 255/255, green: 0/255, blue: 3/255, alpha: 0.4).cgColor,
            UIColor(red: 87/255, green: 0/255, blue: 1/255, alpha: 0.4).cgColor
        ]
        bottomGradientLayerForResume.startPoint = CGPoint(x: 0.5, y: 0.0)
        bottomGradientLayerForResume.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        bottomShadowViewForResume.layer.insertSublayer(bottomGradientLayerForResume, at: 0)
        
        middleGradientLayerForResume.colors = [
            UIColor(red: 255/255, green: 0/255, blue: 3/255, alpha: 0.5).cgColor,
            UIColor(red: 87/255, green: 0/255, blue: 1/255, alpha: 0.5).cgColor
        ]
        middleGradientLayerForResume.startPoint = CGPoint(x: 0.5, y: 0.0)
        middleGradientLayerForResume.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        middleShadowViewForResume.layer.insertSublayer(middleGradientLayerForResume, at: 0)
        
        topGradientLayerForResume.colors = [
            UIColor(red: 255/255, green: 0/255, blue: 3/255, alpha: 1).cgColor,
            UIColor(red: 87/255, green: 0/255, blue: 1/255, alpha: 1).cgColor
        ]
        topGradientLayerForResume.startPoint = CGPoint(x: 0.5, y: 0.0)
        topGradientLayerForResume.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        topShadowViewForResume.layer.insertSublayer(topGradientLayerForResume, at: 0)
        
        bottomGradientLayerForMenu.colors = [
            UIColor(red: 255/255, green: 0/255, blue: 3/255, alpha: 0.4).cgColor,
            UIColor(red: 87/255, green: 0/255, blue: 1/255, alpha: 0.4).cgColor
        ]
        bottomGradientLayerForMenu.startPoint = CGPoint(x: 0.5, y: 0.0)
        bottomGradientLayerForMenu.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        bottomShadowViewForMenu.layer.insertSublayer(bottomGradientLayerForMenu, at: 0)
        
        middleGradientLayerForMenu.colors = [
            UIColor(red: 255/255, green: 0/255, blue: 3/255, alpha: 0.5).cgColor,
            UIColor(red: 87/255, green: 0/255, blue: 1/255, alpha: 0.5).cgColor
        ]
        middleGradientLayerForMenu.startPoint = CGPoint(x: 0.5, y: 0.0)
        middleGradientLayerForMenu.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        middleShadowViewForMenu.layer.insertSublayer(middleGradientLayerForMenu, at: 0)
        
        topGradientLayerForMenu.colors = [
            UIColor(red: 255/255, green: 0/255, blue: 3/255, alpha: 1).cgColor,
            UIColor(red: 87/255, green: 0/255, blue: 1/255, alpha: 1).cgColor
        ]
        topGradientLayerForMenu.startPoint = CGPoint(x: 0.5, y: 0.0)
        topGradientLayerForMenu.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        topShadowViewForMenu.layer.insertSublayer(topGradientLayerForMenu, at: 0)
    }
    
    @objc
    func goToMenuTapped() {
        self.dismiss(animated: true) {
            self.delegate.returnToMenu()
        }
    }
    
    @objc
    func resumeTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func toogleSound() {
            let isSoundOn = UserDefaults.standard.bool(forKey: "isSoundOn")
            
            let newSoundState = !isSoundOn
            
            UserDefaults.standard.set(newSoundState, forKey: "isSoundOn")
        
        if newSoundState {
            actionButtons[0].setImage(UIImage(systemName: onIcons[0])?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 16, weight: .heavy)), for: .normal)
        } else {
            actionButtons[0].setImage(UIImage(systemName: offIcons[0])?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 16, weight: .heavy)), for: .normal)
        }
    }
    
    @objc
    func toogleVibration() {
        let currentSetting = UserDefaults.standard.bool(forKey: "isVibrationOn")
            UserDefaults.standard.set(!currentSetting, forKey: "isVibrationOn")
        
        if !currentSetting {
            actionButtons[1].setImage(UIImage(systemName: onIcons[1])?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 16, weight: .heavy)), for: .normal)
        } else {
            actionButtons[1].setImage(UIImage(systemName: offIcons[1])?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 16, weight: .heavy)), for: .normal)
        }
    }
}
