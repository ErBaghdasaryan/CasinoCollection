//
//  HomeViewController.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import UIKit
import CasinoCollectionViewModel
import SnapKit

class HomeViewController: BaseViewController {

    var viewModel: ViewModel?
    private let backGroundImage = UIImageView(image: .init(named: "bgImage"))

    private let chipsCount = StatView(title: "chips in the collection")
    private let costsCount = StatView(title: "the cost of the collection",
                                      isMoney: true)
    private var statStack: UIStackView!

    private let diary = UIButton(type: .system)
    private let settings = UIButton(type: .system)
    private var buttonsStack: UIStackView!

    private let collectionLabel = UILabel(text: "Collection",
                                          textColor: .white,
                                          font: UIFont(name: "SFProText-Bold", size: 28))
    private let seeAll = UIButton(type: .system)

    var collectionView: UICollectionView!
    private var selectedIndexPath: IndexPath?

    private let tableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadInformation()
    }

    override func setupUI() {
        super.setupUI()

        self.statStack = UIStackView(arrangedSubviews: [chipsCount, costsCount],
                                     axis: .horizontal,
                                     spacing: 4)
        self.statStack.distribution = .fillProportionally

        self.diary.layer.masksToBounds = true
        self.diary.layer.cornerRadius = 12
        self.diary.backgroundColor = UIColor(hex: "#582862")
        self.diary.setImage(.init(named: "diaryButton"), for: .normal)

        self.settings.layer.masksToBounds = true
        self.settings.layer.cornerRadius = 12
        self.settings.backgroundColor = UIColor(hex: "#582862")
        self.settings.setImage(.init(named: "settingsButton"), for: .normal)

        self.buttonsStack = UIStackView(arrangedSubviews: [diary, settings],
                                        axis: .horizontal,
                                        spacing: 4)

        self.seeAll.setTitle("See All", for: .normal)
        self.seeAll.setTitleColor(UIColor(hex: "#920A98"), for: .normal)

        self.collectionLabel.textAlignment = .left

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
        self.view.addSubview(statStack)
        self.view.addSubview(buttonsStack)
        self.view.addSubview(collectionLabel)
        self.view.addSubview(seeAll)
        self.view.addSubview(collectionView)
        self.view.addSubview(tableView)
        setupConstraints()
    }

    private func setupConstraints() {
        backGroundImage.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
        }

        statStack.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(66)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(110)
        }

        buttonsStack.snp.makeConstraints { view in
            view.top.equalTo(statStack.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(48)
        }

        collectionLabel.snp.makeConstraints { view in
            view.top.equalTo(buttonsStack.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(60)
            view.height.equalTo(34)
        }

        seeAll.snp.makeConstraints { view in
            view.centerY.equalTo(collectionLabel.snp.centerY)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(20)
            view.width.equalTo(50)
        }

        collectionView.snp.makeConstraints { view in
            view.top.equalTo(collectionLabel.snp.bottom).offset(8)
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
        reloadInformation()
        self.viewModel?.loadData()
        self.collectionView.reloadData()
        setupDefaultSelection()

        viewModel?.activateSuccessSubject.sink { [weak self] _ in
            guard let self = self else { return }
            self.reloadInformation()
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
extension HomeViewController {
    
    private func makeButtonsAction() {
        seeAll.addTarget(self, action: #selector(seeAllCollections), for: .touchUpInside)
        settings.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        diary.addTarget(self, action: #selector(openDairy), for: .touchUpInside)
    }

    @objc func openDairy() {
        guard let navigationController = self.navigationController else { return }

        HomeRouter.showDiaryViewController(in: navigationController)
    }

    private func reloadInformation() {
        guard let model = self.viewModel?.collections else { return }
        self.viewModel?.loadCollections()
        self.tableView.reloadData()
        self.chipsCount.setup(with: "\(model.count)")
        let totalPrice: Double = model.reduce(0) { sum, model in
            if let priceValue = Double(model.price) {
                return sum + priceValue
            } else {
                return sum
            }
        }
        self.costsCount.setup(with: "\(Int(totalPrice))")
    }

    @objc func settingsTapped() {
        guard let navigationController = self.navigationController else { return }

        HomeRouter.showSettingsViewController(in: navigationController)
    }

    @objc func seeAllCollections() {
        guard let navigationController = self.navigationController else { return }

        HomeRouter.showCollectionViewController(in: navigationController)
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

        HomeRouter.showEditCollectionViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subject, model: model!))
    }

    private func addCollection() {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        HomeRouter.showAddCollectionViewController(in: navigationController,
                                                         navigationModel: .init(activateSuccessSubject: subject))
    }
}

extension HomeViewController: IViewModelableController {
    typealias ViewModel = IHomeViewModel
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
extension HomeViewController:  UITableViewDelegate, UITableViewDataSource {

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
        self.editCollection(for: indexPath.row)
    }
}


//MARK: Preview
import SwiftUI

struct HomeViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let homeViewController = HomeViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<HomeViewControllerProvider.ContainerView>) -> HomeViewController {
            return homeViewController
        }

        func updateUIViewController(_ uiViewController: HomeViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<HomeViewControllerProvider.ContainerView>) {
        }
    }
}
