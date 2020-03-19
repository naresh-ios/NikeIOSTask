import UIKit
import Foundation

class ListViewController: UIViewController {
    let resultsTableView = UITableView()
    var safeArea: UILayoutGuide?
    let cellID = "cell"
    let serviceURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json"
    var feedDataObject: RSSFeedDataObject?

    override func loadView() {
        getDataFromService()
        super.loadView()
        view.backgroundColor = .white
        navigationItem.title = "List View"
        safeArea = view.layoutMarginsGuide
        setUpTableView()
    }

    func doTableRefresh() {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                self.resultsTableView.reloadData()
            }
        }
    }
    
    func setUpTableView() {
        self.view.addSubview(resultsTableView)
        resultsTableView.translatesAutoresizingMaskIntoConstraints = false
        setUpConstraints()
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    func setUpConstraints() {
        guard let safeArea = safeArea else { return }
        resultsTableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        resultsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        resultsTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        resultsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    override func viewWillAppear(_ animated: Bool) {
        if let index = self.resultsTableView.indexPathForSelectedRow{
            self.resultsTableView.deselectRow(at: index, animated: false)
        }
    }

    func getDataFromService() {
        guard let getUrl = URL(string: serviceURL) else { return }
        let task = URLSession.shared.dataTask(with: getUrl) {(data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(RSSFeedDataObject.self, from: data)
                self.feedDataObject = apiResponse
            } catch let error {
                print("Failed to decode JSON:", error)
            }
            self.doTableRefresh()
        }
        task.resume()
    }
}


extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedDataObject?.feed.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AlbumTableViewCell, let dataObject = feedDataObject else { return UITableViewCell() }
        let object = dataObject.feed.results[indexPath.row]
        cell.product = ProductAlbum(artistName: object.artistName, albumName: object.name, albumImage: object.artworkUrl100)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.viewModel = DetailViewControllerViewModel(productAlbum: feedDataObject?.feed.results[indexPath.row])
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
