class AddSomeSampleUsers < ActiveRecord::Migration
  def up
    User.create(
      email:    'admin@example.com',
      password: 'password',
      admin:    true
    )
    User.create(
      email:    'member@example.com',
      password: 'password',
      admin:    false
    )
  end

  def down
    admin = User.find_by_email('admin@example.com')
    admin.destroy if admin

    member = User.find_by_email('member@example.com')
    member.destroy if member
  end
end
