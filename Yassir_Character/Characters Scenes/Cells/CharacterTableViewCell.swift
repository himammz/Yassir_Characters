//
//  CharacterTableViewCell.swift
//  Yassir_Character
//
//  Created by Ibrahim Mostafa on 29/05/2024.
//

import UIKit
import Kingfisher

class CharacterTableViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: self)
    static var nib:UINib{
        let nib = UINib(nibName: "CharacterTableViewCell", bundle: nil)
        return nib
    }

    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterType: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        characterImageView.layer.cornerRadius = 10
     }

    func fillCell(with viewModel: CharacterViewModel) {
        characterName.text = viewModel.name
        characterType.text = viewModel.species
        characterImageView.kf.setImage(with: viewModel.imageURL)
    }
}

