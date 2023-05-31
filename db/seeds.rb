10.times do
  Tag.create({ tagname: Faker::ProgrammingLanguage.name })
end

5.times do
  author = Author.create({ name: Faker::Name.last_name })
  7.times do
    article = Article.create({ title: Faker::ProgrammingLanguage.name, body: Faker::Quote.matz, author_id: author.id, tag_ids: [1, 2, 5] })
    5.times do
      Comment.create({ body: Faker::Quote.jack_handey, author_id: author.id, article_id: article.id })
    end
  end
end
