//
//  CharactersViewController.swift
//  Yassir_Character
//
//  Created by Ibrahim Mostafa on 29/05/2024.
//

import UIKit
import SwiftUI
import Combine

class CharactersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var aliveButton: UIButton!
    @IBOutlet weak var deadButton: UIButton!
    @IBOutlet weak var unknownButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    private let viewModel = CharactersViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupTableView()
        
        bindTableView()
        
        Task { [weak self] in
            await self?.viewModel.getCharacters()
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharacterTableViewCell.nib, forCellReuseIdentifier: CharacterTableViewCell.reuseIdentifier)
    }
    
    private func bindTableView() {
        viewModel.$characters
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
}

extension CharactersViewController {
    @IBAction func filterButtonsAction(_ sender: UIButton) {
        // deselect All buttons
        aliveButton.isSelected = false
        deadButton.isSelected = false
        unknownButton.isSelected = false
        
        // Select tapped button
        sender.isSelected = true
        
        switch sender {
        case aliveButton:
            viewModel.filterCharacters(by: .alive)
        case deadButton:
            viewModel.filterCharacters(by: .dead)
        case unknownButton:
            viewModel.filterCharacters(by: .unknown)
        default:
            viewModel.filterCharacters(by: .none)
            
        }
        
        // Always deselct the clear button
        clearButton.isSelected = false
        
    }
    
}

extension CharactersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.reuseIdentifier) as? CharacterTableViewCell
        
        guard let cell else {
            fatalError("Can't found the CharacterTableViewCell")
        }
        
        let cellViewModel = viewModel.getCharacterViewModel(for: indexPath.row)
        cell.fillCell(with: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterViewModel = viewModel.getCharacterViewModel(for: indexPath.row)
        let characterDetailsView = CharacterDetails(viewModel: characterViewModel)
        
        let detailesViewController = UIHostingController(rootView: characterDetailsView)
        
        detailesViewController.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.pushViewController(detailesViewController, animated: true)
    }
    

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)  {
        if indexPath.row == viewModel.rowsCount - 3 {
            Task { [weak self] in
                await self?.viewModel.loadNextPage()
            }
        }
    }
    
    
}

