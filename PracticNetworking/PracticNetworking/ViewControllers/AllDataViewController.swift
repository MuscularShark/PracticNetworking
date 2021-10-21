//
//  AllDataViewController.swift
//  PracticNetworking
//
//  Created by Сергей Гнидь on 20.10.2021.
//

import UIKit

class AllDataViewController: UIViewController {
    
    @IBOutlet weak var allDataTableView: UITableView!
    
    var arr = [Date]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        print(arr)
    }
    
    func getData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                self.arr = try decoder.decode([Date].self, from: data)
            } catch {
                print(error)
            }
        }.resume()
    }
}

extension AllDataViewController: UITableViewDelegate {
    
}

extension AllDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    
}


                                     
