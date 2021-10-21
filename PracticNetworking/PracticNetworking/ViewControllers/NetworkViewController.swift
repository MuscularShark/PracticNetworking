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
        callPostRequest()
    }
    
    @IBAction func pressDownloadButton(_ sender: UIButton) {
        downloadImage()
    }

    @IBAction func pressAllDataButton(_ sender: UIButton) {
        let allData: AllDataViewController = UIStoryboard.instantiateViewController()
        
        navigationController?.pushViewController(allData, animated: true)
    }
    
    private func downloadImage() {
        let imageViewController: ImageViewController = UIStoryboard.instantiateViewController()
        
        navigationController?.pushViewController(imageViewController, animated: true)
    }
    
    private func callGetRequest() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
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
    
    private func callPostRequest() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let userData = ["Course": "Networking", "Task": "GET and POST requests"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            
            guard let response = response, let data = data else { return }
            
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
}
