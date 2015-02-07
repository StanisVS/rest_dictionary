class Word < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, format:
                     {with: /\A[a-z\s()]+\z/, message: "only allows low-letters and white spaces"}
  validates :definition, presence: true, format:
                           {with: /\A[a-zA-Z.,!\-\s()]+\z/, message: "only allows letters,spaces and punctuation marks"}
end
