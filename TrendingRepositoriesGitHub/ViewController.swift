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
    
    var range: ReposRange?
    var isFavorite = false
    var repos: [Items] = []
    var favRepos: [Items] = []
    var pageCounter = 1
    var titleName = String()
    var currentState: ReposRange = .lastDay
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: ReposCell.nibName, bundle: nil), forCellReuseIdentifier: ReposCell.nibName)
        tableView.isHidden = true
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
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
        UtilsNetworkManager.shared.getYesterdayRepositories { result, repositories in
            guard let repositories = repositories else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.repos = repositories.sorted(by: {$0.stargazers_count ?? 0 > $1.stargazers_count ?? 0})
                self.tableView.reloadData()
                self.loader.stopAnimating()
            }
        }
        
    }
    
    func lastWeekRepos() {
        repos = []
        pageCounter = 1
        tableView.isHidden = false
        UtilsNetworkManager.shared.getLastWeekRepositories { result, repositories in
            guard let repositories = repositories else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.repos = repositories.sorted(by: {$0.stargazers_count ?? 0 > $1.stargazers_count ?? 0})
                self.tableView.reloadData()
                self.loader.stopAnimating()
            }
        }
        
    }
    
    func lastMonthRepos() {
        repos = []
        pageCounter = 1
        tableView.isHidden = false
        UtilsNetworkManager.shared.getLastMonthRepositories { result, repositories in
            guard let repositories = repositories else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.repos = repositories.sorted(by: {$0.stargazers_count ?? 0 > $1.stargazers_count ?? 0})
                self.tableView.reloadData()
                self.loader.stopAnimating()
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
        cell.delegate = self
        
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
            pageCounter += 1
            if currentState == .lastDay {
                loader.startAnimating()
                UtilsNetworkManager.shared.getYesterdayRepositories(page: pageCounter) { result, repositories in
                    DispatchQueue.main.async { [weak self] in
                        guard let repositories = repositories else {
                            return
                        }
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else {
                                return
                            }
                            self.repos.append(contentsOf: repositories.sorted(by:{$0.stargazers_count ?? 0 > $1.stargazers_count ?? 0}))
                            self.loader.stopAnimating()
                        }
                    }
                }
            } else if currentState == .lastWeek {
                loader.startAnimating()
                UtilsNetworkManager.shared.getLastWeekRepositories(page: pageCounter) { result, repositories in
                    DispatchQueue.main.async { [weak self] in
                        guard let repositories = repositories else {
                            return
                        }
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else {
                                return
                            }
                            self.repos.append(contentsOf: repositories.sorted(by:{$0.stargazers_count ?? 0 > $1.stargazers_count ?? 0}))
                            self.loader.stopAnimating()
                        }
                    }
                }
            } else if currentState == .LastMonth {
                loader.startAnimating()
                UtilsNetworkManager.shared.getLastMonthRepositories(page: pageCounter) { result, repositories in
                    DispatchQueue.main.async { [weak self] in
                        guard let repositories = repositories else {
                            return
                        }
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else {
                                return
                            }
                            self.repos.append(contentsOf: repositories.sorted(by:{$0.stargazers_count ?? 0 > $1.stargazers_count ?? 0}))
                            self.loader.stopAnimating()
                        }
                    }
                }
            }
        }
    }
}


extension ViewController: ReposCellDelegate {
    func passData(_ index: Int) {
        if !favRepos.contains(where: {$0.html_url == repos[index].html_url}) {
            favRepos.append(repos[index])
            tableView.reloadData()
        }
    }
}

