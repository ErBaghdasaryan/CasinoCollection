//
//  EditNoteViewController.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import UIKit
import CasinoCollectionViewModel
import SnapKit

class EditNoteViewController: BaseViewController {

    var viewModel: ViewModel?

    private let headerField = HeaderField(placeholder: "Title",
                                          sfPro: "Bold",
                                          size: 34,
                                          isCentered: false)
    private let noteField = TextView(placeholder: "Note")
    private let delete = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let model = self.viewModel?.note else { return }

        self.noteField.text = model.text
        self.headerField.text = model.title
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#150218")

        self.delete.setTitle("Delete", for: .normal)
        self.delete.setTitleColor(.white, for: .normal)
        self.delete.backgroundColor = .white.withAlphaComponent(0.05)
        self.delete.layer.masksToBounds = true
        self.delete.layer.cornerRadius = 12

        self.view.addSubview(headerField)
        self.view.addSubview(noteField)
        self.view.addSubview(delete)
        setupConstraints()
        setupNavigationItems()
        setupTextFieldDelegates()
        setupViewTapHandling()
    }

    private func setupConstraints() {

        headerField.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(119)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(52)
        }

        noteField.snp.makeConstraints { view in
            view.top.equalTo(headerField.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }

        delete.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(37)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(50)
        }
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

}

//MARK: Make buttons actions
extension EditNoteViewController {
    
    private func makeButtonsAction() {
        delete.addTarget(self, action: #selector(deleteNote), for: .touchUpInside)
    }

    @objc func deleteNote() {
        guard let navigationController = self.navigationController else { return }
        guard let header = self.headerField.text else { return }
        guard let text = self.noteField.text else { return }
        guard let id = self.viewModel?.note.id else { return }

        self.viewModel?.deleteNote(by: id)

        DiaryRouter.popViewController(in: navigationController)
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
        DiaryRouter.popViewController(in: navigationController)
    }
}

extension EditNoteViewController: IViewModelableController {
    typealias ViewModel = IEditNoteViewModel
}

//MARK: UIGesture & cell's touches
extension EditNoteViewController: UITextFieldDelegate, UITextViewDelegate {

    private func setupTextFieldDelegates() {
        self.headerField.delegate = self
        self.noteField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.headerField:
            textFieldDidEndEditing(textField)
            self.noteField.becomeFirstResponder()
        case self.noteField:
            textFieldDidEndEditing(textField)
            self.noteField.resignFirstResponder()
        default:
            break
        }
        return true
    }

    public func textViewDidChange(_ textView: UITextView) {
        noteField.placeholderLabel.isHidden = !noteField.text.isEmpty
        updateButtonBackgroundColor()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateButtonBackgroundColor()
    }

    private func updateButtonBackgroundColor() {
        let allFieldsFilled = !checkAllFields()
        self.delete.isUserInteractionEnabled = allFieldsFilled ? true : false
    }

    private func checkAllFields() -> Bool {
        guard let header = self.headerField.text else { return true }
        guard let text = self.noteField.text else { return true }

        return header.isEmpty || text.isEmpty
    }

    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }

    private func setupViewTapHandling() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
}

//MARK: Preview
import SwiftUI

struct EditNoteViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let editNoteViewController = EditNoteViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<EditNoteViewControllerProvider.ContainerView>) -> EditNoteViewController {
            return editNoteViewController
        }

        func updateUIViewController(_ uiViewController: EditNoteViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<EditNoteViewControllerProvider.ContainerView>) {
        }
    }
}
