//
//  menuSelectionViewController.swift
//  Silver Explorer
//
//  Created by 김정원 on 2023/08/03.
//

import UIKit

class MenuSelectionViewController : UIViewController, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func resetScreenButton(_ sender: Any) {print("1")
    }
    let menuList : [selectionInfo] = selectionInfo.menuList
    var tableViewItems: [menuInfo] = []
   
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return menuList.count
           
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           // deque your cell
           let cell = tableView.dequeueReusableCell(withIdentifier: "MenuSelectionTableViewCell", for: indexPath)
           return cell
       }
    @IBOutlet weak var menuSelectionTableView: UITableView!
    
    let list : [menuInfo] = menuInfo.list
    let menuInfos : [menuInfo] = menuInfo.list
    typealias Item = menuInfo
    var datasoucre : UICollectionViewDiffableDataSource<Section , Item>!

    enum Section {
        case main
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("ddddd")
        if let selectedItem = datasoucre.itemIdentifier(for: indexPath) {
                tableViewItems.append(selectedItem)
                menuSelectionTableView.reloadData()
            }
       }

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuSelectionTableView.delegate = self
        menuSelectionTableView.dataSource = self
        collectionView.delegate = self
            datasoucre = UICollectionViewDiffableDataSource<Section, Item> (collectionView: collectionView, cellProvider: {collectionView, indexPath, item in
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath)
                            as? MenuCollectionViewCell else {
                        return UICollectionViewCell()
                    }
              //  cell.isUserInteractionEnabled = true
                    cell.configure(item)
                    return cell
                })
        
                // data : snapshot
                var snapshot = NSDiffableDataSourceSnapshot<Section,Item> ()
                snapshot.appendSections([.main])
                snapshot.appendItems(menuInfos,toSection: .main)
                datasoucre.apply(snapshot)
        collectionView.collectionViewLayout = itemLayout()
      //  collectionView.alwaysBounceVertical = false
    }
    

}
