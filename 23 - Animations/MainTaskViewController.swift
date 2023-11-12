//
//  MainTaskViewController.swift
//  23 - Animations
//
//  Created by Ani's Mac on 11.11.23.
//

import UIKit

final class MainTaskViewController: UIViewController {
    
    //MARK: - Properties
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TBC IT Academy"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(red: 51/255, green: 176/255, blue: 199/255, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()
    
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        animateBounceAndFade(for: titleLabel)
    }
    
    //MARK: - Private Methods
    private func setup() {
        setupBackground()
        addSubviews()
        setupConstraints()
    }
    
    private func setupBackground() {
        view.backgroundColor = .white
    }
    
    private func addSubviews() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func animateBounceAndFade(for label: UILabel) {
        UIView.animate(withDuration: 1.9, delay: 0.5, options: [.autoreverse, .repeat], animations: {
            label.frame.origin.y -= 50
            label.alpha = 0.0
        })
        
        UIView.animate(withDuration: 1.9, delay: 0.5, options: [.autoreverse, .repeat], animations: {
            label.alpha = 1.0
        })
    }
}

