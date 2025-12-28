CREATE TABLE IF NOT EXISTS users(
    id                  UUID PRIMARY KEY,
    username            VARCHAR(20) UNIQUE,
    email               VARCHAR(255) UNIQUE NOT NULL,
    password_hash       VARCHAR(255),
    email_verified      BOOLEAN DEFAULT FALSE,
    is_active           BOOLEAN DEFAULT TRUE,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS oauth_accounts (
    id                  UUID PRIMARY KEY,
    user_id             UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    provider            VARCHAR(50) NOT NULL,
    provider_account_id VARCHAR(255) NOT NULL,
    access_token        TEXT,
    refresh_token       TEXT,
    token_expires_at    TIMESTAMP,
    scope               TEXT,
    id_token            TEXT,
    session_state       TEXT,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(provider,    provider_account_id)
);

CREATE TABLE IF NOT EXISTS sessions (
    id                  UUID PRIMARY KEY,
    user_id             UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    session_token       VARCHAR(255) UNIQUE NOT NULL,
    expires_at          TIMESTAMP NOT NULL,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS maps (
    id                  UUID PRIMARY KEY,
    name                VARCHAR(50) NOT NULL,
    image_url           VARCHAR(255) NOT NULL,
    is_active           BOOLEAN DEFAULT TRUE
);

CREATE TYPE agent_role AS ENUM ('duelist', 'initiator', 'controller', 'sentinel');

CREATE TABLE IF NOT EXISTS agents (
    id                  UUID PRIMARY KEY,
    name                VARCHAR(50) NOT NULL,
    image_url           VARCHAR(255) NOT NULL,
    role                agent_role
);

CREATE TABLE IF NOT EXISTS abilities (
    id                  UUID PRIMARY KEY,
    a_id                UUID REFERENCES agents(id),
    name                VARCHAR(50) NOT NULL,
    image_url           VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS strategies (
    id                  UUID PRIMARY KEY,
    name                VARCHAR(255) NOT NULL,
    user_id             UUID NOT NULL REFERENCES users(id),
    map_id              UUID REFERENCES maps(id),
    side                VARCHAR(50) NOT NULL,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS s_canvas (
    s_id                UUID PRIMARY KEY REFERENCES strategies(id) ON DELETE CASCADE,
    s_data              JSONB NOT NULL,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_oauth_accounts_user_id ON oauth_accounts(user_id);
CREATE INDEX IF NOT EXISTS idx_oauth_accounts_provider ON oauth_accounts(provider, provider_account_id);
CREATE INDEX IF NOT EXISTS idx_sessions_user_id ON sessions(user_id);
CREATE INDEX IF NOT EXISTS idx_sessions_token ON sessions(session_token);
