# frozen_string_literal: true

class RenameAdministrateurToAdminInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :administrateur, :role
    change_column :users, :role, :string, default: 'user'
  end
end
