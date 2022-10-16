import UIKit



class SearchViewController : UIViewController {
    
//    let songs = ["Hit the lights","Safe and sound","Shut up and dance","Cake","Tonight","Sweet Bitter","Lush life","Ocean drive ","Shake it off","Reality","Sweet Babe"]
//
//    let autors = ["Selena Gomez","Capital cities","Walk The Moon","DNCE","Daniel Blume","Kush Kush","Zara Larsson","Duke Dumont","Taylor Swift","Lost frequencies","HDMI"]
    
    var songs: [Tracks] = []
    
    private var networkFetcher = TrackFetcherManager()
    
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
        //Вызываем получение данных (срабатывет только при запуске отсюда)
        getData()
        
        view.backgroundColor = backgroundColor
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: indetifire)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = backgroundColor
        view.addSubview(tableView)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = K.AppColors.white
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func getData() {
        networkFetcher.trackFetch(limit: 10, searchText: "pop")
        networkFetcher.delegate = self
    }
}

extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = PlayerViewController()
        nextVC.trackArtistName = songs[indexPath.row].artistName
        nextVC.trackImage = songs[indexPath.row].albumImage
        nextVC.trackUrl = songs[indexPath.row].audio
        nextVC.trackDuration = String(songs[indexPath.row].duration)
        nextVC.trackName = songs[indexPath.row].name
        
        self.navigationController?.pushViewController(nextVC, animated: true)
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
        cell?.selectionStyle = .none
        var itemSong: String
        var itemAutor: String
        if isFiltering {
            itemSong = filterSongs[indexPath.row]
            itemAutor = filterAutors[indexPath.row]
        }
        else {
            itemSong = songs[indexPath.row].name
            itemAutor = songs[indexPath.row].artistName
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
        tableView.reloadData()
    }
    
    //так и не заработало ( при вводе текста в поиск запрос отправляется и парситься но не отображается  на экране )
    private func filterContentForSearchText(_ searchText: String ){
        //        let filterItemIndex = songs.indices.filter{songs[$0].lowercased().contains(searchText.lowercased())}
        //        filterAutors = filterItemIndex.map { autors[$0] }
        //        print(filterItemIndex)
//                filterSongs = songs.filter{$0.lowercased().contains(searchText.lowercased())}
//                tableView.reloadData()
        //        if filterItemIndex.isEmpty{
        //            let filterItemIndex = autors.indices.filter{autors[$0].lowercased().contains(searchText.lowercased())}
        //            filterAutors = autors.filter{$0.lowercased().contains(searchText.lowercased())}
        //            print(filterItemIndex)
        //            filterSongs = filterItemIndex.map { songs[$0] }
        
        networkFetcher.trackFetch(limit: 10, searchText: searchText.lowercased())
    }
}
extension SearchViewController: UISearchBarDelegate {
    
}

extension SearchViewController: TracksFetcher {
    
    func didUpdateTracks(result: [Tracks]) {
        songs = result
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError() {
        print("error get tracks")
    }
}


