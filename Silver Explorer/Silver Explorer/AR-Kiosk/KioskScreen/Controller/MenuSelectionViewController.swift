////
////  menuSelectionViewController.swift
////  Silver Explorer
////
////  Created by 김정원 on 2023/08/03.
////


import UIKit

class MenuSelectionViewController : UIViewController, UITableViewDelegate, KioskMainBoardDelegate {
    func productForSelectingOption() -> Product {
        return product!
    }

    func productForCart(product: Product) {
        
    }

    func totalPriceForPayment() -> Int {
        return 1
    }

    func backToMainScreen() {
        
    }
    @IBAction func goButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "KioskModal", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MembershipViewController") as! MembershipViewController
        vc.kioskMainBoardDelegate = self
        vc.appear(sender: self)
        
    }
    
    func didMembershipVCFinish() {
        let storyboard = UIStoryboard(name: "KioskModal", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PaymentSelectViewController") as! PaymentSelectViewController
        vc.kioskMainBoardDelegate = self
        vc.appear(sender: self)
    }
    var product : Product?

    @IBAction func resetScreenButton(_ sender: Any) {
        print("1")
    }
    @IBOutlet weak var menuSelectionTableView: UITableView!
   
    func appear(sender: UIViewController) {
        self.modalPresentationStyle = .overFullScreen
        sender.present(self, animated: true)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView.delegate = self
//        //collectionView.dataSource = self
//        collectionView.isUserInteractionEnabled = true
//        datasource = UICollectionViewDiffableDataSource<Section, Item> (collectionView: collectionView, cellProvider: {collectionView, indexPath, item in
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as? MenuCollectionViewCell else {
//                return nil            }
//            cell.configure(item)
//            return cell
//        })
//        updateDataSource()  //
//        collectionView.collectionViewLayout = itemLayout()
       

    }
//    func updateDataSource() {
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
//        snapshot.appendSections([.main])
//        snapshot.appendItems(list, toSection: .main)
//        datasource.apply(snapshot, animatingDifferences: true)
//    }
}
//extension MenuSelectionViewController : UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//           print("11")
//       }
//}

