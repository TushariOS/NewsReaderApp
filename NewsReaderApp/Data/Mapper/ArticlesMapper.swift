//
//  Mapper.swift
//  NewsReaderApp
//
//  Created by Tushar on 09/03/26.
//

extension NewsResponseDTO {
    func toDomain() -> NewsResponse {
        return NewsResponse(
            status: status ?? "",
            totalResults: totalResults ?? 0,
            articles: articles?.map { $0.toDomain() } ?? []
        )
    }
}

extension ArticleDTO {
    func toDomain() -> Article {
        return Article(title: title,
                       publicationDate: publishedAt,
                       source: source?.name,
                       imageURL: urlToImage,
                       description: description,
                       url: url)
    }
}

extension SourceDTO {
    func toDomain() -> Source {
        return Source(
            name: name
        )
    }
}

extension Article {
    func toDTO() -> ArticleDTO {
        return ArticleDTO(
            source: SourceDTO(id: "", name: source ?? ""),
            author: "",
            title: title,
            description: description,
            url: url,
            urlToImage: imageURL,
            publishedAt: publicationDate,
            content: ""
        )
    }
}
