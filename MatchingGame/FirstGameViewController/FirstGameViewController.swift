//
//  FirstGameViewController.swift
//  MatchingGame
//
//  Created by Илья Волощик on 30.10.24.
//

import UIKit
import AVFoundation

final class FirstGameViewController: UIViewController {
    
    //MARK: UI Elements
    private lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BackForGame")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var hatImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "HatForGame")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var cherryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CherryForGame")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var сoinsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CoinsForGame")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Multiround Pro", size: 20)
        label.text = "MOVIES: \(counter)"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stopwatchLabel: UILabel = {
        let label = UILabel()
        label.text = "TIME: 00:00"
        label.font = UIFont(name: "Multiround Pro", size: 20)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.Identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    //MARK: Private Properties
    private var audioPlayer: AVAudioPlayer?
    
    private var counter: Int = 0 {
        didSet {
            updateCounterLable()
        }
    }
    private var isStop: Bool = false
    private var stopwatchTimer: Timer?
    private var elapsedTime: TimeInterval = 0
    private var actionButtons: [UIButton] = []
    private var gradientViews: [UIView] = []
    private var images = (1..<9).map { UIImage(named: "icon\($0)")!}
    private var shuffledImages: [UIImage] = []
    private var selectedCells: [IndexPath] = []
    private let gradientLayerForButtons = CAGradientLayer()
    
    //MARK: Override func
    override func viewDidLoad() {
        super.viewDidLoad()
        shuffleImages()
        configViews()
        setUpConstraints()
        addGradient()
        addRadialGradient(to: topView)
        addLinearGradient(to: bottomView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in gradientViews {
            if let gradientLayer = view.layer.sublayers?.first as? CAGradientLayer {
                gradientLayer.frame = view.bounds
            }
        }
        
        
        if let gradientLayer = bottomView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = bottomView.bounds
        }
        
        
        if let gradientLayer = topView.layer.sublayers?.first as? RadialGradientLayer {
            gradientLayer.frame = topView.bounds
            gradientLayer.radius = max(topView.bounds.width, topView.bounds.height) / 2
            gradientLayer.setNeedsDisplay()
        }
    }
    
    //MARK: Private funcs
    private func configViews() {
        navigationItem.hidesBackButton = true
        view.addSubview(backImageView)
        [сoinsImageView, hatImageView, cherryImageView, bottomView].forEach({backImageView.addSubview($0)})
        bottomView.addSubview(topView)
        topView.addSubview(countLabel)
        topView.addSubview(stopwatchLabel)
        
        for _ in 0..<4 {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = 7
            view.layer.masksToBounds = true
            view.widthAnchor.constraint(equalToConstant: 40).isActive = true
            view.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            gradientViews.append(view)
            self.view.addSubview(view)
        }
        
        for _ in 0..<4 {
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
        
        let icons: [String] = ["pause.fill",
                               "chevron.backward",
                               "arrow.trianglehead.clockwise.rotate.90",
                               "gearshape.fill"]
        
        let actions: [Selector] = [#selector(pauseTapped),
                                   #selector(backTapped),
                                   #selector(repeatTapped),
                                   #selector(settingsTapped)]
        
        for (index, button) in actionButtons.enumerated() {
            button.setImage(UIImage(systemName: icons[index])?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 24, weight: .heavy)), for: .normal)
            button.addTarget(self, action: actions[index], for: .touchUpInside)
        }
        
        view.addSubview(collectionView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            backImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            сoinsImageView.bottomAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: 120),
            сoinsImageView.leadingAnchor.constraint(equalTo: backImageView.leadingAnchor, constant: 0),
            сoinsImageView.trailingAnchor.constraint(equalTo: backImageView.trailingAnchor, constant: 0),
            сoinsImageView.heightAnchor.constraint(equalToConstant: 360),
            
            hatImageView.topAnchor.constraint(equalTo: backImageView.topAnchor, constant: 35),
            hatImageView.trailingAnchor.constraint(equalTo: backImageView.trailingAnchor),
            hatImageView.leadingAnchor.constraint(equalTo: backImageView.leadingAnchor, constant: 100),
            hatImageView.heightAnchor.constraint(equalToConstant: 200),
            
            cherryImageView.leadingAnchor.constraint(equalTo: backImageView.leadingAnchor),
            cherryImageView.topAnchor.constraint(equalTo: backImageView.topAnchor),
            cherryImageView.heightAnchor.constraint(equalToConstant: 200),
            cherryImageView.widthAnchor.constraint(equalToConstant: 200),
            
            actionButtons[3].leadingAnchor.constraint(equalTo: backImageView.leadingAnchor, constant: 20),
            actionButtons[3].topAnchor.constraint(equalTo: backImageView.topAnchor, constant: 70),
            
            gradientViews[3].centerXAnchor.constraint(equalTo: actionButtons[3].centerXAnchor),
            gradientViews[3].centerYAnchor.constraint(equalTo: actionButtons[3].centerYAnchor),
            
            bottomView.leadingAnchor.constraint(equalTo: actionButtons[3].leadingAnchor),
            bottomView.topAnchor.constraint(equalTo: actionButtons[3].bottomAnchor, constant: 20),
            bottomView.trailingAnchor.constraint(equalTo: backImageView.trailingAnchor, constant: -20),
            bottomView.heightAnchor.constraint(equalToConstant: 50),
            
            topView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -5),
            topView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 5),
            topView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 5),
            topView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -5),
            
            countLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20),
            countLabel.heightAnchor.constraint(equalToConstant: 30),
            countLabel.trailingAnchor.constraint(equalTo: topView.centerXAnchor),
            
            stopwatchLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            stopwatchLabel.leadingAnchor.constraint(equalTo: topView.centerXAnchor),
            stopwatchLabel.heightAnchor.constraint(equalToConstant: 30),
            stopwatchLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: 10),
            
            collectionView.topAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: -200),
            collectionView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            
            actionButtons[0].leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            actionButtons[0].topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 60),
            
            gradientViews[0].centerXAnchor.constraint(equalTo: actionButtons[0].centerXAnchor),
            gradientViews[0].centerYAnchor.constraint(equalTo: actionButtons[0].centerYAnchor),
            
            actionButtons[1].centerXAnchor.constraint(equalTo: backImageView.centerXAnchor),
            actionButtons[1].topAnchor.constraint(equalTo: actionButtons[0].topAnchor),
            
            gradientViews[1].centerXAnchor.constraint(equalTo: actionButtons[1].centerXAnchor),
            gradientViews[1].centerYAnchor.constraint(equalTo: actionButtons[1].centerYAnchor),
            
            actionButtons[2].trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            actionButtons[2].topAnchor.constraint(equalTo: actionButtons[0].topAnchor),
            
            gradientViews[2].centerXAnchor.constraint(equalTo: actionButtons[2].centerXAnchor),
            gradientViews[2].centerYAnchor.constraint(equalTo: actionButtons[2].centerYAnchor),
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
    
    private func addRadialGradient(to view: UIView) {
        let gradientLayer = RadialGradientLayer()
        gradientLayer.colors = [
            UIColor.red.cgColor,
            UIColor(red: 109/255, green: 5/255, blue: 5/255, alpha: 1).cgColor
        ]
        
        let minDimension = min(view.bounds.width, view.bounds.height)
        gradientLayer.radius = minDimension / 2.0
        gradientLayer.frame = view.bounds
        gradientLayer.setNeedsDisplay()
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func addLinearGradient(to view: UIView) {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [
            UIColor(red: 133/255, green: 134/255, blue: 136/255, alpha: 1).cgColor,
            UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1).cgColor,
            UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1).cgColor,
            UIColor(red: 138/255, green: 134/255, blue: 135/255, alpha: 1).cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        gradientLayer.frame = view.bounds
        
        if let sublayers = view.layer.sublayers {
            for layer in sublayers {
                if layer is CAGradientLayer {
                    layer.removeFromSuperlayer()
                }
            }
        }
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func updateStopwatchLabel() {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        stopwatchLabel.text = "TIME: " + String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func updateCounterLable() {
        countLabel.text = "MOVIES: \(counter)"
    }
    
    private func startStopwatch() {
        stopwatchTimer?.invalidate()
        stopwatchTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateStopwatch), userInfo: nil, repeats: true)
    }
    
    private func shuffleImages() {
        shuffledImages = (images + images).shuffled()
    }
    
    private func showWinViewController() {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        let time = "TIME: " + String(format: "%02d:%02d", minutes, seconds)
        let winVC = WinViewController(step: counter, time: time, delegate: self)
        winVC.modalPresentationStyle = .overFullScreen
        self.present(winVC, animated: true, completion: nil)
    }
    
    private func showSettingsViewController() {
        let settingsVC = SettingViewController(delegate: self)
        settingsVC.modalPresentationStyle = .overFullScreen
        self.present(settingsVC, animated: true, completion: nil)
    }
    
    //MARK: Selectors
    @objc
    func settingsTapped() {
        showSettingsViewController()
    }
    
    @objc
    func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func pauseTapped() {
        if isStop {
            isStop.toggle()
            collectionView.isUserInteractionEnabled = true
            startStopwatch()
        } else {
            isStop.toggle()
            collectionView.isUserInteractionEnabled = false
            stopwatchTimer?.invalidate()
        }
    }
    
    @objc
    func repeatTapped() {
        stopwatchTimer?.invalidate()
        elapsedTime = 0
        counter = 0
        updateCounterLable()
        updateStopwatchLabel()
        for cell in collectionView.visibleCells {
            if let customCell = cell as? CustomCollectionViewCell {
                customCell.closeIcon()
            }
        }
        collectionView.reloadData()
    }
    
    @objc private func updateStopwatch() {
        elapsedTime += 1
        updateStopwatchLabel()
    }
}

//MARK: Extensions
extension FirstGameViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        playTapSound()
        triggerVibration(type: .heavy)
        collectionView.isUserInteractionEnabled = false
        if elapsedTime == 0 {
            startStopwatch()
        }
        counter += 1
        guard let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell else {
            print("Не прошёл каст")
            return
        }
        selectedCells.append(indexPath)
        
        if selectedCells.count == 2 {
            cell.openIcon()
            checkSelectedCells()
        } else {
            cell.openIcon()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            collectionView.isUserInteractionEnabled = true
            self.checkAllCells()
        }
    }
}

extension FirstGameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shuffledImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.Identifier, for: indexPath) as? CustomCollectionViewCell
        else {
            print("Не прошёл каст")
            return UICollectionViewCell()
        }
        cell.resetCell()
        cell.setUpIconImage(image: shuffledImages[indexPath.row])
        return cell
    }
}

extension FirstGameViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}

extension FirstGameViewController {
    private func checkSelectedCells() {
        
        let firstIndexPath = selectedCells[0]
        let secondIndexPath = selectedCells[1]
        
        guard let firstCell = collectionView.cellForItem(at: firstIndexPath) as? CustomCollectionViewCell,
              let secondCell = collectionView.cellForItem(at: secondIndexPath) as? CustomCollectionViewCell else {
            return
        }
        
        if firstCell.image == secondCell.image {
            playCompleteSound()
            triggerNotificationVibration(type: .success)
            selectedCells.removeAll()
        } else {
            playSadSound()
            triggerNotificationVibration(type: .error)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                firstCell.closeIcon()
                secondCell.closeIcon()
                self.selectedCells.removeAll()
            }
        }
    }
    
    private func checkAllCells() {
        var openCell = 0
        for cell in collectionView.visibleCells {
            if let customCell = cell as? CustomCollectionViewCell {
                if customCell.flag {
                    openCell += 1
                }
            }
        }
        if openCell == 16 {
            showWinViewController()
            stopwatchTimer?.invalidate()
            elapsedTime = 0
            updateStopwatchLabel()
            for cell in collectionView.visibleCells {
                if let customCell = cell as? CustomCollectionViewCell {
                    customCell.closeIcon()
                }
            }
            counter = 0
            updateCounterLable()
            collectionView.reloadData()
        }
    }
}

extension FirstGameViewController: GoToMenuDelegate {
    func returnToMenu() {
        navigationController?.popViewController(animated: true)
    }
}
//MARK: Funcs For Sound
extension FirstGameViewController {
    func playTapSound() {
        guard checkSoundStation() else {return}

        guard let url = Bundle.main.url(forResource: "rebound-ios-17", withExtension: "mp3") else {
            print("Не удалось найти файл с аудио.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Ошибка воспроизведения звука: \(error.localizedDescription)")
        }
    }
    
    func playCompleteSound() {
        guard checkSoundStation() else {return}

        guard let url = Bundle.main.url(forResource: "cheers", withExtension: "mp3") else {
            print("Не удалось найти файл с аудио.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Ошибка воспроизведения звука: \(error.localizedDescription)")
        }
    }
    
    func playSadSound() {
        guard checkSoundStation() else {return}
        
        guard let url = Bundle.main.url(forResource: "droplet-ios-17", withExtension: "mp3") else {
            print("Не удалось найти файл с аудио.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Ошибка воспроизведения звука: \(error.localizedDescription)")
        }
    }
    
    func checkSoundStation() -> Bool {
        let isSoundOn = UserDefaults.standard.bool(forKey: "isSoundOn")
            
        if isSoundOn {
            return true
        } else {
            return false
        }
    }
}

extension FirstGameViewController {
    func triggerVibration(type: UIImpactFeedbackGenerator.FeedbackStyle) {
        guard UserDefaults.standard.bool(forKey: "isVibrationOn") else { return }
            let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: type)
            impactFeedbackgenerator.prepare()
            impactFeedbackgenerator.impactOccurred()
        }
    
    func triggerNotificationVibration(type: UINotificationFeedbackGenerator.FeedbackType) {
        guard UserDefaults.standard.bool(forKey: "isVibrationOn") else { return }
            let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
            notificationFeedbackGenerator.prepare()
            notificationFeedbackGenerator.notificationOccurred(type)
        }
}

