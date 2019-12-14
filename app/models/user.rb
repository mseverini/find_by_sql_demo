class User < ApplicationRecord
  scope :active, -> () { find_by_sql(<<~SQL)
    SELECT users.* FROM users JOIN active_users ON users.id = active_users.user_id
   SQL
  }

  scope :active_wrong, -> () { find_by_sql(<<~SQL)
    SELECT * FROM users JOIN active_users ON users.id = active_users.user_id
  SQL
  }
end
