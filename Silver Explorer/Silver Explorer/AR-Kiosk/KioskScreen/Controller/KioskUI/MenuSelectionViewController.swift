////
////  menuSelectionViewController.swift
////  Silver Explorer
////
////  Created by 김정원 on 2023/08/03.
////


import UIKit

class MenuSelectionViewController : UIViewController, UITableViewDelegate,UICollectionViewDelegate,UITableViewDataSource {
    
    
    var cartItems : [Product] = []
    
    @IBOutlet weak var totalQuantityLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var menuSelectionTableView: UITableView!
    // 음료타입 설정 프로퍼티
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
    @IBAction func resetButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

    // 컬렉션뷰 관련 프로퍼티
    @IBOutlet weak var collectionView: UICollectionView!
    var list : [menuInfo] = menuInfo.newList
    var selectedProduct: Product?
    
    typealias Item = menuInfo
    var datasource : UICollectionViewDiffableDataSource<Section,Item>!
    enum Section {
        case main
    }
    // 데이터 소스 업데이트
    func updateDataSource() {
    
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(list, toSection: .main)
        datasource.apply(snapshot, animatingDifferences: true)
    }
    @IBAction func moveToMemebershipView(_ sender: Any) {
       
        if !cartItems.isEmpty{
            let storyboard = UIStoryboard(name: "KioskModal", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MembershipViewController") as! MembershipViewController
            vc.kioskMainBoardDelegate = self
            vc.appear(sender: self)
        }
    }
    private func showCustomAlert(description : String) {
        let storyboard = UIStoryboard(name: "KioskModal", bundle: nil)
        let alertVC = storyboard.instantiateViewController(withIdentifier: String(describing: AlertViewController.self)) as! AlertViewController
       // alertVC.alertDelegate = self
        alertVC.showAlert(sender: self, text: "\(description) 5개 이내로 선택해주세요.")
    }
   
    func appear(sender: UIViewController) {
        self.modalPresentationStyle = .overFullScreen
        sender.present(self, animated: true)
    }
    
    // cell 선택시 동작 프로퍼티
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if cartItems.count < 5 {
            let product = list[indexPath.item]
            selectedProduct = Product(productName: product.name, productType: product.type, price: product.price, productImage: product.imageName)
            
            let storyboard = UIStoryboard(name: "KioskModal", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ProductOptionSelectViewController") as! ProductOptionSelectViewController
            vc.kioskMenuBoardDelegate = self
            vc.appear(sender: self)
        }
        else {
            showCustomAlert(description: "메뉴는")
        }
    }
   
    func itemLayout() -> UICollectionViewCompositionalLayout{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5)
                
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.3))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                let layout = UICollectionViewCompositionalLayout(section: section)
                return layout
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
        menuSelectionTableView.delegate = self
        menuSelectionTableView.dataSource = self
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light}

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
       }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuSelectionTableViewCell", for: indexPath) as! MenuSelectionTableViewCell
        let product = cartItems[indexPath.row]
        cell.configure(product)
        cell.delegate = self
        return cell
    }
    
    // KisokMainBoardDelegate 관련 프로퍼티
    
    func updateTotalPrice() {
        let totalPrice = totalPriceForPayment()
        let totalQuantity = cartItems.reduce(0) { $0 + $1.numberOfProduct }
           totalQuantityLabel.text = "\(totalQuantity) 개"
        let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.groupingSeparator = ","
            
            if let formattedTotalPrice = numberFormatter.string(from: NSNumber(value: totalPrice)) {
                totalPriceLabel.text =  "₩ " + formattedTotalPrice 
            }
        
    }
    
}

extension MenuSelectionViewController : KioskMainBoardDelegate {

    func moveToPaymentFinishVC()
    {
        let storyboard = UIStoryboard(name: "KioskModal", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PaymentFinishViewController") as! PaymentFinishViewController
        vc.kioskMainBoardDelegate = self
        vc.appear(sender: self)
        
    }
    func moveToPaymentVC(paymentType: PaymentType) {
        let storyboard = UIStoryboard(name: "KioskModal", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        vc.paymentType = paymentType
        vc.kioskMainBoardDelegate = self
        vc.appear(sender: self)
    }

    func didMembershipVCFinish() {
        moveToPaymentSelectVC()
    }

    func productForSelectingOption() -> Product {
        
        return selectedProduct!
    }
    func productForCart(product: Product) {
        cartItems.append(product)
        menuSelectionTableView.reloadData()
        updateTotalPrice()

    }
    
    func moveToPaymentSelectVC() {
        let storyboard = UIStoryboard(name: "KioskModal", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: PaymentSelectViewController.self)) as! PaymentSelectViewController
        vc.kioskMainBoardDelegate = self
        vc.appear(sender: self)
    }
    
    func totalPriceForPayment() -> Int {
        let totalPrice = cartItems.reduce(0) { $0 + $1.singleProductPrice * $1.numberOfProduct }
            return totalPrice
    }

    func backToMainScreen() {
        self.dismiss(animated: false) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
extension MenuSelectionViewController : MenuSelectionTableViewCellDelegate {
    func didIncreaseQuantity(cell: MenuSelectionTableViewCell) {
        guard let indexPath = menuSelectionTableView.indexPath(for: cell) else { return }
        var product = cartItems[indexPath.row]
       
        if product.numberOfProduct < 5 {
            product.numberOfProduct = product.numberOfProduct + 1
            cartItems[indexPath.row] = product
            cell.configure(product)
        }
        else {
            showCustomAlert(description: "수량은")
        }
//               product.numberOfProduct = min(product.numberOfProduct + 1, 5)  // 최대 5개
//               cartItems[indexPath.row] = product
//               cell.configure(product)  // 셀 업데이트
    }

    func didDecreaseQuantity(cell: MenuSelectionTableViewCell) {
        guard let indexPath = menuSelectionTableView.indexPath(for: cell) else { return }
                var product = cartItems[indexPath.row]
                product.numberOfProduct = max(product.numberOfProduct - 1, 1)  // 최소 0개
                cartItems[indexPath.row] = product
                cell.configure(product)  // 셀 업데이트
    }

    func didRemoveProduct(cell: MenuSelectionTableViewCell) {
        guard let indexPath = menuSelectionTableView.indexPath(for: cell) else { return }
                cartItems.remove(at: indexPath.row)
                menuSelectionTableView.deleteRows(at: [indexPath], with: .automatic)
            
    }

    
    
}
