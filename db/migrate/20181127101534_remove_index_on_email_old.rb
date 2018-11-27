class RemoveIndexOnEmailOld < ActiveRecord::Migration
  def change
    if index_exists? :users, :email_old
      remove_index :users, name: :index_users_on_email_old
    end
  end
end
