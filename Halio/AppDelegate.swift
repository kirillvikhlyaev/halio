//
//  AppDelegate.swift
//  Halio
//
//  Created by Кирилл on 20.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        var views: [UINavigationController] = []
        
        views.append(getFavoriteView())
        views.append(getHomeView())
        views.append(getSearchView())
        views.append(getProfileView())
        
        let tabBarVC = UITabBarController()
        tabBarVC.setViewControllers(views, animated: true)
        
        UITabBar.appearance().barTintColor = K.AppColors.secondary
        UITabBar.appearance().backgroundColor = K.AppColors.secondary
        UITabBar.appearance().tintColor = K.AppColors.white
        
        tabBarVC.tabBar.layer.masksToBounds = true
        tabBarVC.tabBar.isTranslucent = true
        tabBarVC.tabBar.barStyle = .default
        tabBarVC.tabBar.layer.cornerRadius = 20
        tabBarVC.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .clear
        appearance.backgroundColor = K.AppColors.primary
        UINavigationBar.appearance().standardAppearance = appearance
     //   UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = tabBarVC
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
    
    func getFavoriteView() -> UINavigationController {
        let favoriteView = FavoriteListViewController()
        favoriteView.tabBarItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "heart.fill"), tag: 0)
        return UINavigationController(rootViewController: favoriteView)
        
    }
    
    func getHomeView() -> UINavigationController {
        let homeView = HomeViewController()
        homeView.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "music.quarternote.3"), tag: 1)
        return UINavigationController(rootViewController: homeView)
        
    }
    
    func getSearchView() -> UINavigationController {
        let searchView = SearchViewController()
        searchView.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        return UINavigationController(rootViewController: searchView)
        
    }
    
    func getProfileView() -> UINavigationController {
        let profileView = ProfileViewController()
        profileView.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.crop.circle"), tag: 3)
        return UINavigationController(rootViewController: profileView)
        
    }
}

