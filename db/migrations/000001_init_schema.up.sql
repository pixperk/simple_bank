CREATE TABLE "accounts" (
  "id" BIGSERIAL PRIMARY KEY,
  "owner" VARCHAR NOT NULL,
  "balance" BIGINT NOT NULL,
  "currency" VARCHAR NOT NULL,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE "entries" (
  "id" BIGSERIAL PRIMARY KEY,
  "account_id" BIGINT NOT NULL,
  "amount" BIGINT NOT NULL,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT fk_entries_account FOREIGN KEY ("account_id") REFERENCES "accounts" ("id") ON DELETE CASCADE
);

CREATE TABLE "transfers" (
  "id" BIGSERIAL PRIMARY KEY,
  "from_account_id" BIGINT NOT NULL,
  "to_account_id" BIGINT NOT NULL,
  "amount" BIGINT NOT NULL,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT fk_transfers_from FOREIGN KEY ("from_account_id") REFERENCES "accounts" ("id") ON DELETE CASCADE,
  CONSTRAINT fk_transfers_to FOREIGN KEY ("to_account_id") REFERENCES "accounts" ("id") ON DELETE CASCADE
);

CREATE INDEX idx_accounts_owner ON "accounts" ("owner");
CREATE INDEX idx_entries_account_id ON "entries" ("account_id");
CREATE INDEX idx_transfers_from_account_id ON "transfers" ("from_account_id");
CREATE INDEX idx_transfers_to_account_id ON "transfers" ("to_account_id");

COMMENT ON COLUMN "entries"."amount" IS 'Can be positive or negative';
COMMENT ON COLUMN "transfers"."amount" IS 'Must be positive';
