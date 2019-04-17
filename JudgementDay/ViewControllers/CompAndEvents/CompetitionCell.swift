//
//  CompetitionCell.swift
//  JudgementDay
//
//  Created by Mackenzie Hampel on 4/14/19.
//  Copyright © 2019 Weber State. All rights reserved.
//


import UIKit

class CompetitionCell: UITableViewCell {
    
    
    @IBOutlet weak var compName: UILabel!
    @IBOutlet weak var competitorCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpCell(comp: Competition) -> Void {
        compName.text = comp.name != nil ? comp.name : ""
        competitorCount.text = comp.users != nil ? String(describing: comp.users!.allObjects.count) : "0"
    }
    
}
