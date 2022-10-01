//
//  FavoriteListViewController.swift
//  Halio
//
//  Created by Кирилл on 20.09.2022.
//


import UIKit



class FavoriteListViewController : UIViewController {
    
    let backgroundColor = K.AppColors.primary
    let musicColor = UIColor(red: 254/255, green: 255/255, blue: 255/255, alpha: 0.5)
    let autorColor = UIColor(red: 202/255, green: 202/255, blue: 202/255, alpha: 0.5)
    let tableView = UITableView()
    let indetifire = "myCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Избранное"
        view.backgroundColor = backgroundColor
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: indetifire)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = backgroundColor
        view.addSubview(tableView)
        definesPresentationContext = true
    }
}

extension FavoriteListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(PlayerViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            FavoritesListModel.deleteComposition(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
}

extension FavoriteListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return FavoritesListModel.favoritesSongs.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: indetifire)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: indetifire)
        cell?.backgroundColor = backgroundColor
        cell?.textLabel?.textColor = musicColor
        cell?.detailTextLabel?.textColor = autorColor
        cell?.selectionStyle = .none
        var itemSong: String
        var itemAutor: String
        
        itemSong = FavoritesListModel.favoritesSongs[indexPath.row]
        itemAutor = FavoritesListModel.favoritesAutors[indexPath.row]
        
        
        cell?.textLabel?.text = itemSong
        cell?.detailTextLabel?.text = itemAutor
        cell?.imageView?.image =  #imageLiteral(resourceName: "music-round")
        return cell!
    }
}



