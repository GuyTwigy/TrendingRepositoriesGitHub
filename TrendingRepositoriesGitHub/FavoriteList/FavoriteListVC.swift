//
//  FavoriteListVC.swift
//  TrendingRepositoriesGitHub
//
//  Created by Guy Twig on 11/04/2022.
//

import UIKit

class FavoriteListVC: UIViewController {

    var favRepos: [Items] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noReposLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortArray()
        if let favoriteList = UserDefaults.standard.favListSave {
            favRepos = favoriteList
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: ReposCell.nibName, bundle: nil), forCellReuseIdentifier: ReposCell.nibName)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        alertNoInternetConnection()
    }
    
    func sortArray() {
        let temp = favRepos.sorted(by: {$0.stargazers_count ?? 0 > $1.stargazers_count ?? 0})
        favRepos = temp
    }
    
    func setContent() {
        if favRepos.isEmpty {
            tableView.isHidden = true
            noReposLabel.isHidden = false
        } else {
            noReposLabel.isHidden = true
        }
        
        for item in favRepos {
            if !favRepos.contains(where: {$0.name == item.name}) {
                favRepos.append(item)
            }
            sortArray()
            UserDefaults.standard.favListSave = favRepos
        }
    }
    
    func alertNoInternetConnection() {
        if !NetworkMonitor.shared.isConnnected {
            presentAlert(withTitle: "No Internet Connection", message: "Please check your connetion")
        }
    }
}

extension FavoriteListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favRepos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReposCell.nibName, for: indexPath) as! ReposCell
        
        cell.favButton.isHidden = true
        cell.removeButton.isHidden = false
        cell.index = indexPath.row
        cell.repos = favRepos
        cell.updateCellContent()
        cell.delegateToFavorite = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoDetails = RepositoryDetails()
        repoDetails.repos = favRepos
        repoDetails.index = indexPath.row
        navigationController?.pushViewController(repoDetails, animated: true)
    }
}

extension FavoriteListVC: ReposCellDelegate {
    func passData(_ index: Int) {
        favRepos.remove(at: index)
        if favRepos.isEmpty {
            noReposLabel.isHidden = false
        }
        tableView.reloadData()
        UserDefaults.standard.favListSave = favRepos
    }
}
