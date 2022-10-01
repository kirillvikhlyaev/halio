//
//  ViewController.swift
//  Halio
//
//  Created by Кирилл on 20.09.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    let playButton = UIButton(frame: CGRect(x: 0, y: 0 , width: 100, height: 100))
    let prevButton = UIButton(frame: CGRect(x: 0, y: 0 , width: 100, height: 100))
    let nextButton = UIButton(frame: CGRect(x: 0, y: 0 , width: 100, height: 100))
    let playerView = UIView()
    
    var api = AlbumFetcherManager()
    var albums = [
        Album(id: "0", name: "Test", artist_name: "Tester", image: "", tracks: []),
        Album(id: "0", name: "Test", artist_name: "Tester", image: "", tracks: []),
        Album(id: "0", name: "Test", artist_name: "Tester", image: "", tracks: [])
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = K.AppColors.primary
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SongCell.self, forCellReuseIdentifier: "SongCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.delegate = self
        api.albumFetch(limit: 3)
        self.view.backgroundColor = K.AppColors.primary
        self.view.addSubview(tableView)
        self.setupUI()
//        setupPlayerView()
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButton
        backBarButton.tintColor = UIColor(red: 0.831, green: 0.831, blue: 0.831, alpha: 1)
    }
    
    func setupUI() {
        
        NSLayoutConstraint.activate([
            
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 76),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 34),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            
        ])
    }
    
    func setupBottomNavBar() {
        let tabBarVC = UITabBarController()
        
        let favoriteView = FavoriteListViewController()
        let homeView = HomeViewController()
        let searchView = SearchViewController()
        let profileView = ProfileViewController()
        
        var views: [UIViewController] = []
        
        views.append(favoriteView)
        views.append(homeView)
        views.append(searchView)
        views.append(profileView)
        
        tabBarVC.setViewControllers(views, animated: true)
        
        present(tabBarVC, animated: false)
    }
}

enum SongsTableSection: Int {
    case made
    case recently
    case genre
    
    var title: String {
        switch self {
        case .made:
            return "Made for you"
        case .recently:
            return "Recently Played"
        case .genre:
            return "Genre"
        }
    }
    
    var index: Int {
        switch self {
        case .made:
            return 0
        case .recently:
            return 1
        case .genre:
            return 2
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = SongsTableSection(rawValue: indexPath.section)!
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongCell
        cell.headerLabel.text = section.title
        print(indexPath.row)
        print(albums[indexPath.row])
        cell.album = albums[section.index];
        cell.update() // Вызываем reloadData() у ячейки таблицы - коллекшнвью
        cell.onSongTap = {
            [weak self] album, index in
            guard let self = self else { return }
            let nextVC = PlayerViewController()
            nextVC.album = album
            nextVC.indexOfTrack = index
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        cell.onNextTap = {
            [weak self] album in
            guard let self = self else { return }
            let nextVC = ListViewController()
            nextVC.album = album
            print(album)
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = ListViewController()
        nextVC.album = albums[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

// MARK: - PlayerView Setup
extension HomeViewController {
    func setupPlayerView() {
        playerView.backgroundColor = K.AppColors.secondary
        playerView.translatesAutoresizingMaskIntoConstraints = false
        
        let trackInfoStack = UIStackView()
        trackInfoStack.distribution = .equalSpacing
        trackInfoStack.axis = .horizontal
        trackInfoStack.alignment = .center
        trackInfoStack.spacing = 10
        trackInfoStack.translatesAutoresizingMaskIntoConstraints = false
        
        let namesStack = UIStackView()
        namesStack.distribution = .equalSpacing
        namesStack.axis = .vertical
        namesStack.alignment = .leading
        namesStack.spacing = 3
        
        let trackImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        trackImage.image = UIImage(named: K.Images.placeholder)
        trackImage.layer.masksToBounds = false
        trackImage.clipsToBounds = true
        trackImage.layer.cornerRadius = trackImage.frame.height/2
        trackImage.translatesAutoresizingMaskIntoConstraints = false
        
        let trackName = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        trackName.text = "God's Plan"
        trackName.font = .systemFont(ofSize: 16, weight: .regular)
        trackName.textColor = K.AppColors.white
        trackName.translatesAutoresizingMaskIntoConstraints = false
        trackName.textAlignment = .center
        
        let artistName = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        artistName.text = "Drake"
        artistName.font = .systemFont(ofSize: 14, weight: .bold)
        artistName.textColor = K.AppColors.white
        artistName.translatesAutoresizingMaskIntoConstraints = false
        artistName.textAlignment = .center
        
        playerView.addSubview(trackInfoStack)
        
        trackInfoStack.addArrangedSubview(trackImage)
        trackInfoStack.addArrangedSubview(namesStack)
        
        namesStack.addArrangedSubview(trackName)
        namesStack.addArrangedSubview(artistName)
        
        let controlStack: UIStackView = {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalSpacing
            $0.spacing = 10
            $0.translatesAutoresizingMaskIntoConstraints = false
            return $0
        }(UIStackView())
        
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
        
        playerView.addSubview(controlStack)
        
        self.view.addSubview(playerView)
        
        NSLayoutConstraint.activate([
            playerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            playerView.heightAnchor.constraint(equalToConstant: 175),
            playerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            trackInfoStack.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: +20),
            trackInfoStack.topAnchor.constraint(equalTo: playerView.topAnchor, constant: +10),
            trackInfoStack.bottomAnchor.constraint(equalTo: playerView.bottomAnchor, constant: -100),
            
            controlStack.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -20),
            controlStack.topAnchor.constraint(equalTo: playerView.topAnchor, constant: +10),
            controlStack.bottomAnchor.constraint(equalTo: playerView.bottomAnchor, constant: -100),
            
            trackImage.heightAnchor.constraint(equalToConstant: 50),
            trackImage.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func onPrevButtonTap() {
        
    }
    @objc func onPlayButtonTap() {
        playerView.isHidden = true
    }
    @objc func onNextButtonTap() {}
}

extension UIImage {
  func withInsets(_ insets: UIEdgeInsets) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(
      CGSize(width: size.width + insets.left + insets.right,
             height: size.height + insets.top + insets.bottom),
      false,
      self.scale)
    let origin = CGPoint(x: insets.left, y: insets.top)
    self.draw(at: origin)
    let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return imageWithInsets
  }
}

// MARK: - AlbumFetcher Section
extension HomeViewController: AlbumFetcher {
    func didUpdateAlbums(_ albumManager: AlbumFetcherManager, albums: [Album]) {
        self.albums = albums
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
            
}
