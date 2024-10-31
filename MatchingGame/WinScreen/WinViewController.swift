//
//  WinViewController.swift
//  MatchingGame
//
//  Created by Илья Волощик on 31.10.24.
//
import UIKit

protocol GoToMenuDelegate: AnyObject {
    func returnToMenu()
}

final class WinViewController: UIViewController {
    
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
    
    private lazy var flameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Flame")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var frameForScoreImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "FrameForScore")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var youWinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "YouWin")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Multiround Pro", size: 20)
        label.text = "MOVIES: \(step)"
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stopwatchLabel: UILabel = {
        let label = UILabel()
        label.text = time
        label.font = UIFont(name: "Multiround Pro", size: 20)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var actionButtons: [UIButton] = []
    private var gradientViews: [UIView] = []
    private let step: Int
    private let time: String
    private let gradientLayerForButtons = CAGradientLayer()
    private let delegate: GoToMenuDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
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
    }
    
    init(step: Int, time: String, delegate: GoToMenuDelegate) {
        self.delegate = delegate
        self.step = step
        self.time = time
        super.init(nibName: nil, bundle: nil)
        self.stopwatchLabel.text = time
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configViews() {
        [grapeImageView,
         orangeImageView,
         cherryImageView,
         flameImageView,
         frameForScoreImageView,
         youWinImageView].forEach({view.addSubview($0)})
        [countLabel,
         stopwatchLabel].forEach({frameForScoreImageView.addSubview($0)})
        
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
        
        let icons: [String] = ["arrow.trianglehead.clockwise.rotate.90",
                               "line.3.horizontal"]
        
        let actions: [Selector] = [#selector(repeatTapped),
                                   #selector(goToMenuTapped)]
        
        for (index, button) in actionButtons.enumerated() {
            button.setImage(UIImage(systemName: icons[index])?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 24, weight: .heavy)), for: .normal)
            button.addTarget(self, action: actions[index], for: .touchUpInside)
        }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            orangeImageView.widthAnchor.constraint(equalToConstant: 95),
            orangeImageView.heightAnchor.constraint(equalToConstant: 80),
            orangeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            orangeImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            
            cherryImageView.widthAnchor.constraint(equalToConstant: 130),
            cherryImageView.heightAnchor.constraint(equalToConstant: 120),
            cherryImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cherryImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -330),
            
            grapeImageView.widthAnchor.constraint(equalToConstant: 90),
            grapeImageView.heightAnchor.constraint(equalToConstant: 85),
            grapeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            grapeImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            
            flameImageView.widthAnchor.constraint(equalToConstant: 330),
            flameImageView.heightAnchor.constraint(equalToConstant: 460),
            flameImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flameImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: -50),
            
            youWinImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            youWinImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            youWinImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            youWinImageView.heightAnchor.constraint(equalToConstant: 400),
            
            frameForScoreImageView.heightAnchor.constraint(equalToConstant: 200),
            frameForScoreImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            frameForScoreImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            frameForScoreImageView.centerYAnchor.constraint(equalTo: youWinImageView.centerYAnchor, constant: 150),
            
            countLabel.centerYAnchor.constraint(equalTo: frameForScoreImageView.centerYAnchor, constant: 20),
            countLabel.leadingAnchor.constraint(equalTo: frameForScoreImageView.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: frameForScoreImageView.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 20),
            
            stopwatchLabel.centerYAnchor.constraint(equalTo: countLabel.centerYAnchor, constant: 30),
            stopwatchLabel.leadingAnchor.constraint(equalTo: frameForScoreImageView.leadingAnchor),
            stopwatchLabel.trailingAnchor.constraint(equalTo: frameForScoreImageView.trailingAnchor),
            stopwatchLabel.heightAnchor.constraint(equalToConstant: 20),
            
            gradientViews[0].trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            gradientViews[0].topAnchor.constraint(equalTo: frameForScoreImageView.bottomAnchor, constant: 10),
            
            gradientViews[1].leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            gradientViews[1].topAnchor.constraint(equalTo: gradientViews[0].topAnchor),
            
            actionButtons[0].centerXAnchor.constraint(equalTo: gradientViews[0].centerXAnchor),
            actionButtons[0].centerYAnchor.constraint(equalTo: gradientViews[0].centerYAnchor),
            
            actionButtons[1].centerXAnchor.constraint(equalTo: gradientViews[1].centerXAnchor),
            actionButtons[1].centerYAnchor.constraint(equalTo: gradientViews[1].centerYAnchor)
            
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
        
        
    }
    
    @objc
    func goToMenuTapped() {
        self.dismiss(animated: true) {
            self.delegate.returnToMenu()
        }
    }
    
    @objc
    func repeatTapped() {
        self.dismiss(animated: true, completion: nil)
        
    }
}
