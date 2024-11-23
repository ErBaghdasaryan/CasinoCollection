//
//  DiaryViewController.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import UIKit
import CasinoCollectionViewModel
import SnapKit

class DiaryViewController: BaseViewController {

    var viewModel: ViewModel?
    private let backGroundImage = UIImageView(image: .init(named: "bgImage"))

    private let header = UILabel(text: "Diary",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 34))
    private let notesCollectionLabel = UILabel(text: "Notes",
                                               textColor: .white,
                                               font: UIFont(name: "SFProText-Bold", size: 28))
    private let seeAll = UIButton(type: .system)

    var notesCollectionView: UICollectionView!
    private var selectedIndexPath: IndexPath?

    private let salesLabel = UILabel(text: "Sales",
                                     textColor: .white,
                                     font: UIFont(name: "SFProText-Bold", size: 28))
    private let addSale = UIButton(type: .system)
    private let tableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.loadNotes()
        self.notesCollectionView.reloadData()

        self.viewModel?.loadSales()
        self.tableView.reloadData()
    }

    override func setupUI() {
        super.setupUI()

        self.header.textAlignment = .left

        self.notesCollectionLabel.textAlignment = .left
        self.seeAll.setTitle("See All", for: .normal)
        self.seeAll.setTitleColor(UIColor(hex: "#920A98"), for: .normal)

        self.salesLabel.textAlignment = .left
        self.addSale.setTitle("Add", for: .normal)
        self.addSale.setTitleColor(.white, for: .normal)
        self.addSale.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        self.addSale.layer.cornerRadius = 17
        self.addSale.layer.masksToBounds = true

        let myLayout = UICollectionViewFlowLayout()
        myLayout.scrollDirection = .horizontal
        myLayout.minimumLineSpacing = 10
        myLayout.minimumInteritemSpacing = 10

        notesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: myLayout)

        notesCollectionView.showsHorizontalScrollIndicator = false
        notesCollectionView.backgroundColor =  .clear

        notesCollectionView.register(NoteCollectionViewCell.self)
        notesCollectionView.register(EmptyCollectionViewCell.self)

        notesCollectionView.delegate = self
        notesCollectionView.dataSource = self

        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = true

        self.view.addSubview(backGroundImage)
        self.view.addSubview(header)
        self.view.addSubview(notesCollectionLabel)
        self.view.addSubview(seeAll)
        self.view.addSubview(notesCollectionView)
        self.view.addSubview(salesLabel)
        self.view.addSubview(addSale)
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

        notesCollectionLabel.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(20)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(60)
            view.height.equalTo(34)
        }

        seeAll.snp.makeConstraints { view in
            view.centerY.equalTo(notesCollectionLabel.snp.centerY)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(20)
            view.width.equalTo(50)
        }

        notesCollectionView.snp.makeConstraints { view in
            view.top.equalTo(notesCollectionLabel.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview()
            view.height.equalTo(218)
        }

        salesLabel.snp.makeConstraints { view in
            view.top.equalTo(notesCollectionView.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(60)
            view.height.equalTo(34)
        }

        addSale.snp.makeConstraints { view in
            view.centerY.equalTo(salesLabel.snp.centerY)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
            view.width.equalTo(56)
        }

        tableView.snp.makeConstraints { view in
            view.top.equalTo(salesLabel.snp.bottom)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }

    }

    override func setupViewModel() {
        super.setupViewModel()
        viewModel?.activateSuccessSubject.sink { [weak self] _ in
            guard let self = self else { return }
            self.viewModel?.loadNotes()
            self.notesCollectionView.reloadData()
            self.viewModel?.loadSales()
            self.tableView.reloadData()
        }.store(in: &cancellables)
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false

        self.tableView.register(EmptyCell.self)
        self.tableView.register(SaleTableViewCell.self)
    }
}

//MARK: Make buttons actions
extension DiaryViewController {
    
    private func makeButtonsAction() {
        self.seeAll.addTarget(self, action: #selector(openNotes), for: .touchUpInside)
        self.addSale.addTarget(self, action: #selector(addingSale), for: .touchUpInside)
    }

    @objc func addingSale() {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        DiaryRouter.showAddSaleViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subject))
    }

    @objc func openNotes() {
        guard let navigationController = self.navigationController else { return }
        DiaryRouter.showNotesViewController(in: navigationController)
    }

    private func setupNavigationItems() {
        let customBackButton = UIBarButtonItem(image: UIImage(named: "customBack"),
                                               style: .plain,
                                               target: self,
                                               action: #selector(didTapCustomBackButton))
        navigationItem.leftBarButtonItem = customBackButton
    }

    @objc private func didTapCustomBackButton() {
        guard let navigationController = self.navigationController else { return }
        HomeRouter.popViewController(in: navigationController)
    }

    private func editNote(for index: Int) {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        let model = self.viewModel?.notes[index]

        DiaryRouter.showEditNotesViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subject, model: model!))
    }

    private func addNote() {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        DiaryRouter.showAddNotesViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subject))
    }
}

extension DiaryViewController: IViewModelableController {
    typealias ViewModel = IDiaryViewModel
}

extension DiaryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = viewModel?.notes.count ?? 0
        return count == 0 ? 1 : count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.viewModel?.notes.isEmpty ?? true {
            let cell: EmptyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setupUI()

            cell.addSubject.sink { [weak self] _ in
                self?.addNote()
            }.store(in: &cell.cancellables)

            return cell
        } else {
            let cell: NoteCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            if let note = self.viewModel?.notes[indexPath.row] {
                cell.setup(title: note.title, text: note.text)
            }

            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.viewModel?.notes.isEmpty ?? true {
            return CGSize(width: 358, height: 218)
        } else {
            return CGSize(width: 358, height: 166)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.editNote(for: indexPath.row)
    }
}

//MARK: TableView Delegate & Data source
extension DiaryViewController:  UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel?.sales.count ?? 0
        return count == 0 ? 1 : count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.viewModel?.sales.isEmpty ?? true {
            let cell: EmptyCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setupUI()

            cell.addSubject.sink { [weak self] _ in
                self?.addingSale()
            }.store(in: &cell.cancellables)

            return cell
        } else {
            let cell: SaleTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            if let model = viewModel?.sales[indexPath.row] {
                cell.setup(with: model)
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.viewModel?.sales.isEmpty ?? true {
            return 218
        } else {
            return 87
        }
    }
}

//MARK: Preview
import SwiftUI

struct DiaryViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let diaryViewController = DiaryViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<DiaryViewControllerProvider.ContainerView>) -> DiaryViewController {
            return diaryViewController
        }

        func updateUIViewController(_ uiViewController: DiaryViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<DiaryViewControllerProvider.ContainerView>) {
        }
    }
}
