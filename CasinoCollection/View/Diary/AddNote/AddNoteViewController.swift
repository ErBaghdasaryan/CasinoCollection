//
//  AddNoteViewController.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import UIKit
import CasinoCollectionViewModel
import SnapKit

class AddNoteViewController: BaseViewController {

    var viewModel: ViewModel?

    private let headerField = HeaderField(placeholder: "Title",
                                          sfPro: "Bold",
                                          size: 34,
                                          isCentered: false)
    private let noteField = TextView(placeholder: "Note")
    private let add = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#150218")

        self.add.setTitle("Add", for: .normal)
        self.add.setTitleColor(.white, for: .normal)
        self.add.backgroundColor = .white.withAlphaComponent(0.05)
        self.add.layer.masksToBounds = true
        self.add.layer.cornerRadius = 12

        self.view.addSubview(headerField)
        self.view.addSubview(noteField)
        self.view.addSubview(add)
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

        add.snp.makeConstraints { view in
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
extension AddNoteViewController {
    
    private func makeButtonsAction() {
        add.addTarget(self, action: #selector(createNote), for: .touchUpInside)
    }

    @objc func createNote() {
        guard let navigationController = self.navigationController else { return }
        guard let header = self.headerField.text else { return }
        guard let text = self.noteField.text else { return }

        self.viewModel?.addNote(model: .init(title: header, text: text))

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

extension AddNoteViewController: IViewModelableController {
    typealias ViewModel = IAddNoteViewModel
}

//MARK: UIGesture & cell's touches
extension AddNoteViewController: UITextFieldDelegate, UITextViewDelegate {

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
        self.add.isUserInteractionEnabled = allFieldsFilled ? true : false
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

struct AddNoteViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let addNoteViewController = AddNoteViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<AddNoteViewControllerProvider.ContainerView>) -> AddNoteViewController {
            return addNoteViewController
        }

        func updateUIViewController(_ uiViewController: AddNoteViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AddNoteViewControllerProvider.ContainerView>) {
        }
    }
}
