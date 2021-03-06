require 'spec_helper'

describe 'Repository controller' do

  it "lets you create a repository" do
    post '/repository', params = {
      :repository => JSONModel(:repository).
                     from_hash({
                                 "repo_id" => "ARCHIVESSPACE",
                                 "description" => "A new ArchivesSpace repository"
                               }).to_json
    }

    last_response.should be_ok
    JSON(last_response.body)["id"].should be_a_kind_of Integer
  end


  it "gives a list of all repositories" do
    post '/repository', params = {
      :repository => JSONModel(:repository).
                     from_hash({
                                 "repo_id" => "ARCHIVESSPACE",
                                 "description" => "A new ArchivesSpace repository"
                               }).to_json
    }

    post '/repository', params = {
      :repository => JSONModel(:repository).
                     from_hash({
                                 "repo_id" => "TEST",
                                 "description" => "A new ArchivesSpace repository"
                               }).to_json
    }


    get '/repository'

    last_response.should be_ok
    repos = JSON(last_response.body)

    repos.any? { |repo| repo["repo_id"] == "ARCHIVESSPACE" }.should be_true
    repos.any? { |repo| repo["repo_id"] == "TEST" }.should be_true
  end

end
