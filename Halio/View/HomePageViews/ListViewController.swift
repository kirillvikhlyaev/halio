//
//  ListViewController.swift
//  Halio
//
//  Created by Tatyana Sidoryuk on 23.09.2022.
//

import UIKit


class ListViewController : UIViewController {
    
    let songs = ["Hit the lights","Safe and sound","Shut up and dance","Cake","Tonight","Sweet Bitter","Lush life","Ocean drive ","Shake it off","Reality","Sweet Babe"]
    
    let autors = ["Selena Gomez","Capital cities","Walk The Moon","DNCE","Daniel Blume","Kush Kush","Zara Larsson","Duke Dumont","Taylor Swift","Lost frequencies","HDMI"]
    
    let numbers = [234, 104, 23, 44, 442, 424, 22, 11, 24, 23, 11]
    
    let backgroundColor = K.AppColors.primary
    let tableView = UITableView()
    let identifier = "myCell"
    
    public lazy var numberPlays: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textColor = UIColor(red: 0.831, green: 0.831, blue: 0.831, alpha: 1)
        label.font = UIFont(name: "Abel-Regular", size: 9)
        return label
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = backgroundColor
        view.addSubview(tableView)
        definesPresentationContext = true
    }
}

extension ListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(PlayerViewController(), animated: true)
    }
}

extension ListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: identifier)
        cell?.backgroundColor = backgroundColor
        cell?.textLabel?.textColor = UIColor(red: 0.848, green: 0.848, blue: 0.848, alpha: 1)
        cell?.detailTextLabel?.textColor = UIColor(red: 0.848, green: 0.848, blue: 0.848, alpha: 1)
        cell?.selectionStyle = .none
        var itemSong: String
        var itemAutor: String
        itemSong = songs[indexPath.row]
        itemAutor = autors[indexPath.row]
        cell?.textLabel?.text = itemSong
        cell?.textLabel?.font = UIFont(name: "Abel-Regular", size: 15)
        cell?.detailTextLabel?.text = itemAutor
        cell?.detailTextLabel?.font = UIFont(name: "Abel-Regular", size: 12)
        cell?.imageView?.image =  #imageLiteral(resourceName: "music-round")
        return cell!
    }
}

