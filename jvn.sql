--
--  JVN Vulnerability Infomation Managed System
--
--  hidekuno@gmail.com
--

-- ========================================================================
-- オブジェクトのクリア
-- ========================================================================
DROP TABLE IF EXISTS jvn_vendor;
DROP TABLE IF EXISTS jvn_product;
DROP TABLE IF EXISTS jvn_product_work;
DROP TABLE IF EXISTS jvn_vulnerability;
DROP TABLE IF EXISTS jvn_vulnerability_detail;
DROP TABLE IF EXISTS jvn_vulnerability_work;
DROP TABLE IF EXISTS jvn_vulnerability_detail_work;
DROP TABLE IF EXISTS jvn_account;

DROP INDEX IF EXISTS jvn_vendor_idx_1;
DROP INDEX IF EXISTS jvn_product_idx_1;
DROP INDEX IF EXISTS jvn_product_idx_2;
DROP INDEX IF EXISTS jvn_vulnerability_idx_1;
DROP INDEX IF EXISTS jvn_vulnerability_detail_idx_1;
DROP INDEX IF EXISTS jvn_vulnerability_detail_idx_2;
-- ========================================================================
-- Quattro テーブル作成(マスタ及びトランザクション系)
-- ========================================================================
-- ---------------------  ベンダ情報 -------------------------
CREATE TABLE    jvn_vendor (
  vid           int          NOT NULL,
  vname         text         NOT NULL,
  cpe           varchar(255) NOT NULL
);
CREATE TABLE    jvn_vendor_work (
  vid           int          NOT NULL,
  vname         text         NOT NULL,
  cpe           varchar(255) NOT NULL
);
-- ---------------------  製品情報 -------------------------
CREATE TABLE jvn_product (
  pid           int          NOT NULL,
  pname         text         NOT NULL,
  cpe           varchar(255) NOT NULL,
  vid           int          NOT NULL,
  fs_manage     varchar(16)  NOT NULL,
  edit          smallint
);
-- ---------------------  製品情報(ワークテーブル) ---------
CREATE TABLE jvn_product_work (
  pid           int,
  pname         text,
  cpe           varchar(255),
  vid           int
);

-- --------------------- 脆弱性情報 -------------------------
CREATE TABLE jvn_vulnerability (
  identifier    varchar(32)      NOT NULL PRIMARY KEY,
  title         text             NOT NULL,
  link          varchar(255)     NOT NULL,
  description   text             NOT NULL,
  issued_date   timestamp        NOT NULL,
  modified_date timestamp        NOT NULL,
  ticket_modified_date timestamp
);
-- --------------------- 脆弱性情報(ワークテーブル) --------
CREATE TABLE jvn_vulnerability_work (
  identifier    varchar(32),
  title         text,
  link          varchar(255),
  description   text,
  issued_date   timestamp,
  modified_date timestamp
);

-- --------------------- 脆弱性情報詳細 --------------------
CREATE TABLE jvn_vulnerability_detail (
  identifier    varchar(32)     NOT NULL,
  cpe           varchar(255)    NOT NULL
);
-- --------------------- 脆弱性情報詳細(ワークテーブル) ---
CREATE TABLE jvn_vulnerability_detail_work (
  identifier    varchar(32),
  cpe           varchar(255)
);
-- --------------------- アカウント情報 --------------------
CREATE TABLE jvn_account (
  user_id       varchar(32)    NOT NULL PRIMARY KEY,
  passwd        varchar(32),
  user_name     varchar(255),
  email         varchar(255),
  department    varchar(32),
  privs         varchar(8)
);

CREATE INDEX jvn_vendor_idx_1               ON jvn_vendor  (vid);
CREATE INDEX jvn_vendor_idx_2               ON jvn_vendor  (cpe);
CREATE INDEX jvn_product_idx_1              ON jvn_product (pid);
CREATE INDEX jvn_product_idx_2              ON jvn_product (cpe);
CREATE INDEX jvn_vulnerability_idx_1        ON jvn_vulnerability (modified_date);
CREATE INDEX jvn_vulnerability_detail_idx_1 ON jvn_vulnerability_detail (identifier);
CREATE INDEX jvn_vulnerability_detail_idx_2 ON jvn_vulnerability_detail (cpe);

delete from jvn_account;
insert into jvn_account values
('kunohi_admin','', 'くの　あどみん','hidekuno@gmail.com','開発部','admin'),
('kunohi_user' ,'', 'くの　ゆーざー','hidekuno@gmail.com','開発部','user');