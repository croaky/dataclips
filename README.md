# Dataclips

Minimum viable [Heroku Dataclips](https://devcenter.heroku.com/articles/dataclips) clone.

Run locally:

```bash
createdb db
chmod +x main.rb
DATABASE_URL=postgres:///db ./main.rb
```

Open <http://localhost:4567> in a browser.
You'll see a text area, a "Run" button, and an "Export" button.
Type any SQL you want in to the text area and press "Run".

Example:

```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (name)
VALUES ('croaky');

SELECT *
FROM users;
```
