class Word < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, format:
                     {with: /\A([a-z\s]|\([a-z\s]+\))+\z/,
                      message: "only allows text in low-letters and in scopes"}
  validates :definition, presence: true, format:
                           {with: /\A([a-zA-Z.,!\-\s]|\([a-zA-Z.,!\-\s]+\))+\z/, message: "only allows letters,spaces and punctuation marks"}
end
