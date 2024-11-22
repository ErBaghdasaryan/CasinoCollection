//
//  AddCollectioViewController.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 22.11.24.
//

import UIKit
import CasinoCollectionViewModel
import SnapKit

class AddCollectionViewController: BaseViewController {

    var viewModel: ViewModel?

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let grabber = UIImageView(image: UIImage(named: "grabber"))
    private let pageTitle = UILabel(text: "Add an entry",
                                    textColor: .white,
                                    font: UIFont(name: "SFProText-Semibold", size: 17))

    private let firstImage = AddPhotoView()
    private let firstAddImage = UIButton(type: .system)
    private var firstSelectedImage: UIImage?

    private let secondImage = AddPhotoView()
    private let secondAddImage = UIButton(type: .system)
    private var seconfSelectedImage: UIImage?

    private var firstHorizontalStack: UIStackView!

    private let thirdImage = AddPhotoView()
    private let thirdAddImage = UIButton(type: .system)
    private var thirdSelectedImage: UIImage?

    private let fourthImage = AddPhotoView()
    private let fourthAddImage = UIButton(type: .system)
    private var fourthSelectedImage: UIImage?

    private var secondHorizontalStack: UIStackView!

    private var verticalStack: UIStackView!
    private var currentButtonTag: Int?

    private let titleField = SystemTextField(labelText: "Title",
                                             placeholder: "Text")
    private let addressField = SystemTextField(labelText: "Address",
                                             placeholder: "Text")
    private let descriptionField = SystemTextView(labelText: "Description",
                                                  placeholder: "Text")
    private let nominalLabel = UILabel(text: "Nominal value",
                                       textColor: .white.withAlphaComponent(0.7),
                                       font: UIFont(name: "SFProText-Regular", size: 13))

    var collectionView: UICollectionView!
    private var selectedIndexPath: IndexPath?
    private var selectedText: String?

    private let priceField = SystemTextField(labelText: "Price",
                                                  placeholder: "Text")
    private let save = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#150218")

        self.firstHorizontalStack = UIStackView(arrangedSubviews: [firstImage, secondImage],
                                                axis: .horizontal,
                                                spacing: 8)
        self.secondHorizontalStack = UIStackView(arrangedSubviews: [thirdImage, fourthImage],
                                                axis: .horizontal,
                                                spacing: 8)
        self.verticalStack = UIStackView(arrangedSubviews: [firstHorizontalStack, secondHorizontalStack],
                                         axis: .vertical,
                                         spacing: 8)

        self.nominalLabel.textAlignment = .left

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

        self.save.backgroundColor = UIColor(hex: "#920A98")
        self.save.layer.masksToBounds = true
        self.save.layer.cornerRadius = 12
        self.save.setTitle("Save", for: .normal)
        self.save.setTitleColor(.white, for: .normal)

        updateButtonBackgroundColor()

        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(grabber)
        contentView.addSubview(pageTitle)
        contentView.addSubview(verticalStack)
        contentView.addSubview(firstAddImage)
        contentView.addSubview(secondAddImage)
        contentView.addSubview(thirdAddImage)
        contentView.addSubview(fourthAddImage)
        contentView.addSubview(titleField)
        contentView.addSubview(addressField)
        contentView.addSubview(descriptionField)
        contentView.addSubview(nominalLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(priceField)
        contentView.addSubview(save)
        setupConstraints()
        setupTextFieldDelegates()
        setupViewTapHandling()
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
        }

        contentView.snp.makeConstraints { view in
            view.edges.equalTo(scrollView)
            view.width.equalTo(scrollView)
            view.height.greaterThanOrEqualTo(scrollView.snp.height)
        }

        grabber.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(14)
            view.centerX.equalToSuperview()
            view.height.equalTo(5)
            view.width.equalTo(36)
        }

        pageTitle.snp.makeConstraints { view in
            view.top.equalTo(grabber.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(22)
        }

        verticalStack.snp.makeConstraints { view in
            view.top.equalTo(pageTitle.snp.bottom).offset(23)
            view.leading.equalToSuperview().offset(81)
            view.trailing.equalToSuperview().inset(81)
            view.height.equalTo(228)
        }

        firstAddImage.snp.makeConstraints { view in
            view.top.equalTo(verticalStack.snp.top)
            view.leading.equalTo(verticalStack.snp.leading)
            view.width.equalTo(110)
            view.height.equalTo(110)
        }

        secondAddImage.snp.makeConstraints { view in
            view.top.equalTo(verticalStack.snp.top)
            view.trailing.equalTo(verticalStack.snp.trailing)
            view.width.equalTo(110)
            view.height.equalTo(110)
        }

        thirdAddImage.snp.makeConstraints { view in
            view.bottom.equalTo(verticalStack.snp.bottom)
            view.leading.equalTo(verticalStack.snp.leading)
            view.width.equalTo(110)
            view.height.equalTo(110)
        }

        fourthAddImage.snp.makeConstraints { view in
            view.bottom.equalTo(verticalStack.snp.bottom)
            view.trailing.equalTo(verticalStack.snp.trailing)
            view.width.equalTo(110)
            view.height.equalTo(110)
        }

        titleField.snp.makeConstraints { view in
            view.top.equalTo(verticalStack.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(80)
        }

        addressField.snp.makeConstraints { view in
            view.top.equalTo(titleField.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(80)
        }

        nominalLabel.snp.makeConstraints { view in
            view.top.equalTo(addressField.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(18)
        }

        collectionView.snp.makeConstraints { view in
            view.top.equalTo(nominalLabel.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview()
            view.height.equalTo(44)
        }

        descriptionField.snp.makeConstraints { view in
            view.top.equalTo(collectionView.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(186)
        }

        priceField.snp.makeConstraints { view in
            view.top.equalTo(descriptionField.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(80)
        }

        save.snp.makeConstraints { view in
            view.top.equalTo(priceField.snp.bottom).offset(35)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview().inset(35)
            view.height.equalTo(50)
        }
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.loadData()
        self.collectionView.reloadData()
    }
}

//MARK: Make buttons actions
extension AddCollectionViewController{
    
    private func makeButtonsAction() {
        self.save.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        self.firstAddImage.tag = 1
        self.firstAddImage.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)
        self.secondAddImage.tag = 2
        self.secondAddImage.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)
        self.thirdAddImage.tag = 3
        self.thirdAddImage.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)
        self.fourthAddImage.tag = 4
        self.fourthAddImage.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)
    }

    @objc func saveTapped() {
        guard let firstImage = self.firstSelectedImage else { return }
        guard let secondImage = self.seconfSelectedImage else { return }
        guard let thirdImage = self.thirdSelectedImage else { return }
        guard let fourthImage = self.fourthSelectedImage else { return }
        guard let title = self.titleField.textField.text else { return }
        guard let address = self.addressField.textField.text else { return }
        guard let nominalValue = self.selectedText else { return }
        guard let description = self.descriptionField.textField.text else { return }
        guard let price = self.priceField.textField.text else { return }

        self.viewModel?.addCollection(model: .init(firstImage: firstImage,
                                                   secondImage: secondImage,
                                                   thirdImage: thirdImage,
                                                   fourthImage: fourthImage,
                                                   title: title,
                                                   address: address,
                                                   nominalValue: nominalValue,
                                                   description: description,
                                                   price: price))

        self.dismiss(animated: true)
    }

    @objc private func handleButtonTap(_ sender: UIButton) {
        currentButtonTag = sender.tag
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true)
    }
}

extension AddCollectionViewController: IViewModelableController {
    typealias ViewModel = IAddCollectionViewModel
}

//MARK: Image Picker
extension AddCollectionViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        switch currentButtonTag {
        case 1:
            firstImage.setup(with: image)
            firstSelectedImage = image
        case 2:
            secondImage.setup(with: image)
            seconfSelectedImage = image
        case 3:
            thirdImage.setup(with: image)
            thirdSelectedImage = image
        case 4:
            fourthImage.setup(with: image)
            fourthSelectedImage = image
        default:
            break
        }
    }
}

//MARK: UIGesture & cell's touches
extension AddCollectionViewController: UITextFieldDelegate, UITextViewDelegate {

    private func setupTextFieldDelegates() {
        self.titleField.textField.delegate = self
        self.addressField.textField.delegate = self
        self.descriptionField.textField.delegate = self
        self.priceField.textField.delegate = self

        priceField.textField.keyboardType = .numberPad
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.titleField.textField:
            textFieldDidEndEditing(textField)
            self.addressField.textField.becomeFirstResponder()
        case self.addressField.textField:
            textFieldDidEndEditing(textField)
            self.descriptionField.textField.becomeFirstResponder()
        case self.descriptionField.textField:
            textFieldDidEndEditing(textField)
            self.priceField.textField.becomeFirstResponder()
        case self.priceField.textField:
            textFieldDidEndEditing(textField)
            self.priceField.textField.resignFirstResponder()
        default:
            break
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateButtonBackgroundColor()
    }

    private func updateButtonBackgroundColor() {
        let allFieldsFilled = !checkAllFields()
        let buttonColor = allFieldsFilled ? UIColor(hex: "#920A98") : UIColor.white.withAlphaComponent(0.05)
        let titleColor = allFieldsFilled ? UIColor.white : UIColor.gray.withAlphaComponent(0.4)
        self.save.backgroundColor = buttonColor
        self.save.setTitleColor(titleColor, for: .normal)
        self.save.isUserInteractionEnabled = allFieldsFilled ? true : false
    }

    private func checkAllFields() -> Bool {
        guard let title = titleField.textField.text else { return true }
        guard let address = addressField.textField.text else { return true }
        guard let description = descriptionField.textField.text else { return true }
        guard let price = priceField.textField.text else { return true }

        return title.isEmpty || address.isEmpty || description.isEmpty || price.isEmpty
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

extension AddCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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

        selectedText = self.viewModel?.values[indexPath.row]
    }
}


//MARK: Preview
import SwiftUI

struct AddCollectioViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let addCollectioViewController = AddCollectionViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<AddCollectioViewControllerProvider.ContainerView>) -> AddCollectionViewController {
            return addCollectioViewController
        }

        func updateUIViewController(_ uiViewController: AddCollectioViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AddCollectioViewControllerProvider.ContainerView>) {
        }
    }
}
