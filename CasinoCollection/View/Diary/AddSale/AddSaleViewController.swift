//
//  AddSaleViewController.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 23.11.24.
//

import UIKit
import CasinoCollectionViewModel
import CasinoCollectionModel
import SnapKit

class AddSaleViewController: BaseViewController {

    var viewModel: ViewModel?

    private let grabber = UIImageView(image: UIImage(named: "grabber"))
    private let pageTitle = UILabel(text: "Add an entry",
                                    textColor: .white,
                                    font: UIFont(name: "SFProText-Semibold", size: 17))
    private let priceField = SystemTextField(labelText: "Price",
                                             placeholder: "$0")
    private let salesLabel = UILabel(text: "Sales",
                                     textColor: .white,
                                     font: UIFont(name: "SFProText-Bold", size: 28))
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let save = UIButton(type: .system)

    private var selectedCollection: CollectionModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
        setupTableView()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#150218")

        self.save.backgroundColor = UIColor(hex: "#920A98")
        self.save.layer.masksToBounds = true
        self.save.layer.cornerRadius = 12
        self.save.setTitle("Save", for: .normal)
        self.save.setTitleColor(.white, for: .normal)

        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = true

        self.salesLabel.textAlignment = .left

        self.view.addSubview(grabber)
        self.view.addSubview(pageTitle)
        self.view.addSubview(priceField)
        self.view.addSubview(salesLabel)
        self.view.addSubview(tableView)
        self.view.addSubview(save)
        setupConstraints()
        setupViewTapHandling()
        setupTextFieldDelegates()
    }

    private func setupConstraints() {

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

        priceField.snp.makeConstraints { view in
            view.top.equalTo(pageTitle.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(80)
        }

        salesLabel.snp.makeConstraints { view in
            view.top.equalTo(priceField.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(60)
            view.height.equalTo(34)
        }

        tableView.snp.makeConstraints { view in
            view.top.equalTo(salesLabel.snp.bottom)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview().inset(107)
        }

        save.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(50)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(50)
        }
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.loadSales()
        self.tableView.reloadData()
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false

        self.tableView.register(EmptySaleTableViewCell.self)
        self.tableView.register(AddSaleTableViewCell.self)
    }
}

//MARK: Make buttons actions
extension AddSaleViewController{
    
    private func makeButtonsAction() {
        self.save.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }

    @objc func saveTapped() {
        guard let price = self.priceField.textField.text else { return }
        guard let model = self.selectedCollection else { return }

        self.viewModel?.addSale(model: .init(firstImage: model.firstImage,
                                             title: model.title,
                                             nominalValue: model.nominalValue,
                                             salePrice: price,
                                             price: model.price))

        self.dismiss(animated: true)
    }
}

extension AddSaleViewController: IViewModelableController {
    typealias ViewModel = IAddSaleViewModel
}

//MARK: UIGesture & cell's touches
extension AddSaleViewController: UITextFieldDelegate, UITextViewDelegate {

    private func setupTextFieldDelegates() {
        self.priceField.textField.delegate = self

        self.priceField.textField.keyboardType = .numberPad
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.priceField.textField:
            self.priceField.textField.resignFirstResponder()
        default:
            break
        }
        return true
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


//MARK: TableView Delegate & Data source
extension AddSaleViewController:  UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel?.collections.count ?? 0
        return count == 0 ? 1 : count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.viewModel?.collections.isEmpty ?? true {
            let cell: EmptySaleTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setupUI()
            return cell
        } else {
            let cell: AddSaleTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            if let collection = viewModel?.collections[indexPath.row] {
                cell.setup(with: .init(firstImage: collection.firstImage,
                                       title: collection.title,
                                       nominalValue: collection.nominalValue,
                                       salePrice: "",
                                       price: collection.price))
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.viewModel?.collections.isEmpty ?? true {
            return 87
        } else {
            return 87
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let count = self.viewModel?.collections.count ?? 0
        if count > 0, let selectedCollection = self.viewModel?.collections[indexPath.row] {
            self.selectedCollection = selectedCollection
            if let cell = tableView.cellForRow(at: indexPath) as? AddSaleTableViewCell {
                cell.setSelectedState(true)
            }
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AddSaleTableViewCell {
            cell.setSelectedState(false)
        }
    }
}

//MARK: Preview
import SwiftUI

struct AddSaleViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let addSaleViewController = AddSaleViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<AddSaleViewControllerProvider.ContainerView>) -> AddSaleViewController {
            return addSaleViewController
        }

        func updateUIViewController(_ uiViewController: AddSaleViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AddSaleViewControllerProvider.ContainerView>) {
        }
    }
}
