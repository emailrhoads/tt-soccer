CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "users" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar NOT NULL, "crypted_password" varchar, "salt" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE sqlite_sequence(name,seq);
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE TABLE IF NOT EXISTS "teams" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "country" varchar NOT NULL, "name" varchar NOT NULL, "balance" decimal NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_45096701b6"
FOREIGN KEY ("user_id")
  REFERENCES "users" ("id")
);
CREATE INDEX "index_teams_on_user_id" ON "teams" ("user_id");
CREATE TABLE IF NOT EXISTS "players" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "team_id" integer NOT NULL, "age" integer NOT NULL, "asking_price" decimal, "country" varchar NOT NULL, "first_name" varchar NOT NULL, "last_name" varchar NOT NULL, "market_value" decimal NOT NULL, "position" varchar NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_8880a915a5"
FOREIGN KEY ("team_id")
  REFERENCES "teams" ("id")
);
CREATE INDEX "index_players_on_team_id" ON "players" ("team_id");
INSERT INTO "schema_migrations" (version) VALUES
('20220107032701'),
('20220107051551'),
('20220108185653'),
('20220110003231');


