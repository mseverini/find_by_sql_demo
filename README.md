# README

I found an interesting issue in rails this is what I learned:

This does NOT work:
```ruby
find_by_sql(<<~SQL)
    SELECT * FROM users JOIN active_users ON users.id = active_users.user_id
   SQL
```

This does work: 
```ruby
find_by_sql(<<~SQL)
    SELECT users.* FROM users JOIN active_users ON users.id = active_users.user_id
   SQL
```

The interesting part is the rails DOES return an active record relation from the first query.
Disappointingly, the retuned model is invalid as it has the wrong id 😱
