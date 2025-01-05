//
//  MagazineInfoTableViewController.swift
//  SeSacHW8
//
//  Created by 변정훈 on 1/3/25.
//

import UIKit
import Kingfisher

class MagazineInfoTableViewController: UITableViewController {
    
    let magazine = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazine.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "MagazineInfoTableViewCell", for: indexPath) as! MagazineInfoTableViewCell

        designMagazineCell(cell, indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 376
    }
}




// UI 업데이트는 Main Thread 에서 진행되어야 하니까
@MainActor func designMagazineCell(_ cell: MagazineInfoTableViewCell,_ indexPath: IndexPath) {
    let magazine = MagazineInfo().magazine
    
    let row = magazine[indexPath.row]
    
    let format = DateFormatter()
    format.dateFormat = "yyMMdd"
    let result = format.date(from: row.date)
    
    guard let result else {
        print("result nil 값 발생")
        return
    }
    
    format.dateFormat = "yy년 MM월 dd일"
    
    
    let image = row.photo_image
    let title = row.title
    let subtitle = row.subtitle
    let date = format.string(from: result)
    
    let url = URL(string: image)
    cell.photoImageView.kf.setImage(with: url)
    cell.photoImageView.contentMode = .scaleAspectFill
    cell.photoImageView.layer.cornerRadius = 5
    
    cell.titleLabel.text = title
    cell.titleLabel.numberOfLines = 2
    cell.titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
    
    cell.subtitleLabel.text = subtitle
    cell.subtitleLabel.numberOfLines = 2
    cell.subtitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
    cell.subtitleLabel.textColor = .gray
    
    cell.dateLabel.text = date
    cell.dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
    cell.dateLabel.textColor = .gray
    
    
}






