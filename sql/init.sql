CREATE OR REPLACE PERSISTENT SECRET ducklake_r2_apse1 (
  -- TYPE s3,
  TYPE r2,
  PROVIDER credential_chain,
  ---- Ensure ~/.aws/config have profile `ducklake`
  -- PROFILE 'ducklake',
  ACCOUNT_ID '123456',
  ENDPOINT '123456.r2.cloudflarestorage.com'
);

INSTALL ducklake;
INSTALL postgres;

CREATE PERSISTENT SECRET IF NOT EXISTS postgres_secret (
    TYPE postgres,
    HOST 'ep-frosty-pooler.ap-southeast-1.aws.neon.tech',
    PORT 5432,
    DATABASE ducklake,
    USER 'neondb_owner'
    ---- Commented out, use PGPASSWORD environment variable
    -- , PASSWORD 'xxx'
);

-- Make sure that the database `ducklake` exists in PostgreSQL.
ATTACH 'ducklake:postgres:dbname=ducklake' AS ducklake
(
  DATA_PATH 'r2://ducklake-apse1/ducklake-data/'
  -- , READ_ONLY
);
USE ducklake;
