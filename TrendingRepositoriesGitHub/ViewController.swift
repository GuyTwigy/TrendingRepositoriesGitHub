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
    var range: ReposRange?
    var isFavorite = false
    var repos: [String] = ["first", "second", "Third", "forth", "fifth", " sixst", "sevent"]
    var favRepos: [String] = []
    var titleName = String()
    var currentState: ReposRange = .lastDay
    
    @IBAction func lastDayTapped(_ sender: Any){
        setState(state: .lastDay)
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    @IBAction func lastWeekTapped(_ sender: Any) {
        setState(state: .lastWeek)
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    @IBAction func lastMonthTapped(_ sender: Any) {
        setState(state: .LastMonth)
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: ReposCell.nibName, bundle: nil), forCellReuseIdentifier: ReposCell.nibName)
        tableView.isHidden = true
    }
    
    func setState(state: ReposRange) {
        switch state {
        case .lastDay:
            getLastDayRepos()
        case .lastWeek:
            getLastWeekRepos()
        case .LastMonth:
            getLastMonthRepos()
        }
        currentState = state
    }
    
    func updateSectionTitle() {
        if currentState == .lastDay {
            titleName = "Last Day Repositories"
        } else if currentState == .lastWeek {
            titleName = "Last Week Repositories"
        } else {
            titleName = "Last Month Repositories"
        }
    }
    
    func getLastDayRepos() {
        
    }
    
    func getLastWeekRepos() {
        
    }
    
    func getLastMonthRepos() {
        
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Favorits Repositories"
        } else {
            updateSectionTitle()
            return titleName
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return favRepos.count
        } else {
            return repos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReposCell.nibName, for: indexPath) as! ReposCell
        
        if indexPath.section == 0 {
            if favRepos.isEmpty {
                
            }
        }
        cell.repositoryName.text = repos[indexPath.row]
        cell.updateCellContent()
        cell.index = indexPath.row
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        220
    }
}

extension ViewController: ReposCellDelegate {
    func passData(isFavorite: Bool, _ index: Int) {
        if isFavorite {
            if !favRepos.contains(where: {$0 == repos[index]}) {
                favRepos.append(repos[index])
                tableView.reloadData()
            }
        } else if favRepos.contains(where: {$0 == repos[index]}) {
            favRepos.removeAll(where: {$0 == repos[index]})
            tableView.reloadData()
        }
    }
}
