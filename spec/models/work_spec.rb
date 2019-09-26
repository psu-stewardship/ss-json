# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Work, type: :model do
  describe 'table' do
    it { is_expected.not_to have_db_column(:metadata).of_type(:jsonb) }
    it { is_expected.to have_db_column(:depositor_id) }
    it { is_expected.to have_db_index(:depositor_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:depositor).class_name('User').with_foreign_key(:depositor_id) }
    it { is_expected.to have_many(:work_creations) }
    it { is_expected.to have_many(:aliases).through(:work_creations) }
    it { is_expected.to have_many(:work_versions) }
    it { is_expected.to accept_nested_attributes_for(:work_versions) }
  end

  describe 'initialize' do
    it 'initializes a work version too' do
      expect(described_class.new.work_versions).not_to be_empty
    end

    it 'accepts initial work versions' do
      work_versions = [WorkVersion.new]
      new_work = described_class.new(work_versions: work_versions)
      expect(new_work.work_versions).to match_array(work_versions)
    end
  end
end
