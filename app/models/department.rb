# frozen_string_literal: true

class Department < ApplicationRecord # rubocop:disable Style/Documentation
  has_many :events, dependent: :destroy
end
