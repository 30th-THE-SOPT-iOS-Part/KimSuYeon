//
//  MusicViewController.swift
//  30th-3week-seminar
//
//  Created by 김수연 on 2022/04/23.
//

import UIKit

class MusicViewController: UIViewController {

    @IBOutlet weak var musicTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: MusicTableViewCell.identifier, bundle: nil)
        musicTableView.register(nib, forCellReuseIdentifier: MusicTableViewCell.identifier)

        musicTableView.delegate = self
        musicTableView.dataSource = self
    }

}

extension MusicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension MusicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MusicDataModel.sampleData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MusicTableViewCell.identifier, for: indexPath) as? MusicTableViewCell else { return UITableViewCell() }

        cell.setData(MusicDataModel.sampleData[indexPath.row])

        return cell
    }
}
