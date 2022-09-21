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
    
    let infoStack: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
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
        setup()
    }
    
    func setupInfo() {
        let avatar = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        avatar.image = UIImage(named: K.Images.disk)
        avatar.layer.masksToBounds = false
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.widthAnchor.constraint(equalToConstant: 200).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let trackName = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        trackName.text = "God's Plan"
        trackName.font = .systemFont(ofSize: 21, weight: .regular)
        trackName.textColor = K.AppColors.white
        trackName.textAlignment = .center
        
        let artistName = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        artistName.text = "Drake"
        artistName.font = .systemFont(ofSize: 16, weight: .bold)
        artistName.textColor = UIColor.gray
        artistName.textAlignment = .center
        
        infoStack.addArrangedSubview(avatar)
        infoStack.addArrangedSubview(trackName)
        infoStack.addArrangedSubview(artistName)
        
        mainStack.addArrangedSubview(infoStack)
        initInfoStackConstraints()
    }
    
    func initInfoStackConstraints() {
        NSLayoutConstraint.activate([
            infoStack.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: +40),
            infoStack.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor, constant: -40),
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
        initControlStackConstraints()
    }
    
    func initControlStackConstraints() {
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
        // Indicator
        
        let slider = UISlider(frame: CGRect(x: 0, y: 0, width: 250, height:50))
        slider.widthAnchor.constraint(equalToConstant: 300).isActive = true
        slider.value = 0.5
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
        initIndicatorStackConstraints()
        initTimeStackConstraints()
    }
    
    @objc func didSlider(_ slider: UISlider) {
        let value = slider.value
    }
    
    func initIndicatorStackConstraints() {
        NSLayoutConstraint.activate([
            indicatorStack.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            indicatorStack.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
        ])
    }
    func initTimeStackConstraints() {
        NSLayoutConstraint.activate([
            timeStack.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: +40),
            timeStack.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor, constant: -40),
        ])
    }
    
    func setup() {
        setupInfo()
        setupIndicator()
        setupControls()
        self.view.addSubview(mainStack)
        initMainStackConstraints()
    }
    
    func initMainStackConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.topAnchor, constant: +200),
            mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
