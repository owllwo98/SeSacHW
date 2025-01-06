//
//  ShoppingTableViewController.swift
//  SeSacHW8
//
//  Created by 변정훈 on 1/5/25.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    
//    var shopping = ShoppingInfo().shopping
    
    var shopping = ShoppingInfoRepository().items
    

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        shopping[sender.tag].favorite.toggle()
        tableView.reloadData()
    }
    
    @objc func purchaseButtonTapped(_ sender: UIButton) {
        shopping[sender.tag].purchase.toggle()
        tableView.reloadData()
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopping.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = shopping[indexPath.row]
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTableViewCell", for: indexPath) as! ShoppingListTableViewCell
            
            cell.shoppingTextField.placeholder = "무엇을 구매하실 건가요?"
            cell.shoppingTextField.borderStyle = .none
//            cell.shoppingUIView.backgroundColor = .systemGray
            cell.shoppingUIView.layer.cornerRadius = 10
            
            cell.shoppingButton.setTitle("추가", for: .normal)
            cell.shoppingButton.setTitleColor(.black, for: .normal)
//            cell.shoppingButton.backgroundColor = .gray
            cell.shoppingButton.layer.cornerRadius = 10
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
            
            cell.titleLabel.text = row.title
            cell.titleLabel.textColor = .black
            cell.titleLabel.font = .systemFont(ofSize: 12, weight: .semibold)
            
            cell.purchaseButton.setImage(UIImage(systemName: row.purchase ? "checkmark.square.fill" : "checkmark.square"), for: .normal)
            cell.purchaseButton.tintColor = .black
            
            cell.favoriteButton.setImage(UIImage(systemName: row.favorite ? "star.fill" : "star"), for: .normal)
            cell.favoriteButton.tintColor = .black
            
            cell.favoriteButton.tag = indexPath.row
            cell.purchaseButton.tag = indexPath.row
            
            cell.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
            cell.purchaseButton.addTarget(self, action: #selector(purchaseButtonTapped), for: .touchUpInside)
            
            
            return cell
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        } else {
            return 60
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "삭제") { ( _, _, completionHandler) in // 클로저 사용 action 과 view 는 사용하지 않기에 매개변수 생략
            
            // 1. 대상을 지우고
            self.shopping.remove(at: indexPath.row)
            // 2. Data 와 UI 를 동기화해준다.
            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.reloadData()
        }
        
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction])
        
        deleteAction.backgroundColor = .red
        swipeAction.performsFirstActionWithFullSwipe = false
        
        return swipeAction
    }
    
    
    
    @IBAction func addButton(_ sender: UIButton) {
        
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ShoppingListTableViewCell else {
                print("첫 번째 셀을 가져올 수 없습니다.")
                return
            }
        
        guard let adText = cell.shoppingTextField.text, !adText.isEmpty else {
                print("텍스트 필드가 비어 있습니다.")
                return
            }
        
        shopping.append(Shopping(title: adText, favorite: false, purchase: false))
        
        tableView.reloadData()
        
    }
    
    

}
