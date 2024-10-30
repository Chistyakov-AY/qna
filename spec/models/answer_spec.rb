# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to belong_to :question }
  it { is_expected.to belong_to(:author).class_name('User') }
  it { should have_many(:links).dependent(:destroy) }
  it { should accept_nested_attributes_for :links }
end
