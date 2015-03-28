class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :wikis
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :username, :name, presence: true

  after_create :create_default_wiki

  private

  def create_default_wiki
    wiki = self.wikis.create!(name: "Here's Your First Wiki!")
    wiki.pages.create!(
      title: "Welcome to InfoShuttle!",
      content: File.read(Rails.root.join('doc', 'default_wiki_page.md'))
    )
  end
end
