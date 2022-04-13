//
//  ReposCell.swift
//  TrendingRepositoriesGitHub
//
//  Created by Guy Twig on 10/04/2022.
//

import UIKit

protocol ReposCellDelegate {
    func passData(_ index: Int)
}

class ReposCell : UITableViewCell {
    
    static var nibName = "ReposCell"
    var isFav = false
    var index = Int()
    var repos: [Items] = []
    var delegateToVC: ReposCellDelegate?
    var delegateToFavorite: ReposCellDelegate?
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryDescription: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var addedLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    
    @IBAction func favTapped(_ sender: Any) {
        delegateToVC?.passData(index)
    }
    
    @IBAction func removeTapped(_ sender: Any) {
        delegateToFavorite?.passData(index)
    }
    

    func updateCellContent() {
        userNameLabel.text = repos[index].owner.login
        repositoryName.text = repos[index].name
        avatarImageView.image = UIImage(url: URL(string: repos[index].owner.avatar_url ?? "no_avatar"))
    
        if let numStars = repos[index].stargazers_count {
            starsLabel.text = "\(numStars)"
        }
        
        if let description = repos[index].description {
            repositoryDescription.text = description
        } else {
            repositoryDescription.text = "The user didn't insernt any description"
        }
    }
}
