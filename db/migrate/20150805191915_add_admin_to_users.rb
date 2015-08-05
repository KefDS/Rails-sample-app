class AddAdminToUsers < ActiveRecord::Migration
  def change
    # Rails figures out the boolean nature of the admin attribute and
    # automatically adds the question-mark method admin?
    add_column :users, :admin, :boolean, default: false
  end
end
