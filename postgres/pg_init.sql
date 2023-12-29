CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(20) NOT NULL UNIQUE,
  email VARCHAR(255) NOT NULL UNIQUE,
  email_verified BOOLEAN DEFAULT false,
  image TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES users(id),
  provider_id VARCHAR(255) NOT NULL,
  provider_type VARCHAR(255) NOT NULL,
  provider_account_id VARCHAR(255) NOT NULL,
  refresh_token TEXT,
  access_token TEXT NOT NULL,
  expires_at TIMESTAMP WITH TIME ZONE,
  token_type VARCHAR(255),
  scope TEXT,
  id_token TEXT,
  session_state TEXT
);

CREATE TABLE verification_tokens (
  identifier VARCHAR(255) PRIMARY KEY,
  token TEXT NOT NULL,
  expires TIMESTAMP WITH TIME ZONE NOT NULL
);

CREATE TABLE auth_sessions (
  id SERIAL PRIMARY KEY,
  expires TIMESTAMP WITH TIME ZONE NOT NULL,
  session_token TEXT NOT NULL,
  user_id UUID NOT NULL REFERENCES users(id)
);

CREATE TYPE winner_reason AS ENUM ('play', 'resignation', 'time');

CREATE TABLE games (
  id UUID PRIMARY KEY,
  time_seconds integer NOT NULL,
  history VARCHAR NOT NULL,
  white_player_id UUID NOT NULL REFERENCES users(id),
  black_player_id UUID NOT NULL REFERENCES users(id),
  white_winner boolean NOT NULL,
  winning_reason winner_reason,
  started_at TIMESTAMP NOT NULL,
  finished_at TIMESTAMP NOT NULL
);
