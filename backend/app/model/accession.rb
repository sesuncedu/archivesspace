class Accession < Sequel::Model(:accessions)
  plugin :validation_helpers

  include ASModel


  def validate
    super
    self.db_deleted ||= 0
    validates_unique([:accession_id_0, :accession_id_1, :accession_id_2, :accession_id_3, :db_deleted])
  end

  def self.[](id)
    self.filter(:id => id, :db_deleted => 0).first
  end

  def self.soft_delete(ids)
    Accession.dataset.filter(:id => ids).update(:db_deleted => Time.now.to_i)
  end


  def self.undelete(ids)
    Accession.dataset.filter(:id => ids).update(:db_deleted => 0)
  end

end
