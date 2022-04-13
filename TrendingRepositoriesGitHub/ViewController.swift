//
//  ViewController.swift
//  TrendingRepositoriesGitHub
//
//  Created by Guy Twig on 08/04/2022.
//

import UIKit

enum ReposRange {
    case lastDay
    case lastWeek
    case LastMonth
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var repos: [Items] = []
    var favRepos: [Items] = []
    var pageCounter = 1
    var titleName = String()
    var currentState: ReposRange = .lastDay
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let favoriteList = UserDefaults.standard.favListSave {
            favRepos = favoriteList
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: ReposCell.nibName, bundle: nil), forCellReuseIdentifier: ReposCell.nibName)
        tableView.isHidden = true
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func favotiteListTapped(_ sender: Any) {
        let favVC = FavoriteListVC()
        navigationController?.pushViewController(favVC, animated: true)
    }
    
    @IBAction func lastDayTapped(_ sender: Any){
        loader.startAnimating()
        setState(state: .lastDay)
    }
    
    @IBAction func lastWeekTapped(_ sender: Any) {
        loader.startAnimating()
        setState(state: .lastWeek)
        
    }
    
    @IBAction func lastMonthTapped(_ sender: Any) {
        loader.startAnimating()
        setState(state: .LastMonth)
    }
    
    func setState(state: ReposRange) {
        switch state {
        case .lastDay:
            yesterdayRepos()
        case .lastWeek:
            lastWeekRepos()
        case .LastMonth:
            lastMonthRepos()
        }
        currentState = state
    }
    
    func updateSectionTitle() {
        if currentState == .lastDay {
            titleName = "Last Day Repositories"
        } else if currentState == .lastWeek {
            titleName = "Last Week Repositories"
        } else if currentState == .LastMonth {
            titleName = "Last Month Repositories"
        }
    }
    
    func yesterdayRepos() {
        repos = []
        pageCounter = 1
        tableView.isHidden = false
        NetworkManager.shared.getYesterdayRepositories { result, repositories in
            self.LoadDataNetWorkCall(repositories: repositories, firstLoad: true)
        }
    }
    
    func lastWeekRepos() {
        repos = []
        pageCounter = 1
        tableView.isHidden = false
        NetworkManager.shared.getLastWeekRepositories { result, repositories in
            self.LoadDataNetWorkCall(repositories: repositories, firstLoad: true)
        }
    }
    
    func lastMonthRepos() {
        repos = []
        pageCounter = 1
        tableView.isHidden = false
        NetworkManager.shared.getLastMonthRepositories { result, repositories in
            self.LoadDataNetWorkCall(repositories: repositories, firstLoad: true)
        }
    }

    func LoadDataNetWorkCall(repositories: [Items]?, firstLoad: Bool) {
        guard let repositories = repositories else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            if firstLoad {
                self.repos = repositories.sorted(by: {$0.stargazers_count ?? 0 > $1.stargazers_count ?? 0})
            } else {
                self.repos.append(contentsOf: repositories.sorted(by:{$0.stargazers_count ?? 0 > $1.stargazers_count ?? 0}))
            }
            self.tableView.reloadData()
            self.loader.stopAnimating()
        }
    }
    
    func loadMoreData() {
        pageCounter += 1
        if currentState == .lastDay {
            loader.startAnimating()
            NetworkManager.shared.getYesterdayRepositories(page: pageCounter) { result, repositories in
                self.LoadDataNetWorkCall(repositories: repositories, firstLoad: false)
            }
        } else if currentState == .lastWeek {
            loader.startAnimating()
            NetworkManager.shared.getLastWeekRepositories(page: pageCounter) { result, repositories in
                self.LoadDataNetWorkCall(repositories: repositories, firstLoad: false)
            }
        } else if currentState == .LastMonth {
            loader.startAnimating()
            NetworkManager.shared.getLastMonthRepositories(page: pageCounter) { result, repositories in
                self.LoadDataNetWorkCall(repositories: repositories, firstLoad: false)
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        updateSectionTitle()
        return titleName
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReposCell.nibName, for: indexPath) as! ReposCell
        cell.repos = repos
        cell.index = indexPath.row
        cell.updateCellContent()
        cell.delegateToVC = self
        cell.isFav = favRepos.contains(where: {$0.name == repos[indexPath.row].name})
        if cell.isFav {
            cell.favButton.isHidden = true
            cell.addedLabel.isHidden = false
        } else {
            cell.favButton.isHidden = false
            cell.addedLabel.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoDetails = RepositoryDetails()
        repoDetails.repos = repos
        repoDetails.index = indexPath.row
        navigationController?.pushViewController(repoDetails, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == repos.count - 1 ) {
        loadMoreData()
        }
    }
}


extension ViewController: ReposCellDelegate {
    func passData(_ index: Int) {
        if !favRepos.contains(where: {$0.name == repos[index].name}) {
            favRepos.append(repos[index])
            UserDefaults.standard.favListSave = favRepos
            tableView.reloadData()
        } else {
            let alert = UIAlertController(title: "Already in list", message: "You can't add it again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
