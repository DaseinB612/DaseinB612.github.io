CREATE TABLE IF NOT EXISTS key_value_table (key TEXT PRIMARY KEY, value TEXT NOT NULL);
CREATE TABLE IF NOT EXISTS replication_logical_clock (peer_uuid TEXT PRIMARY KEY, transaction_id INT NOT NULL);
CREATE TABLE IF NOT EXISTS client_triggers_state (trigger_uuid TEXT PRIMARY KEY, trigger_version INT NOT NULL, direct_target BOOL NOT NULL, change_timestamp INT NOT NULL, enabled BOOL NOT NULL, trigger_state BLOB NOT NULL );
CREATE TABLE IF NOT EXISTS replication_log_logical_clock (peer_uuid TEXT NOT NULL, log_type INT NOT NULL, log_severity INT NOT NULL, log_sequence_id INT NOT NULL);

CREATE TABLE IF NOT EXISTS static_objects (object_uuid TEXT PRIMARY KEY, object_version INT NOT NULL, object_type INT NOT NULL, removed INT NOT NULL, object_metadata BLOB NOT NULL);
CREATE TABLE IF NOT EXISTS static_objects_data (object_uuid TEXT PRIMARY KEY, object_data BLOB NOT NULL);
CREATE TABLE IF NOT EXISTS user_static_objects (user_uuid TEXT NOT NULL, object_uuid TEXT NOT NULL, object_version INT NOT NULL, object_type INT NOT NULL, removed INT NOT NULL, object_metadata BLOB NOT NULL, PRIMARY KEY (user_uuid, object_uuid));
CREATE TABLE IF NOT EXISTS user_static_objects_data (user_uuid TEXT NOT NULL, object_uuid TEXT NOT NULL, object_data BLOB NOT NULL, PRIMARY KEY (user_uuid, object_uuid));

CREATE TABLE IF NOT EXISTS symbols (symbol_id INT PRIMARY KEY, symbol_data BLOB NOT NULL);  
CREATE TABLE IF NOT EXISTS wakeup_counter(uuid TEXT PRIMARY KEY,counter INTEGER); 
CREATE TABLE IF NOT EXISTS configuration (config_data BLOB);

CREATE TABLE IF NOT EXISTS dataminer_deltalog(CSN INTEGER PRIMARY KEY AUTOINCREMENT,KeyFrameNo INTEGER NOT NULL DEFAULT(1),SourceUuid TEXT,LogTypeId INTEGER,Severity INTEGER,data BLOB NOT NULL,action INTEGER NOT NULL);
CREATE INDEX IF NOT EXISTS dataminer_deltalog_index ON dataminer_deltalog(LogTypeId,Severity,KeyFrameNo);
CREATE TABLE IF NOT EXISTS dataminer_eventlog(CSN INTEGER PRIMARY KEY AUTOINCREMENT,SourceUuid TEXT,LogTypeId INTEGER,Severity INTEGER,data BLOB NOT NULL);
CREATE INDEX IF NOT EXISTS dataminer_eventlog_index ON dataminer_eventlog(LogTypeId,Severity);

CREATE TABLE IF NOT EXISTS ERAG1Connector_tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, identity_data BLOB NOT NULL, type INTEGER NOT NULL, state INTEGER NOT NULL, created INTEGER NOT NULL, data BLOB);
CREATE TABLE IF NOT EXISTS ERAG1Connector_modulestate (id INTEGER PRIMARY KEY AUTOINCREMENT, value NOT NULL);
CREATE TABLE IF NOT EXISTS ERAG1Connector_quarantine (id INTEGER PRIMARY KEY AUTOINCREMENT, count INTEGER NOT NULL, size INTEGER NOT NULL, state INTEGER NOT NULL, occurenceFirst INTEGER NOT NULL, occurenceLast INTEGER NOT NULL, hash BLOB NOT NULL, name TEXT NOT NULL, reason TEXT NOT NULL, infiltration TEXT NOT NULL, noexcludable INTEGER NOT NULL, threatname TEXT NOT NULL, threattype INTEGER NOT NULL, userreason INTEGER NOT NULL, threatflags INTEGER NOT NULL, norestorable INTEGER NOT NULL);

CREATE TABLE IF NOT EXISTS last_sent_policy (hash VARCHAR( 64 )  NOT NULL, sent DATETIME NOT NULL DEFAULT ( ( DATETIME( 'now' )  )  ),connectorType VARCHAR(60) NOT NULL);

CREATE TABLE IF NOT EXISTS multiagent_cached_logs (LogType VARCHAR( 80 )  PRIMARY KEY, Message BLOB);

CREATE TABLE IF NOT EXISTS client_task_resume_configuration (task_uuid TEXT PRIMARY KEY, resume_configuration BLOB NOT NULL );

CREATE TABLE IF NOT EXISTS authentication_device_users (device_user_uuid TEXT PRIMARY KEY, device_uuid TEXT NOT NULL, staff_user_uuid TEXT NOT NULL, user_sid TEXT NOT NULL, domain_sid TEXT, fingerprint BLOB NOT NULL);
CREATE TABLE IF NOT EXISTS authentication_credentials (entity_uuid TEXT NOT NULL, entity_type INTEGER NOT NULL, authenticator_type INTEGER NOT NULL, authenticator_value TEXT NOT NULL, PRIMARY KEY(entity_uuid, entity_type, authenticator_type));
CREATE TABLE IF NOT EXISTS authentication_session_tokens (entity_uuid TEXT NOT NULL, entity_type INTEGER NOT NULL, token_value BLOB NOT NULL, PRIMARY KEY(entity_uuid, entity_type));

CREATE TABLE IF NOT EXISTS authentication_collision_token (collision_token TEXT NOT NULL, first_collision INT NOT NULL DEFAULT(0), last_collision INT NOT NULL DEFAULT(0));

CREATE TRIGGER IF NOT EXISTS update_static_objects UPDATE OF object_version ON static_objects 
BEGIN
  DELETE FROM client_triggers_state WHERE (client_triggers_state.trigger_uuid = old.object_uuid) and (new.object_version != old.object_version);
END;

CREATE TABLE IF NOT EXISTS UESETSConnector_tasks (unique_id INTEGER PRIMARY KEY, task_id INTEGER NOT NULL, task_type INTEGER NOT NULL, task_state INTEGER NOT NULL, task_created INTEGER NOT NULL, task_data BLOB NOT NULL, mapper_id INTEGER NOT NULL, UNIQUE(task_id, task_type, mapper_id));

CREATE TABLE IF NOT EXISTS authentication_fluctuating_hw_fingerprint(hash TEXT PRIMARY KEY, hwf_blob BLOB NOT NULL);