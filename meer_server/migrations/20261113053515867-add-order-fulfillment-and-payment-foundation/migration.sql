BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "order_info" ADD COLUMN "fulfillmentMethod" text NOT NULL DEFAULT 'delivery'::text;
ALTER TABLE "order_info" ADD COLUMN "productsSubtotal" double precision;
ALTER TABLE "order_info" ADD COLUMN "deliveryFee" double precision NOT NULL DEFAULT 0;
ALTER TABLE "order_info" ADD COLUMN "pickupAddress" text;
ALTER TABLE "order_info" ADD COLUMN "commissionBaseAmount" double precision;
ALTER TABLE "order_info" ADD COLUMN "commissionRate" double precision;
ALTER TABLE "order_info" ADD COLUMN "commissionAmount" double precision;
ALTER TABLE "order_info" ADD COLUMN "paymentMethod" text NOT NULL DEFAULT 'manual'::text;
ALTER TABLE "order_info" ADD COLUMN "paymentStatus" text NOT NULL DEFAULT 'unpaid'::text;
ALTER TABLE "order_info" ALTER COLUMN "deliveryAddress" DROP NOT NULL;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "user" ADD COLUMN "offersDelivery" boolean NOT NULL DEFAULT false;
ALTER TABLE "user" ADD COLUMN "deliveryFee" double precision NOT NULL DEFAULT 0;

--
-- MIGRATION VERSION FOR meer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('meer', '20261113053515867-add-order-fulfillment-and-payment-foundation', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261113053515867-add-order-fulfillment-and-payment-foundation', "timestamp" = now();

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
