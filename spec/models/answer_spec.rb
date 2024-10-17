# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to belong_to :question }
  it { is_expected.to belong_to(:author).class_name('User') }

  it 'have many attached files' do
    expect(described_class.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
  end
end
