BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "user_profile" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_profile" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "fullName" text NOT NULL,
    "phoneNumber" text NOT NULL,
    "role" text NOT NULL,
    "address" text,
    "latitude" double precision,
    "longitude" double precision,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION RESTORE FOREIGN KEY
--
ALTER TABLE ONLY "order_info"
    ADD CONSTRAINT "order_info_fk_0"
    FOREIGN KEY("customerId")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "order_info"
    ADD CONSTRAINT "order_info_fk_1"
    FOREIGN KEY("sellerId")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "order_info"
    ADD CONSTRAINT "order_info_fk_2"
    FOREIGN KEY("driverId")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "product"
    ADD CONSTRAINT "product_fk_0"
    FOREIGN KEY("sellerId")
    REFERENCES "user_profile"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR meer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('meer', '20261012075155251', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261012075155251', "timestamp" = now();

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
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
