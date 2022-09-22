import UIKit



class SearchViewController : UIViewController {
    
    let songs = ["Hit the lights","Safe and sound","Shut up and dance","Cake","Tonight","Sweet Bitter","Lush life","Ocean drive ","Shake it off","Reality","Sweet Babe"]
    
    let autors = ["Selena Gomez","Capital cities","Walk The Moon","DNCE","Daniel Blume","Kush Kush","Zara Larsson","Duke Dumont","Taylor Swift","Lost frequencies","HDMI"]
    
    
    
    let backgroundColor = K.AppColors.primary
    let musicColor = UIColor(red: 254/255, green: 255/255, blue: 255/255, alpha: 0.5)
    let autorColor = UIColor(red: 202/255, green: 202/255, blue: 202/255, alpha: 0.5)
    
    var filterSongs:[String] = []
    var filterAutors:[String] = []
    let tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    let indetifire = "myCell"
    
    private var searchBarIsEmpty: Bool{
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    
    private var isFiltering: Bool{
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: indetifire)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = backgroundColor
        view.addSubview(tableView)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Serch"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filterSongs.count
        }
        return songs.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: indetifire)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: indetifire)
        cell?.backgroundColor = backgroundColor
        cell?.textLabel?.textColor = musicColor
        cell?.detailTextLabel?.textColor = autorColor
        var itemSong: String
        var itemAutor: String
        if isFiltering {
            itemSong = filterSongs[indexPath.row]
            itemAutor = filterAutors[indexPath.row]
        }
        else {
            itemSong = songs[indexPath.row]
            itemAutor = autors[indexPath.row]
        }
        
        cell?.textLabel?.text = itemSong
        cell?.detailTextLabel?.text = itemAutor
        cell?.imageView?.image =  #imageLiteral(resourceName: "music-round")
        return cell!
    }
}

extension SearchViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String ){
        let filterItemIndex = songs.indices.filter{songs[$0].lowercased().contains(searchText.lowercased())}
        filterAutors = filterItemIndex.map { autors[$0] }
        print(filterItemIndex)
        filterSongs = songs.filter{$0.lowercased().contains(searchText.lowercased())}
        tableView.reloadData()
        if filterItemIndex.isEmpty{
            let filterItemIndex = autors.indices.filter{autors[$0].lowercased().contains(searchText.lowercased())}
            filterAutors = autors.filter{$0.lowercased().contains(searchText.lowercased())}
            print(filterItemIndex)
            filterSongs = filterItemIndex.map { songs[$0] }
            tableView.reloadData()
        }
    }
}

