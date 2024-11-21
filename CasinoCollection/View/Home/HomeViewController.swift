//
//  HomeViewController.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import UIKit
import CasinoCollectionViewModel
import SnapKit

class HomeViewController: BaseViewController, UICollectionViewDelegate {

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

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
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

        self.view.addSubview(backGroundImage)
        self.view.addSubview(statStack)
        self.view.addSubview(buttonsStack)
        self.view.addSubview(collectionLabel)
        self.view.addSubview(seeAll)
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
    }

    override func setupViewModel() {
        super.setupViewModel()
    }
}

//MARK: Make buttons actions
extension HomeViewController {
    
    private func makeButtonsAction() {
        
    }
}

extension HomeViewController: IViewModelableController {
    typealias ViewModel = IHomeViewModel
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
