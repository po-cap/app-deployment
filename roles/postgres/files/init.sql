-- 所有新的數據庫預設情況下都是從 template1 數據庫複製過來的。因此，修改 template1 
-- 的權限會引響所有將來從它創建的數據庫。
-- 當你建立了新的用戶，要讓使用者可以連接到你的 database：
--     CREATE ROLE new_role;
--     GRANT CONNECT,TEMPORARY ON DATABASE myapp TO new_role;
REVOKE CONNECT, TEMPORARY, CREATE ON DATABASE template1 FROM public;


-- 讓新建立的 user 都只能讀取和使用現有 DB 內的物件而不能建立新的物件
REVOKE CREATE ON SCHEMA public FROM public;
GRANT USAGE ON SCHEMA public TO public;

-- 讓新建立的 user 都只能讀取和使用現有 DB 內的物件
ALTER DEFAULT PRIVILEGES IN SCHEMA public REVOKE ALL ON TABLES FROM public;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO public;

--  預設情況下，讓使用者有 execute functions & procedures 的權利
ALTER DEFAULT PRIVILEGES IN SCHEMA public EXECUTE ON FUNCTIONS TO public;
ALTER DEFAULT PRIVILEGES IN SCHEMA public EXECUTE ON PROCEDURES TO public;

-- 建立 superuser like 的  user
CREATE USER doadmin WITH CREATEDB CREATEROLE PASSWORD 'admin';


----------------------------------------------------------------------
-- 以下，是建立一個給 app 用的 database 所需要的腳本
----------------------------------------------------------------------
CREATE DATABASE app;
REVOKE CONNECT, CREATE, TEMPORARY ON DATABASE app FROM PUBLIC;


CREATE USER app_user WITH PASSWORD 'your_secure_password';
GRANT CONNECT,TEMPORARY  ON DATABASE app TO app_user;