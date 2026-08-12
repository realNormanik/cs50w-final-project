-- ============================================================
-- schema.sql
-- Schemat bazy danych Cloudflare D1 (SQLite) wygenerowany na
-- podstawie models.py oraz migracji 0001_initial.py i
-- 0002_pipelinestage_is_final.py aplikacji "crm" (Django).
--
-- Uwaga: D1 to silnik oparty na SQLite, więc typy danych są
-- mapowane na typy SQLite (INTEGER, TEXT, REAL, NUMERIC).
-- Foreign keys w SQLite wymagają włączenia:
--   PRAGMA foreign_keys = ON;
-- (D1 zazwyczaj ma to wymuszone domyślnie, ale warto pamiętać).
-- ============================================================


-- ------------------------------------------------------------
-- auth_user (django.contrib.auth) — wymagana, ponieważ
-- wszystkie modele mają ForeignKey do User (settings.AUTH_USER_MODEL).
-- Standardowa struktura tabeli Django (django.contrib.auth.models.User).
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS auth_user (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    password      TEXT    NOT NULL,
    last_login    TEXT,
    is_superuser  INTEGER NOT NULL DEFAULT 0,
    username      TEXT    NOT NULL UNIQUE,
    first_name    TEXT    NOT NULL DEFAULT '',
    last_name     TEXT    NOT NULL DEFAULT '',
    email         TEXT    NOT NULL DEFAULT '',
    is_staff      INTEGER NOT NULL DEFAULT 0,
    is_active     INTEGER NOT NULL DEFAULT 1,
    date_joined   TEXT    NOT NULL
);


-- ------------------------------------------------------------
-- django_content_type (django.contrib.contenttypes)
-- Wymagana przez auth_permission oraz django_admin_log.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS django_content_type (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    app_label  TEXT NOT NULL,
    model      TEXT NOT NULL,
    UNIQUE (app_label, model)
);


-- ------------------------------------------------------------
-- auth_permission (django.contrib.auth)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS auth_permission (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    name            TEXT    NOT NULL,
    content_type_id INTEGER NOT NULL,
    codename        TEXT    NOT NULL,
    FOREIGN KEY (content_type_id) REFERENCES django_content_type (id) ON DELETE CASCADE,
    UNIQUE (content_type_id, codename)
);

CREATE INDEX IF NOT EXISTS auth_permission_content_type_id_idx
    ON auth_permission (content_type_id);


-- ------------------------------------------------------------
-- auth_group (django.contrib.auth)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS auth_group (
    id    INTEGER PRIMARY KEY AUTOINCREMENT,
    name  TEXT NOT NULL UNIQUE
);


-- ------------------------------------------------------------
-- auth_group_permissions — tabela pośrednia (Group <-> Permission)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS auth_group_permissions (
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    group_id       INTEGER NOT NULL,
    permission_id  INTEGER NOT NULL,
    FOREIGN KEY (group_id)      REFERENCES auth_group (id)      ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES auth_permission (id) ON DELETE CASCADE,
    UNIQUE (group_id, permission_id)
);

CREATE INDEX IF NOT EXISTS auth_group_permissions_group_id_idx
    ON auth_group_permissions (group_id);
CREATE INDEX IF NOT EXISTS auth_group_permissions_permission_id_idx
    ON auth_group_permissions (permission_id);


-- ------------------------------------------------------------
-- auth_user_groups — tabela pośrednia (User <-> Group)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS auth_user_groups (
    id        INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id   INTEGER NOT NULL,
    group_id  INTEGER NOT NULL,
    FOREIGN KEY (user_id)  REFERENCES auth_user (id)  ON DELETE CASCADE,
    FOREIGN KEY (group_id) REFERENCES auth_group (id) ON DELETE CASCADE,
    UNIQUE (user_id, group_id)
);

CREATE INDEX IF NOT EXISTS auth_user_groups_user_id_idx  ON auth_user_groups (user_id);
CREATE INDEX IF NOT EXISTS auth_user_groups_group_id_idx ON auth_user_groups (group_id);


-- ------------------------------------------------------------
-- auth_user_user_permissions — tabela pośrednia (User <-> Permission)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS auth_user_user_permissions (
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id        INTEGER NOT NULL,
    permission_id  INTEGER NOT NULL,
    FOREIGN KEY (user_id)       REFERENCES auth_user (id)       ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES auth_permission (id) ON DELETE CASCADE,
    UNIQUE (user_id, permission_id)
);

CREATE INDEX IF NOT EXISTS auth_user_user_permissions_user_id_idx
    ON auth_user_user_permissions (user_id);
CREATE INDEX IF NOT EXISTS auth_user_user_permissions_permission_id_idx
    ON auth_user_user_permissions (permission_id);


-- ------------------------------------------------------------
-- django_admin_log (django.contrib.admin)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS django_admin_log (
    id               INTEGER PRIMARY KEY AUTOINCREMENT,
    action_time      TEXT    NOT NULL,
    object_id        TEXT,
    object_repr      TEXT    NOT NULL,
    action_flag      INTEGER NOT NULL,
    change_message   TEXT    NOT NULL,
    content_type_id  INTEGER,
    user_id          INTEGER NOT NULL,
    FOREIGN KEY (content_type_id) REFERENCES django_content_type (id) ON DELETE SET NULL,
    FOREIGN KEY (user_id)         REFERENCES auth_user (id)           ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS django_admin_log_content_type_id_idx
    ON django_admin_log (content_type_id);
CREATE INDEX IF NOT EXISTS django_admin_log_user_id_idx
    ON django_admin_log (user_id);


-- ------------------------------------------------------------
-- django_session (django.contrib.sessions)
-- Wymagana m.in. przy logowaniu / rejestracji użytkownika
-- (request.session), inaczej: "no such table: django_session".
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS django_session (
    session_key   TEXT PRIMARY KEY,
    session_data  TEXT NOT NULL,
    expire_date   TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS django_session_expire_date_idx
    ON django_session (expire_date);


-- ------------------------------------------------------------
-- crm_pipelinestage
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS crm_pipelinestage (
    id        INTEGER PRIMARY KEY AUTOINCREMENT,
    name      TEXT    NOT NULL,
    "order"   INTEGER NOT NULL DEFAULT 0,
    owner_id  INTEGER NOT NULL,
    is_final  INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (owner_id) REFERENCES auth_user (id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS crm_pipelinestage_owner_id_idx
    ON crm_pipelinestage (owner_id);


-- ------------------------------------------------------------
-- crm_client
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS crm_client (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    owner_id    INTEGER NOT NULL,
    first_name  TEXT    NOT NULL,
    last_name   TEXT    NOT NULL DEFAULT '',
    company     TEXT    NOT NULL DEFAULT '',
    email       TEXT    NOT NULL DEFAULT '',
    phone       TEXT    NOT NULL DEFAULT '',
    notes       TEXT    NOT NULL DEFAULT '',
    created_at  TEXT    NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES auth_user (id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS crm_client_owner_id_idx
    ON crm_client (owner_id);


-- ------------------------------------------------------------
-- crm_deal
-- priority: CharField z choices ("low", "medium", "high") — w SQLite/D1
-- to nadal TEXT; walidacja choices odbywa się po stronie Django, nie bazy.
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS crm_deal (
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    owner_id     INTEGER  NOT NULL,
    title        TEXT     NOT NULL,
    description  TEXT     NOT NULL DEFAULT '',
    client_id    INTEGER  NOT NULL,
    stage_id     INTEGER  NOT NULL,
    value        NUMERIC  NOT NULL DEFAULT 0,
    priority     TEXT     NOT NULL DEFAULT 'medium',
    due_date     TEXT,
    "order"      INTEGER  NOT NULL DEFAULT 0,
    created_at   TEXT     NOT NULL,
    updated_at   TEXT     NOT NULL,
    is_closed    INTEGER  NOT NULL DEFAULT 0,
    FOREIGN KEY (owner_id)  REFERENCES auth_user (id)        ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES crm_client (id)       ON DELETE CASCADE,
    FOREIGN KEY (stage_id)  REFERENCES crm_pipelinestage (id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS crm_deal_owner_id_idx  ON crm_deal (owner_id);
CREATE INDEX IF NOT EXISTS crm_deal_client_id_idx ON crm_deal (client_id);
CREATE INDEX IF NOT EXISTS crm_deal_stage_id_idx  ON crm_deal (stage_id);


-- ------------------------------------------------------------
-- crm_activity
-- deal_id: ForeignKey z on_delete=SET_NULL, null=True
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS crm_activity (
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    owner_id       INTEGER NOT NULL,
    client_id      INTEGER NOT NULL,
    deal_id        INTEGER,
    activity_type  TEXT    NOT NULL,
    content        TEXT    NOT NULL,
    created_at     TEXT    NOT NULL,
    FOREIGN KEY (owner_id)  REFERENCES auth_user (id)  ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES crm_client (id) ON DELETE CASCADE,
    FOREIGN KEY (deal_id)   REFERENCES crm_deal (id)   ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS crm_activity_owner_id_idx  ON crm_activity (owner_id);
CREATE INDEX IF NOT EXISTS crm_activity_client_id_idx ON crm_activity (client_id);
CREATE INDEX IF NOT EXISTS crm_activity_deal_id_idx   ON crm_activity (deal_id);


-- ------------------------------------------------------------
-- crm_task
-- client_id, deal_id: ForeignKey z null=True, blank=True (on_delete=CASCADE)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS crm_task (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    owner_id    INTEGER NOT NULL,
    client_id   INTEGER,
    deal_id     INTEGER,
    title       TEXT    NOT NULL,
    due_date    TEXT,
    is_done     INTEGER NOT NULL DEFAULT 0,
    created_at  TEXT    NOT NULL,
    FOREIGN KEY (owner_id)  REFERENCES auth_user (id)  ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES crm_client (id) ON DELETE CASCADE,
    FOREIGN KEY (deal_id)   REFERENCES crm_deal (id)   ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS crm_task_owner_id_idx  ON crm_task (owner_id);
CREATE INDEX IF NOT EXISTS crm_task_client_id_idx ON crm_task (client_id);
CREATE INDEX IF NOT EXISTS crm_task_deal_id_idx   ON crm_task (deal_id);