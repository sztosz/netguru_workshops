require 'spec_helper'

describe Category do
  describe 'validations' do
    it { should validate_uniqueness_of :name }
  end
end
