//
//  MusicTableViewCell.swift
//  30th-3week-seminar
//
//  Created by 김수연 on 2022/04/23.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    // 타입프로퍼티
    static let identifier = "MusicTableViewCell"

    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var musicTitle: UILabel!
    @IBOutlet weak var musicTime: UILabel!
    @IBOutlet weak var menuButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(_ musicData: MusicDataModel) {
        musicImage.image = musicData.albumImage
        musicTitle.text = musicData.musicTitle
        musicTime.text = musicData.description
    }
}
