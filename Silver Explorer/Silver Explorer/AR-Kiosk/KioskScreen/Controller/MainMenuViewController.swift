//
//  MainMenuViewController.swift
//  Silver Explorer
//
//  Created by 김정원 on 2023/08/05.
//

import UIKit

class MainMenuViewController: UIViewController,UICollectionViewDelegate {
    
    
    
    // 상단 메뉴바 선택 프로퍼티
    @IBAction func categorySegement(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
           case 0:
               list = menuInfo.newList
           case 1:
               list = menuInfo.coffeeList
           case 2:
               list = menuInfo.baverageList
           default:
               break
           }
           updateDataSource()
    }
    
    // 컬렉션 뷰 구성 관련 프로퍼티
    @IBOutlet weak var collectionView: UICollectionView!
    var list : [menuInfo] = menuInfo.newList
    var selectedProduct: Product?
    
    typealias Item = menuInfo
    var datasource : UICollectionViewDiffableDataSource<Section,Item>!
    enum Section {
        case main
    }
    // 데이터 소스
    func updateDataSource() {
    
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(list, toSection: .main)
        datasource.apply(snapshot, animatingDifferences: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        datasource = UICollectionViewDiffableDataSource<Section, Item> (collectionView: collectionView, cellProvider: {collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as? MenuCollectionViewCell else {
                return nil            }
            cell.configure(item)
            return cell
        })
        updateDataSource()  //
        collectionView.collectionViewLayout = itemLayout()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let product = list[indexPath.item]
        selectedProduct = Product(productName: product.name, productType: product.type, price: product.price)
        
        let storyboard = UIStoryboard(name: "KioskModal", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductOptionSelectViewController") as! ProductOptionSelectViewController
        vc.kioskMenuBoardDelegate = self
        vc.appear(sender: self)
        
        
    }

}
extension MainMenuViewController : KioskMainBoardDelegate {
    func didMembershipVCFinish() {
        
    }

    func productForSelectingOption() -> Product {
        
        return selectedProduct!
    }
    
    func productForCart(product: Product) {
        
    }
    
    func totalPriceForPayment() -> Int {
        return 1
    }
    
    func backToMainScreen() {
        
        let storyboard = UIStoryboard(name: "KioskMainBoard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "KioskMainBoardViewController") as! KioskMainBoardViewController
        vc.appear(sender: self)
        
    }
    
    
}
