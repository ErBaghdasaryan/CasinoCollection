//
//  CollectionViewController.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 22.11.24.
//

import UIKit
import CasinoCollectionViewModel
import SnapKit

class CollectionViewController: BaseViewController {

    var viewModel: ViewModel?
    private let backGroundImage = UIImageView(image: .init(named: "bgImage"))

    private let header = UILabel(text: "Collection",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 34))

    var collectionView: UICollectionView!
    private var selectedIndexPath: IndexPath?

    private let tableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
        setupTableView()
    }

    override func setupUI() {
        super.setupUI()

        self.header.textAlignment = .left

        let myLayout = UICollectionViewFlowLayout()
        myLayout.scrollDirection = .horizontal
        myLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        myLayout.minimumLineSpacing = 10
        myLayout.minimumInteritemSpacing = 10

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: myLayout)

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor =  .clear

        collectionView.register(ValueCollectionViewCell.self)

        collectionView.delegate = self
        collectionView.dataSource = self

        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = true

        self.view.addSubview(backGroundImage)
        self.view.addSubview(header)
        self.view.addSubview(collectionView)
        self.view.addSubview(tableView)
        setupConstraints()
        setupNavigationItems()
    }

    private func setupConstraints() {
        backGroundImage.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
        }

        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(101)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(60)
            view.height.equalTo(41)
        }

        collectionView.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview()
            view.height.equalTo(44)
        }

        tableView.snp.makeConstraints { view in
            view.top.equalTo(collectionView.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.loadData()
        self.collectionView.reloadData()
        self.viewModel?.loadCollections()
        self.tableView.reloadData()
        setupDefaultSelection()

        viewModel?.activateSuccessSubject.sink { [weak self] _ in
            guard let self = self else { return }
            self.viewModel?.loadCollections()
            self.tableView.reloadData()
        }.store(in: &cancellables)
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false

        self.tableView.register(EmptyCell.self)
        self.tableView.register(AddCollectionTableViewCell.self)
    }
}

//MARK: Make buttons actions
extension CollectionViewController {
    
    private func makeButtonsAction() {
    
    }

    private func setupNavigationItems() {
        let customBackButton = UIBarButtonItem(image: UIImage(named: "customBack"),
                                               style: .plain,
                                               target: self,
                                               action: #selector(didTapCustomBackButton))
        navigationItem.leftBarButtonItem = customBackButton

        let addButton = UIButton(type: .system)
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        addButton.layer.cornerRadius = 17
        addButton.layer.masksToBounds = true
        addButton.frame = CGRect(x: 0, y: 0, width: 58, height: 34)
        addButton.addTarget(self, action: #selector(didTapNewItemButton), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: addButton)
        navigationItem.rightBarButtonItem = barButton
    }

    @objc private func didTapCustomBackButton() {
        guard let navigationController = self.navigationController else { return }
        HomeRouter.popViewController(in: navigationController)
    }

    @objc private func didTapNewItemButton() {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        CollectionRouter.showAddCollectionViewController(in: navigationController,
                                                         navigationModel: .init(activateSuccessSubject: subject))
    }

    private func setupDefaultSelection() {
        guard let count = self.viewModel?.values.count, count > 0 else { return }
        let defaultIndexPath = IndexPath(item: 0, section: 0)
        selectedIndexPath = defaultIndexPath

        collectionView.selectItem(at: defaultIndexPath, animated: false, scrollPosition: [])
        if let cell = collectionView.cellForItem(at: defaultIndexPath) as? ValueCollectionViewCell {
            cell.setSelectedState(isSelected: true)
        }
    }

    private func editCollection(for index: Int) {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        let model = self.viewModel?.collections[index]

        CollectionRouter.showEditCollectionViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subject, model: model!))
    }

    private func addCollection() {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        CollectionRouter.showAddCollectionViewController(in: navigationController,
                                                         navigationModel: .init(activateSuccessSubject: subject))
    }
}

extension CollectionViewController: IViewModelableController {
    typealias ViewModel = ICollectionViewModel
}

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.viewModel?.values.count ?? 0
        return count == 0 ? 1 : count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ValueCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        if let value = self.viewModel?.values[indexPath.row] {
            cell.setup(title: value)
        }

        let isSelected = indexPath == selectedIndexPath
        cell.setSelectedState(isSelected: isSelected)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 1000, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let previousIndexPath = selectedIndexPath, let previousCell = collectionView.cellForItem(at: previousIndexPath) as? ValueCollectionViewCell {
            previousCell.setSelectedState(isSelected: false)
        }

        if let currentCell = collectionView.cellForItem(at: indexPath) as? ValueCollectionViewCell {
            currentCell.setSelectedState(isSelected: true)
        }

        selectedIndexPath = indexPath

        if let value = self.viewModel?.values[indexPath.row] {
            self.viewModel?.filterCollection(with: value)
            self.tableView.reloadData()
        }
    }
}

//MARK: TableView Delegate & Data source
extension CollectionViewController:  UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel?.filteredCollections.count ?? 0
        return count == 0 ? 1 : count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.viewModel?.filteredCollections.isEmpty ?? true {
            let cell: EmptyCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setupUI()

            cell.addSubject.sink { [weak self] _ in
                self?.addCollection()
            }.store(in: &cell.cancellables)

            return cell
        } else {
            let cell: AddCollectionTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            if let model = viewModel?.filteredCollections[indexPath.row] {
                cell.setup(with: model)
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.viewModel?.filteredCollections.isEmpty ?? true {
            return 218
        } else {
            return 158
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editCollection(for: indexPath.row)
    }
}


//MARK: Preview
import SwiftUI

struct CollectionViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let collectionViewController = CollectionViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<CollectionViewControllerProvider.ContainerView>) -> CollectionViewController {
            return collectionViewController
        }

        func updateUIViewController(_ uiViewController: CollectionViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<CollectionViewControllerProvider.ContainerView>) {
        }
    }
}
