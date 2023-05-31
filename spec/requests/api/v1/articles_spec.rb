require 'swagger_helper'
require 'rails_helper'

RSpec.describe 'api/v1/articles', type: :request do
  let!(:author) { Author.first }
  let!(:article) { Article.first }
  let!(:comment) { Comment.first }
  let!(:tags) { Tag.first }
  path '/api/v1/articles' do
    get('list articles') do
      tags 'Article'
      consumes 'application/json'
      parameter name: :page, in: :query, schema: { type: :string },
                description: 'Get articles after the first 15 by page number'
      parameter name: :status, in: :query, schema: { type: :string, enum: %w[unpublished published] },
                description: 'Get articles with status: published/unpublished'
      parameter name: :author, in: :query, schema: { type: :string },
                description: 'Get articles by a specific author'
      parameter name: :tags_ids, in: :query, schema: { type: :string },
                description: 'Filter articles by tags'
      response(200, 'successful') do
        let(:page) { '1' }
        let(:status) { 'unpublished' }
        let(:tags_ids) { Tag.first.id }
        let(:author) { Author.first }
        let(:author_id) { Author.first.id }
        let(:author.name) { Author.first.name }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create article') do
      tags 'Article'
      consumes 'application/json'
      parameter name: :article, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          body: { type: :string },
          author_id: { type: :integer }
        },
        required: %w[title body author_id]
      }
      response(201, 'successful') do
        let(:author) { create(:author) }
        let(:author_id) { author.id }
        let(:article) { create(:article, author_id: author_id) }
        let(:id) { article.id }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do
          data = JSON.parse(response.body)
          expect(data['data']['title']).to eq('Lorem')
        end
      end
    end
  end

  path '/api/v1/articles/{id}' do
    let(:id) { article.id }
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'
    get('show article') do
      tags 'Article'
      response(200, 'successful') do
        let(:title) { article.title }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do
          data = JSON.parse(response.body)
          expect(data['title']).to eq(article.title)
        end
      end
    end

    patch('update article') do
      tags 'Article'
      consumes 'application/json'
      parameter name: :article, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          body: { type: :string },
          author_id: { type: :integer },
          status: { type: :string, enum: %w[unpublished published] }
        },
        required: false
      }
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          article.update(status: 'published')
          expect(Article.find_by(status: 'published')).to eq(article)
        end
      end
    end

    put('update article') do
      tags 'Article'
      consumes 'application/json'
      parameter name: :article, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          body: { type: :string },
          author_id: { type: :integer },
          status: { type: :string, enum: %w[unpublished published] }
        },
        required: false
      }
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          article.update(body: 'Lorem ipsum dolor sit amet consectetur adipiscing elit')
          expect(Article.find_by(body: 'Lorem ipsum dolor sit amet consectetur adipiscing elit')).to eq(article)
        end
      end
    end

    delete('delete article') do
      tags 'Article'
      response(200, 'Delete') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          article.destroy
          expect(Article.find_by_id('id')).to eq(nil)
        end
      end
    end
  end

  path '/api/v1/search' do
    get('search article') do
      tags 'Article'
      consumes 'application/json'
      parameter name: :q, in: :query, schema: { type: :string },
                description: 'Search articles by phrase in title or body'
      response(200, 'successful') do
        let(:q) { 'programming' }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/order' do
    get('order articles') do
      tags 'Article'
      consumes 'application/json'
      parameter name: :order, in: :query, schema: { type: :string }, description: 'Order articles by title asc/desc'
      response(200, 'successful') do
        let(:order) { 'asc' }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
