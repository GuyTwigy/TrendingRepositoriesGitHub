//
//  FavoriteListVC.swift
//  TrendingRepositoriesGitHub
//
//  Created by Guy Twig on 11/04/2022.
//

import UIKit

class FavoriteListVC: UIViewController {

    var favRepos: [Items] = []
    var UpdatedFavRepos: [Items] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noReposLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: ReposCell.nibName, bundle: nil), forCellReuseIdentifier: ReposCell.nibName)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setContent()
    }
    
    func setContent() {
        if favRepos.isEmpty {
            tableView.isHidden = true
        } else {
            noReposLabel.isHidden = true
        }
        
        for item in favRepos {
            if !UpdatedFavRepos.contains(where: {$0.name == item.name}) {
                UpdatedFavRepos.append(item)
            }
            
        }
    }
}

extension FavoriteListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UpdatedFavRepos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReposCell.nibName, for: indexPath) as! ReposCell
        
        cell.favButton.isHidden = true
        cell.index = indexPath.row
        cell.repos = favRepos
        cell.updateCellContent()
        
        return cell
    }
}
