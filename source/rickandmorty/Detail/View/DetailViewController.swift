//
//  DetalViewController.swift
//  rickandmorty
//
//  Created by Edno Fedulo on 05/12/20.
//  Copyright © 2020 Edno Fedulo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let s = UIScrollView()
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    lazy var contentView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var stackView:UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.spacing = 10
        
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    lazy var imageView:UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFit
        i.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return i
    }()
    
    var viewModel:DetailViewModel?
    
    init(viewModel:DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        
        addSubviews()
        setupConstraints()
        setupView()
    }
    
    
    private func addSubviews(){
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
    }
    
    func makeTitleLabel(with text:String?) -> UILabel {
        let label = UILabel()
        label.text = text!.isEmpty ? "-" : text
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }
    
    func makeSubtitleLabel(with text:String?) -> UILabel {
        let label = UILabel()
        label.text = text!.isEmpty ? "-" : text
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        let contentHeightConstraint = contentView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
        contentHeightConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            contentHeightConstraint
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10 ),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupView(){
        guard let model = self.viewModel?.model else { return }
        self.title = model.name
        
        self.setupFavoriteButton()
        
        imageView.load(from: URL(string: model.image!)!)
        
        stackView.addArrangedSubview(makeTitleLabel(with: "Species"))
        stackView.addArrangedSubview(makeSubtitleLabel(with: model.species))
        stackView.addArrangedSubview(makeTitleLabel(with: "Type"))
        stackView.addArrangedSubview(makeSubtitleLabel(with: model.type))
        stackView.addArrangedSubview(makeTitleLabel(with: "gender"))
        stackView.addArrangedSubview(makeSubtitleLabel(with: model.gender))
        stackView.addArrangedSubview(makeTitleLabel(with: "Status"))
        stackView.addArrangedSubview(makeSubtitleLabel(with: model.status))
        stackView.addArrangedSubview(makeTitleLabel(with: "Last known location"))
        stackView.addArrangedSubview(makeSubtitleLabel(with: model.location?.name))
        stackView.addArrangedSubview(makeTitleLabel(with: "First seen in"))
        stackView.addArrangedSubview(makeSubtitleLabel(with: model.origin?.name))
    }
    
    func setupFavoriteButton(){
        guard let model = self.viewModel?.model else { return }
        var favoriteImage = UIImage(systemName: "star")
        
        if let favorited = model.isFavorited, favorited {
            favoriteImage = UIImage(systemName: "star.fill")
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: favoriteImage, style: .done, target: self, action: #selector(toggleFavorite))
    }
    
    @objc func toggleFavorite(){
        self.viewModel?.toggleFavoriteCharacter()
        setupFavoriteButton()
    }
}
