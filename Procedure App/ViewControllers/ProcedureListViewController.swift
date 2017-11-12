//
//  ProcedureListViewController.swift
//  Procedure App
//
//  Created by Mat Nuckowski on 12/11/17.
//  Copyright © 2017 Mat Nuckowski. All rights reserved.
//

import UIKit

class ProcedureListViewController: UIViewController {

	let cellIdentifier = "Procedure cell"

	let model: TSProcedureViewModel
	let tableView = UITableView()

	init(with model: TSProcedureViewModel) {
		self.model = model
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()
    }

	func setupUI() {
		title = model.title
		setupTableView(in: view)
	}

	func setupTableView(in view: UIView) {
		tableView.register(ProcedureTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
		tableView.rowHeight = 90
		tableView.delegate = self
		tableView.dataSource = self
		view.addSubview(tableView)
		tableView.snp.makeConstraints { (make) in
			make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
			make.left.equalTo(view)
			make.right.equalTo(view)
			make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ProcedureListViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return model.cellViewModels.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProcedureTableViewCell else { fatalError("Could not initialise a cell") }
		cell.update(with: model.cellViewModels[indexPath.row])
		cell.selectionStyle = .none
		return cell
	}
}

extension ProcedureListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		model.didSelectRow(at: indexPath)
	}
}
