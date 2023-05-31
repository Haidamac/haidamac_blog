# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_10_133307) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'articles', force: :cascade do |t|
    t.string 'title'
    t.text 'body'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'status', default: 0
    t.bigint 'author_id'
  end

  create_table 'articletags', force: :cascade do |t|
    t.bigint 'article_id'
    t.bigint 'tag_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['article_id'], name: 'index_articletags_on_article_id'
    t.index ['tag_id'], name: 'index_articletags_on_tag_id'
  end

  create_table 'authors', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'comments', force: :cascade do |t|
    t.string 'body'
    t.integer 'status', default: 0
    t.bigint 'author_id'
    t.bigint 'article_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['article_id'], name: 'index_comments_on_article_id'
    t.index ['author_id'], name: 'index_comments_on_author_id'
  end

  create_table 'likes', force: :cascade do |t|
    t.bigint 'author_id', null: false
    t.string 'likeable_type', null: false
    t.bigint 'likeable_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['author_id'], name: 'index_likes_on_author_id'
    t.index ['likeable_type', 'likeable_id'], name: 'index_likes_on_likeable'
  end

  create_table 'tags', force: :cascade do |t|
    t.string 'tagname'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'comments', 'articles'
  add_foreign_key 'comments', 'authors'
  add_foreign_key 'likes', 'authors'
end
