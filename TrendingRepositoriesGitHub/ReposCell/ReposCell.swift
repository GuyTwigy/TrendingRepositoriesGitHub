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
    var delegate: ReposCellDelegate?
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryDescription: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var addedLabel: UILabel!
    
    
    @IBAction func favTapped(_ sender: Any) {
        favButton.isHidden = true
        addedLabel.isHidden = false
        delegate?.passData(index)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func updateCellContent() {
        userNameLabel.text = repos[index].owner?.login
        repositoryName.text = repos[index].name
        
        if let numStars = repos[index].stargazers_count {
            starsLabel.text = "\(numStars)"
        }
        
        if let description = repos[index].description {
            repositoryDescription.text = description
        } else {
            repositoryDescription.text = "The user didn't insernt any description"
        }

        if let url = repos[index].owner?.avatar_url {
            avatarImageView.image = UIImage(url: URL(string: url))
        } else {
            avatarImageView.image = UIImage(named: "no_avatar")
        }
    }
}
