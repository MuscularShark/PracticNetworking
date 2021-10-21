//
//  ImageViewController.swift
//  PracticNetworking
//
//  Created by Сергей Гнидь on 20.10.2021.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet weak var downloadImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDownloadImage()
    }
    
    private func setupDownloadImage() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        guard let url = URL(string: "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg") else {return}
        
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
