class AddCoInvestigadorToProyects < ActiveRecord::Migration
  def change
    add_column :proyects, :co_investigador, :string
  end
end
