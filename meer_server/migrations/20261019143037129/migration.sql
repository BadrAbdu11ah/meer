BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "product" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "order_item" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "order_info" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "user_profile" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "order_info" (
    "id" bigserial PRIMARY KEY,
    "customerId" bigint NOT NULL,
    "sellerId" bigint NOT NULL,
    "driverId" bigint,
    "status" text NOT NULL,
    "totalAmount" double precision NOT NULL,
    "deliveryAddress" text NOT NULL,
    "deliveryLatitude" double precision,
    "deliveryLongitude" double precision,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "order_item" (
    "id" bigserial PRIMARY KEY,
    "orderId" bigint NOT NULL,
    "productId" bigint NOT NULL,
    "quantity" bigint NOT NULL,
    "price" double precision NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "product" (
    "id" bigserial PRIMARY KEY,
    "sellerId" bigint NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "price" double precision NOT NULL,
    "imageUrl" text,
    "isAvailable" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user" (
    "id" bigserial PRIMARY KEY,
    "fullName" text NOT NULL,
    "phone" text NOT NULL,
    "role" text NOT NULL,
    "address" text,
    "latitude" double precision,
    "longitude" double precision,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "order_info"
    ADD CONSTRAINT "order_info_fk_0"
    FOREIGN KEY("customerId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "order_info"
    ADD CONSTRAINT "order_info_fk_1"
    FOREIGN KEY("sellerId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "order_info"
    ADD CONSTRAINT "order_info_fk_2"
    FOREIGN KEY("driverId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "order_item"
    ADD CONSTRAINT "order_item_fk_0"
    FOREIGN KEY("orderId")
    REFERENCES "order_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "order_item"
    ADD CONSTRAINT "order_item_fk_1"
    FOREIGN KEY("productId")
    REFERENCES "product"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "product"
    ADD CONSTRAINT "product_fk_0"
    FOREIGN KEY("sellerId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR meer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('meer', '20261019143037129', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261019143037129', "timestamp" = now();

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
