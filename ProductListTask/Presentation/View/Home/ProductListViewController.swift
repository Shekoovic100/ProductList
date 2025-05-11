//
//  ViewController.swift
//  ProductListTask
//
//  Created by sherif on 10/05/2025.
//

import UIKit
import SkeletonView

class ProductListViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var changeViewButton: UIBarButtonItem!
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    //MARK: proprities
    
    private let viewModel: ProductListViewModel
    
    init(viewModel: ProductListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        let networkService = NetworkService()
        let remoteDataSource = RemoteProductDataSource(networkService: networkService)
        let repository = ProductRepository(remoteDataSource: remoteDataSource)
        let useCase = FetchProductsUseCase(repository: repository)
        self.viewModel = ProductListViewModel(fetchProductsUseCase: useCase)
        super.init(coder: coder)
    }
    
    

    //MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchProductsList()
        bindViewModel()
        registerCell()
        //setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupSkeleton()
    }

    
    //MARK: IB Actions
    
    @IBAction func ChangeViewPressed(_ sender: UIBarButtonItem) {
        viewModel.toggleViewMode()
        self.productsCollectionView.reloadData()
    }
    
    //MARK: - Helper functions
    
    

    
    
    func setupSkeleton(){
        productsCollectionView.isSkeletonable = true
        productsCollectionView.showSkeleton(usingColor: .concrete, transition: .crossDissolve(0.25))
    }
    
    
    func registerCell() {
        productsCollectionView.register(UINib(nibName: ProductCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProductCell.identifier)
    }
    
    private func bindViewModel() {
        
        viewModel.onProductsUpdated = { [weak self] in
            self?.productsCollectionView.stopSkeletonAnimation()
            self?.view.hideSkeleton()
            self?.productsCollectionView.reloadData()
        }
        
        viewModel.onError = { [weak self] error in
            self?.showError(error)
        }
        
        viewModel.onLoadingStateChanged = { [weak self] isLoading in
            isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
        }
    }
    
    
    private func showError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}

//MARK: CollectionView data And delegate methods

extension ProductListViewController: SkeletonCollectionViewDataSource, UICollectionViewDelegate  {
    
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return ProductCell.identifier
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfProducts
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        let productData = viewModel.product(at: indexPath.row)
        cell.configureCell(with: productData, isGrid: viewModel.isGridView)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productData = viewModel.product(at: indexPath.item)
        guard let productDetailsVC = storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController else { return }
        productDetailsVC.product = productData
        navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
}

//MARK: CollectionView Flowlayout methods

extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = viewModel.isGridView ? (view.frame.width - 24) / 2 : view.frame.width - 16
        return CGSize(width: width, height: viewModel.isGridView ? 200 : 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height
        if offsetY > contentHeight - frameHeight - 50  {
            viewModel.fetchProductsList()
        }
    }
}
