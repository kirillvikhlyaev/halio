//
//  ViewController.swift
//  Halio
//
//  Created by Кирилл on 20.09.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = K.AppColors.primary
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SongCell.self, forCellReuseIdentifier: "SongCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = K.AppColors.primary
        self.view.addSubview(tableView)
        self.setupUI()
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
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = SongsTableSection(rawValue: indexPath.section)!
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongCell
        cell.headerLabel.text = section.title
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
    
    // TODO: После добавления перехода при нажатии на ячейку убрать эту часть кода
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Table index \(indexPath.row)")
        self.navigationController?.pushViewController(PlayerViewController(), animated: true)
    }
}
