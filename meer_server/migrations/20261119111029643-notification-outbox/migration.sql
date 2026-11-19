BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "notification_outbox" (
    "id" bigserial PRIMARY KEY,
    "recipientProfileId" bigint NOT NULL,
    "installationId" text NOT NULL,
    "orderId" bigint NOT NULL,
    "event" text NOT NULL,
    "title" text NOT NULL,
    "body" text NOT NULL,
    "data" json NOT NULL,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "attemptCount" bigint NOT NULL DEFAULT 0,
    "nextAttemptAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lockedAt" timestamp without time zone,
    "lastError" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "sentAt" timestamp without time zone,
    "dedupeKey" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "notification_outbox_dedupe_key_idx" ON "notification_outbox" USING btree ("dedupeKey");
CREATE INDEX "notification_outbox_status_next_attempt_idx" ON "notification_outbox" USING btree ("status", "nextAttemptAt");


--
-- MIGRATION VERSION FOR meer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('meer', '20261119111029643-notification-outbox', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261119111029643-notification-outbox', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20260824182343939', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182343939', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
