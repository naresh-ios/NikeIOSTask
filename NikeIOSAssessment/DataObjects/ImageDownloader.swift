import UIKit

class ImageDownloader: NSObject {
    
    static let imageCache = NSCache<NSString, UIImage>()
    
    static func downloadImage(url: URL?, completion: @escaping (_ image: UIImage?, _ error: Error? ) -> Void) {

        guard let unwrappedUrl = url else {
            DispatchQueue.main.async {
                completion(nil, NSError(domain: "Invalid image url", code: 500, userInfo: nil))
            }
            return
        }
        
        if let cachedImage = imageCache.object(forKey: unwrappedUrl.absoluteString as NSString) {
            DispatchQueue.main.async {
                completion(cachedImage, nil)
            }
        } else {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            session.dataTask(with: unwrappedUrl) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                } else if let data = data, let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: unwrappedUrl.absoluteString as NSString)
                    DispatchQueue.main.async {
                        completion(image, nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil, NSError(domain: unwrappedUrl.absoluteString, code: 500, userInfo: nil))
                    }
                }
                }.resume()
        }
    }
}
