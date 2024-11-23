//
//  NoteViewController.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import UIKit
import CasinoCollectionViewModel
import SnapKit

class NoteViewController: BaseViewController {

    var viewModel: ViewModel?
    private let backGroundImage = UIImageView(image: .init(named: "bgImage"))

    private let header = UILabel(text: "Notes",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 34))

    var collectionView: UICollectionView!
    private var selectedIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.header.textAlignment = .left

        let myLayout = UICollectionViewFlowLayout()
        myLayout.scrollDirection = .vertical
//        myLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        myLayout.minimumLineSpacing = 10
        myLayout.minimumInteritemSpacing = 10

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: myLayout)

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor =  .clear

        collectionView.register(NoteCollectionViewCell.self)
        collectionView.register(EmptyCollectionViewCell.self)

        collectionView.delegate = self
        collectionView.dataSource = self

        self.view.addSubview(backGroundImage)
        self.view.addSubview(header)
        self.view.addSubview(collectionView)
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
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.loadNotes()
        self.collectionView.reloadData()

        viewModel?.activateSuccessSubject.sink { [weak self] _ in
            guard let self = self else { return }
            self.viewModel?.loadNotes()
            self.collectionView.reloadData()
        }.store(in: &cancellables)
    }

}

//MARK: Make buttons actions
extension NoteViewController {
    
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
        DiaryRouter.popViewController(in: navigationController)
    }

    @objc private func didTapNewItemButton() {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }
        NoteRouter.showAddNotesViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subject))
    }

    private func editNote(for index: Int) {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        let model = self.viewModel?.notes[index]

        NoteRouter.showEditNotesViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subject, model: model!))
    }

    private func addNote() {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        NoteRouter.showAddNotesViewController(in: navigationController, navigationModel: .init(activateSuccessSubject: subject))
    }
}

extension NoteViewController: IViewModelableController {
    typealias ViewModel = INoteViewModel
}

extension NoteViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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

//MARK: Preview
import SwiftUI

struct NoteViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let noteViewController = NoteViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<NoteViewControllerProvider.ContainerView>) -> NoteViewController {
            return noteViewController
        }

        func updateUIViewController(_ uiViewController: NoteViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<NoteViewControllerProvider.ContainerView>) {
        }
    }
}
