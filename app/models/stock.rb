# frozen_string_literal: true

class Stock < ApplicationRecord
  belongs_to :user
  validates :ticker, presence: true
  validates :ticker, format: { without: /\s/ }

end
