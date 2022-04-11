//
//  RepoDetailsCell.swift
//  TrendingRepositoriesGitHub
//
//  Created by Guy Twig on 11/04/2022.
//

import UIKit

class RepoDetailsCell: UITableViewCell {
    
    static var nibName = "RepoDetailsCell"
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    var index = Int()
    var indexPathRow = Int()
    var repos: [Items] = []
    var titles: [String] = []
    var content : [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateContent() {
        titleLabel.text = titles[indexPathRow]
        textView.text = content[indexPathRow]
    }
}
