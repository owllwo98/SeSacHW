//
//  TravelInfoTableViewController.swift
//  SeSacHW8
//
//  Created by 변정훈 on 1/5/25.
//

import UIKit
import Kingfisher

class TravelInfoTableViewController: UITableViewController {

    var travel = TravelInfo().travel
    let adColor: [UIColor] = [.systemPink, .systemGreen, .systemOrange]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        travel[sender.tag].like?.toggle()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if travel[indexPath.row].ad == true {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "adCell", for: indexPath) as! ADTableViewCell
            cell.adButton.setTitle("AD", for: .normal)
            cell.adButton.backgroundColor = .white
            cell.adButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)

            cell.adButton.layer.cornerRadius = 5
            cell.adButton.setTitleColor(.black, for: .normal)
            
            cell.adTextLabel.textAlignment = .center
            cell.adTextLabel.font = .systemFont(ofSize: 16, weight: .bold)
            cell.adTextLabel.text = travel[indexPath.row].title
            cell.adTextLabel.numberOfLines = 3
            cell.layer.cornerRadius = 5
            cell.backgroundColor = adColor.randomElement()
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TravelInfoTableViewCell", for: indexPath) as! TravelInfoTableViewCell
            designTravelCell(cell, indexPath)
            
            if let like = travel[indexPath.row].like {
                cell.likeButton.setImage(UIImage(systemName: like ? "heart.fill" : "heart"), for: .normal)
            } else {
                
            }
            
            cell.likeButton.tintColor = .white
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if travel[indexPath.row].ad == true {
            return 80
        } else {
            return 140
        }
    }

}


@MainActor func designTravelCell(_ cell: TravelInfoTableViewCell,_ indexPath: IndexPath) {
    let travel = TravelInfo().travel
    
    let row = travel[indexPath.row]
    
    let numberFormat  = NumberFormatter()
    numberFormat.numberStyle = .decimal
    
    // if let / guard let 만 쓰다가 다양한 방법이 있을까 고민하다보니 좀 이상한? 느낌입니다,
    do {
        let title = try unWrap(row.title)
        cell.titleLabel.text = title
    } catch {
        cell.titleLabel.text = "글자가 없어요"
    }
    
    do {
        let save = try unWrap(row.save)
        let result = numberFormat.string(from: NSNumber(value: save))
        guard let result else {
            print("result nil값 발생")
            return
        }
        cell.saveLabel.text = "저장 " + result
    } catch {
        cell.saveLabel.text = "글자가 없어용"
    }
    
    do {
        let description = try unWrap(row.description)
        cell.descriptionLabel.text = description
    } catch {
        cell.descriptionLabel.text = "글자가 없어용"
    }
    
    
    guard let travelImage = row.travel_image else {
        cell.travelImageView.image = UIImage(systemName: "star")
        return
    }
    
    let url = URL(string: travelImage)
    cell.travelImageView.kf.setImage(with: url)
    cell.travelImageView.contentMode = .scaleAspectFill
    cell.travelImageView.layer.cornerRadius = 5
    
    cell.titleLabel.font = .systemFont(ofSize: 16, weight: .black)
    cell.titleLabel.numberOfLines = 2
    
    cell.descriptionLabel.font = .systemFont(ofSize: 12, weight: .semibold)
    cell.descriptionLabel.textColor = .gray
    cell.descriptionLabel.numberOfLines = 2
    
    cell.saveLabel.textColor = .gray
    cell.saveLabel.font = .systemFont(ofSize: 8, weight: .regular)
    
}

enum unWrapError: Error {
    case unWrapError
}

func unWrap<T> (_ optional: T?) throws -> T {
    guard let value = optional else {
        throw unWrapError.unWrapError
    }
    return value
}
