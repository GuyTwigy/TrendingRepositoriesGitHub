//
//  RepositoryDetails.swift
//  TrendingRepositoriesGitHub
//
//  Created by Guy Twig on 11/04/2022.
//

import UIKit

class RepositoryDetails: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var repos: [Items] = []
    var index = Int()
    var titles = ["Language:", "Number Of Forks:", "created At:", "Repository Link:"]
    lazy var content: [String] = [language, forksNum, createAt, url]
    lazy var language = "\(repos[index].language ?? "No indication for which language used in this repository.")"
    lazy var forksNum = "\(repos[index].forks ?? 0)"
    lazy var createAt = "\(repos[index].created_at ?? "No indication for created date.")"
    lazy var url = "\(repos[index].html_url ?? "No URL provided.")"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: RepoDetailsCell.nibName, bundle: nil), forCellReuseIdentifier: RepoDetailsCell.nibName)
    }
}


extension RepositoryDetails: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoDetailsCell.nibName, for: indexPath) as! RepoDetailsCell
        
        cell.repos = repos
        cell.index = index
        cell.titles = titles
        cell.content = content
        cell.indexPathRow = indexPath.row
        cell.updateContent()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
