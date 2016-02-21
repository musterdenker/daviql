require 'rails_helper'
describe "Queries API", type: :request do
  context "not found" do
    it "should return not found for non existing queries" do
      get '/api/v1/queries/99'
      expect(response).to be_not_found
    end
  end

  context "auth" do
    subject{ create :query}
    it "should return no access without a token" do
      get "/api/v1/queries/#{subject.id}"
      expect(response).to be_unauthorized
    end
    it "should return no access with wrong token" do
      get "/api/v1/queries/#{subject.id}&auth_token=wrong"
      expect(response).to be_unauthorized
    end
    it "should allow access with correct token" do
      allow_any_instance_of(Query).to receive(:execute).and_return([])
      get "/api/v1/queries/#{subject.id}?auth_token=#{subject.auth_token}"
      expect(response).to be_success
    end
  end

  context "body" do
    subject{ create :query}
    before{
      allow_any_instance_of(Query).to receive(:execute).and_return([{foo: :bar}])
    }
    it "should return coorect data" do
      get "/api/v1/queries/#{subject.id}?auth_token=#{subject.auth_token}"
      expect(JSON.parse(response.body).size).to eq 1
      expect(JSON.parse(response.body).first.keys.first).to eq "foo"
    end
  end

end