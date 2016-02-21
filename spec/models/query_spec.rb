require 'rails_helper'

describe Query do
  context 'auth_token' do
    subject { create :query }
    it 'should create an auth_token after create' do
      expect(subject.auth_token).not_to be_empty
    end

    it 'should keep auth_token after creation' do
      token = subject.auth_token
      subject.save!
      expect(subject.auth_token).to eq token
    end

  end

end