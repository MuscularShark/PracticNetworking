//
//  AllDataViewController.swift
//  PracticNetworking
//
//  Created by Сергей Гнидь on 20.10.2021.
//

import UIKit

class AllDataViewController: UIViewController {
    @IBOutlet private weak var allDataTableView: UITableView!
    
    private var arrayOfJSON = [DataJson]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCell()
        setupData()
    }

    private func setupData() {
        guard let url = URLStorage.jsonData else { return }

        FetchData.shared.getData(url: url, onCompletion: { (fetchedData: [DataJson]) in
            DispatchQueue.main.async {
                self.arrayOfJSON = fetchedData
                self.allDataTableView.reloadData()
            }
        })
    }

    private func setupCell() {
        allDataTableView.register(JsonTableViewCell.nib(), forCellReuseIdentifier: JsonTableViewCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension AllDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfJSON.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: JsonTableViewCell.identifier, for: indexPath)
        guard let cell = tableViewCell as? JsonTableViewCell else { return UITableViewCell() }
        cell.setupCell(data: arrayOfJSON[indexPath.row])
        return cell
    }
}
