# frozen_string_literal: true

class Event < ApplicationRecord # rubocop:disable Style/Documentation
  belongs_to :department
  has_many :guests
end
