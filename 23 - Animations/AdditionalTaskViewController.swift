//
//  AdditionalTaskViewController.swift
//  23 - Animations
//
//  Created by Ani's Mac on 11.11.23.
//

import UIKit

class AdditionalTaskViewController: UIViewController {
    
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
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        return gradientLayer
    }()
    
    private let colorSets: [[CGColor]] = [
        [
            UIColor(red: 0.243, green: 0.153, blue: 0.741, alpha: 1).cgColor,
            UIColor(red: 0.698, green: 0.153, blue: 0.188, alpha: 1).cgColor
        ],
        [
            UIColor(red: 0.4, green: 0.369, blue: 0.553, alpha: 1).cgColor,
            UIColor(red: 0.569, green: 0.369, blue: 0.157, alpha: 1).cgColor
        ],
        [
            UIColor(red: 0.525, green: 0.537, blue: 0.396, alpha: 1).cgColor,
            UIColor(red: 0.478, green: 0.533, blue: 0.11, alpha: 1).cgColor
        ],
        [
            UIColor(red: 0.663, green: 0.71, blue: 0.255, alpha: 1).cgColor,
            UIColor(red: 0.38, green: 0.71, blue: 0.071, alpha: 1).cgColor
        ]
    ]
    
    private var currentColorSetIndex = 0
    private var directionIsForward = true
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        animateSpin(for: titleLabel)
        gradientLayers()
        startGradientColorAnimation()
    }
    
    //MARK: - Private Methods
    private func startGradientColorAnimation() {
        let colorChangeAnimation = CABasicAnimation(keyPath: "colors")
        colorChangeAnimation.duration = 3
        colorChangeAnimation.toValue = getNextColorSet()
        colorChangeAnimation.fillMode = .forwards
        colorChangeAnimation.isRemovedOnCompletion = false
        colorChangeAnimation.delegate = self
        gradientLayer.add(colorChangeAnimation, forKey: "colorChange")
    }
    
    private func getNextColorSet() -> [CGColor] {
        
        if directionIsForward {
            currentColorSetIndex += 1
            if currentColorSetIndex >= colorSets.count {
                currentColorSetIndex = colorSets.count - 1
                directionIsForward = false
            }
        } else {
            currentColorSetIndex -= 1
            if currentColorSetIndex < 0 {
                currentColorSetIndex = 0
                directionIsForward = true
            }
        }
        return colorSets[currentColorSetIndex]
    }
    
    private func gradientLayers() {
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorSets[0]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setup() {
        addSubviews()
        setupConstraints()
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
    
    private func animateSpin(for label: UILabel) {
        UIView.animate(withDuration: 4.8, delay: 0.2, options: [.repeat, .autoreverse], animations: {
            label.transform = label.transform.rotated(by: CGFloat.pi)
        })
    }
}

extension AdditionalTaskViewController: CAAnimationDelegate {
    func animationDidStop(_ animation: CAAnimation, finished flag: Bool) {
        if flag {
            gradientLayer.colors = getNextColorSet()
            startGradientColorAnimation()
        }
    }
}
