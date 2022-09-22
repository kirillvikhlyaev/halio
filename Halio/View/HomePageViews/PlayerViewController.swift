//
//  PlayerViewController.swift
//  Halio
//
//  Created by Кирилл on 21.09.2022.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    var playToggle: Bool = false
    var player: AVAudioPlayer?
    
    let infoView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    let background = UIImageView()
    
    let controlStack: UIStackView = {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 15
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    let indicatorStack: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    let timeStack: UIStackView = {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 25
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    let mainStack: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fillProportionally
        $0.spacing = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    let playButton = UIButton(frame: CGRect(x: 0, y: 0 , width: 100, height: 100))
    let prevButton = UIButton(frame: CGRect(x: 0, y: 0 , width: 100, height: 100))
    let nextButton = UIButton(frame: CGRect(x: 0, y: 0 , width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.title = "Играет сейчас"
        
        self.view.backgroundColor = K.AppColors.primary
//        setupBackground()
        setup()
    }
//
//    func setupBackground() {
//
//
//
//        background.image = UIImage(named: K.Images.playerBg)
//        background.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
//        background.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
//
//        let backgroundOverlay = UIImageView()
//        backgroundOverlay.image = UIImage(named: K.Images.playerBgOverlay)
//        backgroundOverlay.layer.opacity = 0.8
//        backgroundOverlay.widthAnchor.constraint(equalTo: background.widthAnchor).isActive = true
//        backgroundOverlay.heightAnchor.constraint(equalTo: background.heightAnchor).isActive = true
//
//        background.addSubview(backgroundOverlay)
//
//        self.view.addSubview(background)
//    }
    
    func setupInfo() {
        let avatar = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        avatar.image = UIImage(named: K.Images.disk)
        avatar.layer.masksToBounds = false
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.widthAnchor.constraint(equalToConstant: 200).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let backgroundAvatar = UIImageView(frame: CGRect(x: 0, y: 0, width: 220, height: 220))
        backgroundAvatar.image = UIImage(named: K.Images.diskShadow)
        backgroundAvatar.layer.masksToBounds = false
        backgroundAvatar.clipsToBounds = true
        backgroundAvatar.layer.cornerRadius = backgroundAvatar.frame.height/2
        backgroundAvatar.translatesAutoresizingMaskIntoConstraints = false
        backgroundAvatar.widthAnchor.constraint(equalToConstant: 220).isActive = true
        backgroundAvatar.heightAnchor.constraint(equalToConstant: 220).isActive = true
        backgroundAvatar.addSubview(avatar)
        
        let trackName = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        trackName.text = "God's Plan"
        trackName.font = .systemFont(ofSize: 21, weight: .regular)
        trackName.textColor = K.AppColors.white
        trackName.translatesAutoresizingMaskIntoConstraints = false
        trackName.textAlignment = .center
        
        let artistName = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        artistName.text = "Drake"
        artistName.font = .systemFont(ofSize: 16, weight: .bold)
        artistName.textColor = UIColor.gray
        artistName.translatesAutoresizingMaskIntoConstraints = false
        artistName.textAlignment = .center
        
        infoView.addSubview(backgroundAvatar)
        infoView.addSubview(trackName)
        infoView.addSubview(artistName)
        mainStack.addArrangedSubview(infoView)
        
        NSLayoutConstraint.activate([
            infoView.heightAnchor.constraint(equalToConstant: 300),
            infoView.widthAnchor.constraint(equalToConstant: 300),
            
            backgroundAvatar.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            backgroundAvatar.topAnchor.constraint(equalTo: infoView.topAnchor),
            
            avatar.centerXAnchor.constraint(equalTo: backgroundAvatar.centerXAnchor),
            avatar.centerYAnchor.constraint(equalTo: backgroundAvatar.centerYAnchor),
            
            trackName.topAnchor.constraint(equalTo: backgroundAvatar.bottomAnchor, constant: +15),
            trackName.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            
            artistName.topAnchor.constraint(equalTo: trackName.bottomAnchor, constant: +5),
            artistName.centerXAnchor.constraint(equalTo: infoView.centerXAnchor)
        ])
        
    }
    
    func setupControls() {
        prevButton.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        prevButton.tintColor = K.AppColors.white
        prevButton.addTarget(self, action: #selector(onPrevButtonTap), for: .touchUpInside)
        
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playButton.tintColor = K.AppColors.white
        playButton.addTarget(self, action: #selector(onPlayButtonTap), for: .touchUpInside)
        
        nextButton.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        nextButton.tintColor = K.AppColors.white
        nextButton.addTarget(self, action: #selector(onNextButtonTap), for: .touchUpInside)
        
        controlStack.addArrangedSubview(prevButton)
        controlStack.addArrangedSubview(playButton)
        controlStack.addArrangedSubview(nextButton)
        
        mainStack.addArrangedSubview(controlStack)
        
        NSLayoutConstraint.activate([
            controlStack.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: +80),
            controlStack.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor, constant: -80),
        ])
    }
    
    @objc func onPrevButtonTap() {}
    @objc func onPlayButtonTap() {
        if let player = player, player.isPlaying {
            //Stop
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            player.pause()
            
        } else {
            //Play
            let urlString = Bundle.main.path(forResource: "drake", ofType: "mp3")
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else {
                    return
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = player else {
                    return
                }
                playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                player.play()
                
            } catch {
                print("Ошибка воспроизведения")
            }
        }
    }
    @objc func onNextButtonTap() {}
    
    func setupIndicator() {
        let slider = UISlider()
        slider.value = 0.5
        slider.tintColor = K.AppColors.secondary
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(didSlider(_:)), for: .valueChanged)
        
        let currentTime = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        currentTime.text = "0:00"
        currentTime.font = .systemFont(ofSize: 16, weight: .regular)
        currentTime.textColor = UIColor.gray
        currentTime.textAlignment = .center
        
        let maxTime = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        maxTime.text = "3:57"
        maxTime.font = .systemFont(ofSize: 16, weight: .regular)
        maxTime.textColor = UIColor.gray
        maxTime.textAlignment = .center
        
        timeStack.addArrangedSubview(currentTime)
        timeStack.addArrangedSubview(maxTime)
        
        indicatorStack.addArrangedSubview(slider)
        indicatorStack.addArrangedSubview(timeStack)
        
        mainStack.addArrangedSubview(indicatorStack)
        
        NSLayoutConstraint.activate([
            indicatorStack.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            indicatorStack.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            
            slider.leadingAnchor.constraint(equalTo: indicatorStack.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: indicatorStack.trailingAnchor),
            slider.heightAnchor.constraint(equalToConstant: 35),
            
            timeStack.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: +40),
            timeStack.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor, constant: -40),
        ])
    }
    
    @objc func didSlider(_ slider: UISlider) {
        let value = slider.value
    }
    
    func setup() {
        setupInfo()
        setupIndicator()
        setupControls()
        self.view.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: +200),
            mainStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -200),
            mainStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}
