//
//  ViewController.swift
//  rickandmorty
//
//  Created by Edno Fedulo on 05/12/20.
//  Copyright © 2020 Edno Fedulo. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var viewModel:HomeViewModel?
    
    init(viewModel:HomeViewModel) {
        self.viewModel = viewModel
        super.init(style: .insetGrouped)
        self.viewModel?.fetchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = self.viewModel?.screenTitle
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.characters?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
        
        guard let character = self.viewModel?.getCharacter(for: indexPath.row) else { return UITableViewCell() }
        
        cell.textLabel?.text = character.name
        cell.detailTextLabel?.text = "\(character.species!) - \(character.gender!)"
        cell.imageView?.layer.cornerRadius = 25
        cell.imageView?.clipsToBounds = true
        
        if let image = character.image, let url = URL(string: image) {
            cell.imageView?.load(from: url, dimension: 50)
        }
        
        if let isFavorited = character.isFavorited, isFavorited {
            cell.accessoryView = UIImageView(image: UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)).withTintColor(.systemYellow)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == self.viewModel?.characters?.count {
            self.viewModel?.fetchData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.didSelectRow(at: indexPath.row)
    }

}

extension HomeTableViewController: HomeViewModelViewDelegate {
    func didFetchDataFromAPISuccess(sender: HomeViewModel) {
        self.tableView.reloadData()
    }
    
    func didFetchDataFromAPIFail(sender: HomeViewModel) {
        let alert = UIAlertController(title: "Error", message: "Ocorreu um problema ao obter as informações.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

