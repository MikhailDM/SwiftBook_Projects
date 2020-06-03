//
//  NewsfeedPresenter.swift
//  VKNewsFeed
//
//  Created by Алексей Пархоменко on 15/03/2019.
//  Copyright (c) 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogic {
    func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
    weak var viewController: NewsfeedDisplayLogic?
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ru_RU")
        df.dateFormat = "d MMM 'в' HH:mm"
        return df
    }()
    
    func presentData(response: Newsfeed.Model.Response.ResponseType) {
        switch response {
        case .presentNewsfeed(feed: let feed):
            let cells = feed.items.map { (feedItem) in
                cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups)
            }
            let feedViewModel = FeedViewModel.init(cells: cells)
            //Идем в Controller
            viewController?.displayData(viewModel: .displayNewsfeed(feedViewModel: feedViewModel))
        }
    }
    
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group]) -> FeedViewModel.Cell {
        //Профиль
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        //Дата поста
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        //1 ячейка
        return FeedViewModel.Cell.init(iconUrlString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: feedItem.text,
                                       likes: String(feedItem.likes?.count ?? 0),
                                       comments: String(feedItem.comments?.count ?? 0),
                                       shares: String(feedItem.reposts?.count ?? 0),
                                       views: String(feedItem.views?.count ?? 0))
    }
    
    //Профиль группы или страницы
    private func profile(for sourseId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable {
        let profilesOrGroups: [ProfileRepresentable] = sourseId >= 0 ? profiles : groups
        let normalSourceId = sourseId >= 0 ? sourseId : -sourseId
        let profileRepresentable = profilesOrGroups.first { (myProfileRepresentable) -> Bool in
            myProfileRepresentable.id == normalSourceId
        }
        return profileRepresentable!
    }
    
}
