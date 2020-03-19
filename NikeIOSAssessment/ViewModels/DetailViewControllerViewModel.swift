import Foundation

struct DetailViewControllerViewModel {
    var productAlbum: Result?
    init(productAlbum: Result? = nil) {
        self.productAlbum = productAlbum
    }
}
