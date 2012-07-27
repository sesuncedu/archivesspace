class ArchivesSpaceService < Sinatra::Base


  post '/accession/:accession_id' do
    ensure_params ["accession_id" => {:doc => "The accession ID to update", :type => Integer},
                   "accession" => {:doc => "The accession data to update (JSON)"}]

    acc = Accession[params[:accession_id]]

    if acc
      acc.update(JSONModel(:accession).from_json(params[:accession]).to_hash)
    else
      raise NotFoundException.new("Accession not found")
    end

    json_response({:status => "Updated", :id => acc[:id]})
  end


  post '/accession', :operation => :delete do
    ensure_params ["id" => {:doc => "The accession ID(s) to delete", :type => [Integer]}]

    Accession.soft_delete(params[:id])

    json_response({:status => "Deleted", :ids => params[:id]})
  end


  post '/accession', :operation => :undelete do
    ensure_params ["id" => {:doc => "The accession ID(s) to undelete", :type => [Integer]}]

    Accession.undelete(params[:id])

    json_response({:status => "Undeleted", :ids => params[:id]})
  end


  post '/accession' do
    ensure_params ["repo_id" => {:doc => "The ID of the repository containing the accession", :type => Integer},
                   "accession" => {:doc => "The accession to create (JSON)"}]

    accession = JSONModel(:accession).from_json(params[:accession])

    repo = Repository[params[:repo_id]]
    id = repo.create_accession(accession)

    json_response({:status => "Created", :id => id})
  end


  get '/accession' do
    ensure_params ["repo_id" => {:doc => "The ID of the repository containing the accession", :type => Integer}]

    repo = Repository[params[:repo_id]]

    Accession.filter(:db_deleted => 0).collect {|acc| acc.values}.to_json
  end


  get '/accession/:accession_id' do
    ensure_params ["accession_id" => {:doc => "The accession ID", :type => Integer}]

    acc = Accession[params[:accession_id]]

    if acc
      JSONModel(:accession).from_sequel(acc).to_json
    else
      raise NotFoundException.new("Accession not found")
    end
  end
end
