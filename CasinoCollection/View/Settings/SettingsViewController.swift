//
//  SettingsViewController.swift
//  CasinoCollection
//
//  Created by Er Baghdasaryan on 22.11.24.
//

import UIKit
import CasinoCollectionViewModel
import SnapKit
import StoreKit

class SettingsViewController: BaseViewController {

    var viewModel: ViewModel?

    private let grabber = UIImageView(image: UIImage(named: "grabber"))
    private let pageTitle = UILabel(text: "Settings",
                                    textColor: .white,
                                    font: UIFont(name: "SFProText-Semibold", size: 17))
    private let share = UIButton(type: .system)
    private let rate = UIButton(type: .system)
    private let usage = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#150218")

        self.share.setTitle("Share the app", for: .normal)
        self.share.setTitleColor(.white, for: .normal)
        self.share.layer.masksToBounds = true
        self.share.layer.cornerRadius = 24
        self.share.backgroundColor = UIColor.white.withAlphaComponent(0.05)

        self.rate.setTitle("Rate our app", for: .normal)
        self.rate.setTitleColor(.white, for: .normal)
        self.rate.layer.masksToBounds = true
        self.rate.layer.cornerRadius = 24
        self.rate.backgroundColor = UIColor.white.withAlphaComponent(0.05)

        self.usage.setTitle("Usage Policy", for: .normal)
        self.usage.setTitleColor(.white, for: .normal)
        self.usage.layer.masksToBounds = true
        self.usage.layer.cornerRadius = 24
        self.usage.backgroundColor = UIColor.white.withAlphaComponent(0.05)

        self.view.addSubview(grabber)
        self.view.addSubview(pageTitle)
        self.view.addSubview(share)
        self.view.addSubview(rate)
        self.view.addSubview(usage)

        setupConstraints()
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

        share.snp.makeConstraints { view in
            view.top.equalTo(pageTitle.snp.bottom).offset(28)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(54)
        }

        rate.snp.makeConstraints { view in
            view.top.equalTo(share.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(54)
        }

        usage.snp.makeConstraints { view in
            view.top.equalTo(rate.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(54)
        }
    }

    override func setupViewModel() {
        super.setupViewModel()
    }
}

//MARK: Make buttons actions
extension SettingsViewController{
    
    private func makeButtonsAction() {
        share.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        rate.addTarget(self, action: #selector(rateTapped), for: .touchUpInside)
        usage.addTarget(self, action: #selector(usageTapped), for: .touchUpInside)
    }

    @objc func shareTapped() {
        let appStoreURL = URL(string: "https://apps.apple.com/us/app/casino-collection/id6738487971")!

        let activityViewController = UIActivityViewController(activityItems: [appStoreURL], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view

        activityViewController.excludedActivityTypes = [
            .postToWeibo,
            .print,
            .assignToContact,
            .saveToCameraRoll,
            .addToReadingList,
            .postToFlickr,
            .postToVimeo,
            .postToTencentWeibo,
            .openInIBooks,
            .markupAsPDF
        ]

        present(activityViewController, animated: true, completion: nil)
    }

    @objc func rateTapped() {
        if #available(iOS 14.0, *) {
            SKStoreReviewController.requestReview()
        } else {
            let alertController = UIAlertController(
                title: "Enjoying the app?",
                message: "Please consider leaving us a review in the App Store!",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Go to App Store", style: .default) { _ in
                if let appStoreURL = URL(string: "https://apps.apple.com/us/app/casino-collection/id6738487971") {
                    UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
                }
            })
            present(alertController, animated: true, completion: nil)
        }
    }

    @objc func usageTapped() {
        SettingsRouter.showUsageViewController(in: self)
    }
}

extension SettingsViewController: IViewModelableController {
    typealias ViewModel = ISettingsViewModel
}

//MARK: Preview
import SwiftUI

struct SettingsViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let settingsViewController = SettingsViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SettingsViewControllerProvider.ContainerView>) -> SettingsViewController {
            return settingsViewController
        }

        func updateUIViewController(_ uiViewController: SettingsViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SettingsViewControllerProvider.ContainerView>) {
        }
    }
}
