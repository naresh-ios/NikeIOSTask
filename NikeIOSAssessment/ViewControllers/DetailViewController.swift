import UIKit

class DetailViewController: UIViewController {
    var safeArea: UILayoutGuide!
    var viewModel = DetailViewControllerViewModel()
    let stackView = UIStackView()
    let imageHeight: CGFloat = 200
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        setupNavigation()
        safeArea = view.layoutMarginsGuide
        setupView()
        setupBottomButton()
    }

    func setupNavigation() {
        navigationItem.title = "Detail View"
    }
    
    func setupView() {
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addImageView()
        addDescriptionLabels()
        self.view.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.safeArea.topAnchor, constant: 20).isActive = true
    }

    func addImageView() {
        if let imageView = viewModel.productAlbum?.artworkUrl100 {
            let imageURL = URL(string: imageView)
            ImageDownloader.downloadImage(url: imageURL, completion: { (image, error) in
                guard let image = image else { return }
                self.stackView.addArrangedSubview(self.getImageView(with: image))
            })
        }
    }

    func addDescriptionLabels() {
        DispatchQueue.main.async {
            if let albumName = self.viewModel.productAlbum?.name {
                self.stackView.addArrangedSubview(self.getLabel(with: "Album Name: \(albumName)"))
            }
            if let artistName = self.viewModel.productAlbum?.artistName {
                self.stackView.addArrangedSubview(self.getLabel(with: "Artist Name: \(artistName)"))
            }
            if self.viewModel.productAlbum?.genres != nil {
                var genres = ""
                var count = 0
                for genre in self.viewModel.productAlbum?.genres ?? [] {
                    genres += genre.name
                    count += 1
                    if self.viewModel.productAlbum?.genres.count != count {
                        genres += ", "
                    }
                }
                self.stackView.addArrangedSubview(self.getLabel(with: "Genre: \(genres)"))
            }
            if let releaseDate = self.viewModel.productAlbum?.releaseDate {
                self.stackView.addArrangedSubview(self.getLabel(with: "Release Date: \(releaseDate)"))
            }
            if let copyright = self.viewModel.productAlbum?.copyright {
                self.stackView.addArrangedSubview(self.getLabel(with: "Copyright: \(copyright)"))
            }
        }
    }
    
    func getLabel(with text: String) -> UILabel {
        let textLabel = UILabel()
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.text  = text
        return textLabel
    }
    
    func getImageView(with image: UIImage) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
        imageView.image = image
        return imageView
    }
    
    func setupBottomButton() {
        let bottomButton = UIButton()
        bottomButton.frame = CGRect(x: 20, y: self.view.frame.height - 70, width: self.view.frame.width - 40, height: 50)
        bottomButton.backgroundColor = .blue
        bottomButton.layer.cornerRadius = 8
        bottomButton.setTitle("iTunes store", for: .normal)
        bottomButton.addTarget(self, action: #selector(iTunesButtonTapped), for: .touchUpInside)
        self.view.addSubview(bottomButton)
    }
    
    @objc func iTunesButtonTapped(_ sender: UIButton) {
        // Navigate to external browser.
        let newLink: String = viewModel.productAlbum?.artistUrl ?? ""
        if let url = URL(string: newLink) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            showErrorAlert()
        }
    }
    
    func showErrorAlert() {
        let alertController = UIAlertController(title: "Sorry", message: "URL is not valid", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
