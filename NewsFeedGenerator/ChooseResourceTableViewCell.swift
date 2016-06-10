//
//  ChooseResourceTableViewCell.swift
//  NewsFeedGenerator
//
//  Created by nurzhan on 6/9/16.
//  Copyright © 2016 Nurzhan. All rights reserved.
//

import UIKit

class ChooseResourceTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView?.contentMode = .ScaleAspectFit
        buttonChange()
    }
    func buttonChange(){
        button.frame = CGRectMake(0, 0, 50, 50)
        button.backgroundColor = UIColor.clearColor()
        button.imageEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        //button.setTitle("Checked", forState: .Normal)
        //button.setTitle("Unchecked", forState: .Selected)
       button.setImage(UIImage(named:"add"), forState: .Normal)
       button.setImage(UIImage(named:"check"), forState: .Selected)
        button.addTarget(self, action: #selector(ChooseResourceTableViewCell.didPressButton(_:)), forControlEvents: .TouchUpInside)
    }
    func didPressButton(sender: UIButton){
        sender.selected = !sender.selected

    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = CGRect(x: 0, y: 0, width: 130, height: 130)
    }

}
