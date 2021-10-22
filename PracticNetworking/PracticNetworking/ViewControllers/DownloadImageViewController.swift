//
//  DownloadImageViewController.swift
//  PracticNetworking
//
//  Created by Сергей Гнидь on 20.10.2021.
//

import UIKit

class DownloadImageViewController: UIViewController {
    @IBOutlet private weak var downloadImageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImage()
    }
    
    private func downloadImage() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        guard let url = URLStorage.downloadImage else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.downloadImageView.image = image
                    self.activityIndicator.stopAnimating()
                }
            }
        }.resume()
    }
}
