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
    var isPaused: Bool = false
    var player: AVPlayer?
    
    let slider = UISlider()
    
    //var album = Album(id: "1", name: "Test", artist_name: "Test", image: "", tracks: [Track(id: "1", name: "", duration: "", audio: "")])
    var trackName = ""
    var trackArtistName = ""
    var trackUrl = ""
    var trackDuration = ""
    var trackImage = ""
    
    
    let infoView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    let background = UIImageView()
    
    let currentTime = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
    
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
      //  self.navigationController?.navigationBar.tintColor = UIColor.white
        self.tabBarController?.tabBar.backgroundColor = K.AppColors.secondary
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.title = ""
        setupBackground()
        setup()
    }
    
    func setupBackground() {
        let url = URL(string: trackImage)
        background.frame = self.view.bounds
        background.backgroundColor = K.AppColors.primary
        
        let backgroundOverlay = UIImageView(frame: self.view.bounds)
        backgroundOverlay.kf.setImage(with: url)
        backgroundOverlay.layer.opacity = 0.2
        
        background.addSubview(backgroundOverlay)
        
        self.view.addSubview(background)
    }
    
    func setupInfo() {
        let url = URL(string: trackImage)
        let avatar = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        avatar.kf.setImage(with: url)
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
        
        let trackNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        trackNameLabel.text = trackName
        trackNameLabel.font = .systemFont(ofSize: 21, weight: .regular)
        trackNameLabel.textColor = K.AppColors.white
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        trackNameLabel.textAlignment = .center
        
        let artistName = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        artistName.text = trackArtistName
        artistName.font = .systemFont(ofSize: 16, weight: .bold)
        artistName.textColor = K.AppColors.white
        artistName.translatesAutoresizingMaskIntoConstraints = false
        artistName.textAlignment = .center
        
        infoView.addSubview(backgroundAvatar)
        infoView.addSubview(trackNameLabel)
        infoView.addSubview(artistName)
        mainStack.addArrangedSubview(infoView)
        
        NSLayoutConstraint.activate([
            infoView.heightAnchor.constraint(equalToConstant: 300),
            infoView.widthAnchor.constraint(equalToConstant: 300),
            
            backgroundAvatar.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            backgroundAvatar.topAnchor.constraint(equalTo: infoView.topAnchor),
            
            avatar.centerXAnchor.constraint(equalTo: backgroundAvatar.centerXAnchor),
            avatar.centerYAnchor.constraint(equalTo: backgroundAvatar.centerYAnchor),
            
            trackNameLabel.topAnchor.constraint(equalTo: backgroundAvatar.bottomAnchor, constant: +15),
            trackNameLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            
            artistName.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: +5),
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
        let url = URL(string: trackUrl)
       
        do {
            let playerItem = AVPlayerItem(url: url!)
            self.player = try AVPlayer(playerItem: playerItem)
            player!.volume = 1.0
            if (!playToggle) {
                isPaused = false
                if (!isPaused) {
                    Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
                    player!.play()
                }
            } else {
                player!.pause()
                isPaused = true
            }
            playToggle = !playToggle
            
        } catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVPlayer init failed")
        }
        
        if (playToggle) {
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    @objc func onNextButtonTap() {}
    
    @objc func updateTime() {
        slider.value = Float(player!.currentTime().seconds)
        
        DispatchQueue.main.async {
            self.currentTime.text = Utils.timeStringFor(seconds: Int(self.player!.currentTime().seconds))
        }
        
    }
    
    func setupIndicator() {
        slider.value = 0
        slider.maximumValue = Float(trackDuration)!
        slider.tintColor = K.AppColors.secondary
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(didSlider(_:)), for: .valueChanged)
        
        currentTime.font = .systemFont(ofSize: 16, weight: .regular)
        currentTime.textColor = K.AppColors.white
        currentTime.text = "0:00"
        currentTime.textAlignment = .center
        
        let maxTime = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        maxTime.text = Utils.timeStringFor(seconds: Int(trackDuration)!)
        maxTime.font = .systemFont(ofSize: 16, weight: .regular)
        maxTime.textColor = K.AppColors.white
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
        view.addSubview(mainStack)
        setupInfo()
        setupIndicator()
        setupControls()
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: +200),
            mainStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -200),
            mainStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}
