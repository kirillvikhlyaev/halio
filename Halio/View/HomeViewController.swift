//
//  ViewController.swift
//  Halio
//
//  Created by Кирилл on 20.09.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    let pageLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.text = "Главная"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = K.AppColors.primary
        self.view.addSubview(pageLabel)
        pageLabel.center = self.view.center
        getTestButton()
    }
    
    func getTestButton() {
        let button = UIButton(frame: CGRect(x: 100, y: 100 , width: 100, height: 50))
        button.setTitle("Test", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
        button.backgroundColor = K.AppColors.secondary
        button.layer.cornerRadius = 25
        button.titleEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        button.addTarget(self, action: #selector(onTestClick), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    @objc func onTestClick() {
        self.navigationController?.pushViewController(PlayerViewController(), animated: true)
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

