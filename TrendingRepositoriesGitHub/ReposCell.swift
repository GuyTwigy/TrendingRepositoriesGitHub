//
//  ReposCell.swift
//  TrendingRepositoriesGitHub
//
//  Created by Guy Twig on 10/04/2022.
//

import UIKit

protocol ReposCellDelegate {
    func passData(isFavorite: Bool, _ index: Int)
}

class ReposCell : UITableViewCell {
    
    static var nibName = "ReposCell"
    var isFav = false
    var index = Int()
    var delegate: ReposCellDelegate?
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryDescription: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var addOrRemoveFavLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    @IBAction func favTapped(_ sender: Any) {
        isFav = !isFav
        if isFav {
            favButton.setImage(UIImage(systemName: "star"), for: .normal)
            delegate?.passData(isFavorite: true, index)
        } else {
            favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            delegate?.passData(isFavorite: false, index)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func updateCellContent() {
        
    }
}
