//
//  NetworkViewController.swift
//  PracticNetworking
//
//  Created by Сергей Гнидь on 20.10.2021.
//

import UIKit

class NetworkViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func pressGetButton(_ sender: UIButton) {
        callGetRequest()
    }
    
    @IBAction func pressPostButton(_ sender: UIButton) {
        pushUploadImageViewController()
    }
    
    @IBAction func pressDownloadButton(_ sender: UIButton) {
        pushImageViewController()
    }

    @IBAction func pressAllDataButton(_ sender: UIButton) {
        pushAllDataViewController()
    }
    
    private func pushAllDataViewController() {
        let allDataVC: AllDataViewController = UIStoryboard.instantiateViewController()
        
        navigationController?.pushViewController(allDataVC, animated: true)
    }
    
    private func pushUploadImageViewController() {
        let uploadImageVC: UploadImageViewController  = UIStoryboard.instantiateViewController()
        
        navigationController?.pushViewController(uploadImageVC, animated: true)
    }
    
    private func pushImageViewController() {
        let imageVC: ImageViewController = UIStoryboard.instantiateViewController()
        
        navigationController?.pushViewController(imageVC, animated: true)
    }
    
    private func callGetRequest() {
        guard let url = URLStorage.jsonData else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
            print(data)
        }.resume()
    }
}
