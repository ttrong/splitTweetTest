//
//  TweetTableViewCell.swift
//  subTweet
//
//  Created by Trong Ton on 6/12/18.
//  Copyright © 2018 trong.ton2003@gmail.com. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetLable: UILabel!
    @IBOutlet weak var countLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
