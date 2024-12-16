//
//  DetailViewController.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 16.12.24.
//

import UIKit
import CasinoCollectionViewModel
import SnapKit
import StoreKit

class DetailViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let topImage = UIImageView(image: .init(named: "thirdMain"))
    private let bottomView = UIView()
    private let descriptionLabel = UILabel(text: "Manage your personal finances",
                                           textColor: .white,
                                           font: UIFont(name: "SFProText-Bold", size: 34))
    private let continueButton = UIButton(type: .system)

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

        setupConstraints()
        setupNavigationItems()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func sizeForItem() -> CGSize {
        let deviceType = UIDevice.currentDeviceType

        switch deviceType {
        case .iPhone:
            let width = self.view.frame.size.width
            let heightt = self.view.frame.size.height
            return CGSize(width: width, height: heightt)
        case .iPad:
            let scaleFactor: CGFloat = 1.5
            let width = 550 * scaleFactor
            let height = 1100 * scaleFactor
            return CGSize(width: width, height: height)
        }
    }

    func setupConstraints() {
        self.view.addSubview(topImage)
        self.view.addSubview(bottomView)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(continueButton)

        topImage.snp.makeConstraints { view in
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.top.equalToSuperview()
        }

        bottomView.snp.makeConstraints { view in
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(222)
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
extension DetailViewController {
    
    private func makeButtonsAction() {
        continueButton.addTarget(self, action: #selector(continueButtonTaped), for: .touchUpInside)
    }

    @objc func continueButtonTaped() {
        guard let navigationController = self.navigationController else { return }
        let alertController = UIAlertController(title: "Notifications Enabled",
                                                message: "You will now receive notifications.",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            DetailRouter.showFeatureViewController(in: navigationController)
        }
        alertController.addAction(okAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }

    private func setupNavigationItems() {
        let closeButton = UIBarButtonItem(image: UIImage(named: "closeButton"), style: .done, target: self, action: #selector(closeTapped))
        navigationItem.rightBarButtonItem = closeButton
    }

    @objc func closeTapped() {
        guard let navigationController = self.navigationController else { return }
        let alertController = UIAlertController(title: "Notifications Disabled",
                                                message: "You will now disable notifications.",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            DetailRouter.showFeatureViewController(in: navigationController)
        }
        alertController.addAction(okAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
}

extension DetailViewController: IViewModelableController {
    typealias ViewModel = IDetailViewModel
}


//MARK: Preview
import SwiftUI

struct DetailViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let detailViewController = DetailViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<DetailViewControllerProvider.ContainerView>) -> DetailViewController {
            return detailViewController
        }

        func updateUIViewController(_ uiViewController: DetailViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<DetailViewControllerProvider.ContainerView>) {
        }
    }
}
