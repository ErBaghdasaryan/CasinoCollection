//
//  OnboardingViewController.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 21.11.24.
//

import UIKit
import CasinoCollectionViewModel
import SnapKit

class OnboardingViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    var collectionView: UICollectionView!
    private let bottomView = UIView()
    private let descriptionLabel = UILabel(text: "",
                                           textColor: .white,
                                           font: UIFont(name: "SFProText-Bold", size: 34))
    private let continueButton = UIButton(type: .system)
    private var currentIndex: Int = 0
    private let pageControl = AdvancedPageControlView()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        setGradientBackground()

        self.bottomView.backgroundColor = UIColor(hex: "#150218")

        descriptionLabel.numberOfLines = 2
        descriptionLabel.lineBreakMode = .byWordWrapping

        self.continueButton.setTitle("Next", for: .normal)
        self.continueButton.setTitleColor(.white, for: .normal)
        self.continueButton.backgroundColor = UIColor(hex: "#920A98")
        self.continueButton.layer.masksToBounds = true
        self.continueButton.layer.cornerRadius = 10

        let mylayout = UICollectionViewFlowLayout()
        mylayout.itemSize = sizeForItem()
        mylayout.scrollDirection = .horizontal
        mylayout.minimumLineSpacing = 0
        mylayout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: mylayout)
        setupConstraints()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear

        collectionView.register(OnboardingCell.self)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false

        pageControl.drawer = ExtendedDotDrawer(numberOfPages: 2,
                                               height: 10,
                                               width: 10,
                                               space: 8,
                                               indicatorColor: UIColor(hex: "#920A98"),
                                               dotsColor: UIColor.white.withAlphaComponent(0.2),
                                               isBordered: true,
                                               borderWidth: 0.0,
                                               indicatorBorderColor: .orange,
                                               indicatorBorderWidth: 0.0)
        pageControl.setPage(0)
    }

    override func setupViewModel() {
        super.setupViewModel()
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel?.loadData()
    }

    func sizeForItem() -> CGSize {
        let deviceType = UIDevice.currentDeviceType

        switch deviceType {
        case .iPhone:
            let width = self.view.frame.size.width - 72
            let heightt = self.view.frame.size.height - 168
            return CGSize(width: width, height: heightt)
        case .iPad:
            let scaleFactor: CGFloat = 1.5
            let width = 550 * scaleFactor
            let height = 1100 * scaleFactor
            return CGSize(width: width, height: height)
        }
    }

    func setupConstraints() {
        self.view.addSubview(collectionView)
        self.view.addSubview(bottomView)
        self.view.addSubview(pageControl)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(continueButton)

        bottomView.snp.makeConstraints { view in
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(256)
        }

        collectionView.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(92)
            view.leading.equalToSuperview().offset(36)
            view.trailing.equalToSuperview().inset(36)
            view.bottom.equalToSuperview().inset(76)
        }

        pageControl.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(116)
            view.leading.equalToSuperview().offset(115.5)
            view.trailing.equalToSuperview().inset(115.5)
            view.height.equalTo(10)
        }

        descriptionLabel.snp.makeConstraints { view in
            view.top.equalTo(bottomView.snp.top).offset(24)
            view.leading.equalToSuperview().offset(24)
            view.trailing.equalToSuperview().inset(24)
            view.height.equalTo(82)
        }

        continueButton.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(42)
            view.leading.equalToSuperview().offset(24)
            view.trailing.equalToSuperview().inset(24)
            view.height.equalTo(50)
        }
    }

    private func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(hex: "#470E54")!.cgColor, UIColor(hex: "#130215")!.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = self.view.bounds

        self.view.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

}

//MARK: Make buttons actions
extension OnboardingViewController {
    
    private func makeButtonsAction() {
        continueButton.addTarget(self, action: #selector(continueButtonTaped), for: .touchUpInside)
    }

    @objc func continueButtonTaped() {
        guard let navigationController = self.navigationController else { return }

        let numberOfItems = self.collectionView.numberOfItems(inSection: 0)
        let nextRow = self.currentIndex + 1

        if nextRow < numberOfItems {
            let nextIndexPath = IndexPath(item: nextRow, section: 0)
            self.collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            self.currentIndex = nextRow
            pageControl.setPage(1)
        } else {
            OnboardingRouter.showHomeViewController(in: navigationController)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleItems = collectionView.indexPathsForVisibleItems.sorted()
        if let visibleItem = visibleItems.first {
            currentIndex = visibleItem.item
        }
    }
}

extension OnboardingViewController: IViewModelableController {
    typealias ViewModel = IOnboardingViewModel
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel?.onboardingItems.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: OnboardingCell = collectionView.dequeueReusableCell(for: indexPath)
        descriptionLabel.text = viewModel?.onboardingItems[indexPath.row].description
        cell.setup(image: viewModel?.onboardingItems[indexPath.row].image ?? "")
        return cell
    }
}

//MARK: Preview
import SwiftUI

struct OnboardingViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let onboardingViewController = OnboardingViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<OnboardingViewControllerProvider.ContainerView>) -> OnboardingViewController {
            return onboardingViewController
        }

        func updateUIViewController(_ uiViewController: OnboardingViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<OnboardingViewControllerProvider.ContainerView>) {
        }
    }
}
