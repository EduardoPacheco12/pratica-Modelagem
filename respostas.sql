--Criando o banco de dados

CREATE DATABASE "myDbPractice";

--Criando a tabela "states"

CREATE TABLE "states" (
	"id" SERIAL NOT NULL PRIMARY KEY,
	"name" TEXT NOT NULL
);

--Criando a tabela "cities"

CREATE TABLE "cities" (
	"id" SERIAL NOT NULL PRIMARY KEY,
	"name" TEXT NOT NULL,
	"stateId" INTEGER REFERENCES states(id)
);

--Criando a tabela "customers"

CREATE TABLE "customers" (
	"id" SERIAL NOT NULL PRIMARY KEY,
	"fullName" TEXT NOT NULL,
	"cpf" VARCHAR(11) NOT NULL UNIQUE,
	"email" TEXT NOT NULL UNIQUE,
	"password" TEXT NOT NULL
);

--Criando a tabela "customerPhones"

CREATE TYPE "phoneTypes" AS ENUM ('landline', 'mobile');

CREATE TABLE "customerPhones" (
	"id" SERIAL NOT NULL PRIMARY KEY,
	"customerId" INTEGER REFERENCES customers(id),
	"number" TEXT NOT NULL,
	"type" "phoneTypes" NOT NULL
);

--Criando a tabela "customerAddresses"

CREATE TABLE "customerAddresses" (
	"id" SERIAL NOT NULL PRIMARY KEY,
	"customerId" INTEGER REFERENCES customers(id),
	"street" TEXT NOT NULL,
	"number" TEXT NOT NULL,
	"complement" TEXT,
	"postalCode" TEXT NOT NULL UNIQUE,
	"cityId" INTEGER REFERENCES cities(id)
);

--Criando a tabela "bankAccount"

CREATE TABLE "bankAccount" (
	"id" SERIAL NOT NULL PRIMARY KEY,
	"customerId" INTEGER REFERENCES customers(id),
	"accountNumber" TEXT NOT NULL UNIQUE,
	"agency" TEXT NOT NULL,
	"openDate" TIMESTAMP NOT NULL DEFAULT NOW(),
	"closeDate" TIMESTAMP DEFAULT NULL
);

--Criando a tabela "transactions"

CREATE TYPE "transactionTypes" AS ENUM ('deposit', 'withdraw');

CREATE TABLE "transactions" (
	"id" SERIAL NOT NULL PRIMARY KEY,
	"bankAccountId" INTEGER REFERENCES "bankAccount"(id),
	"amount" TEXT NOT NULL,
	"type" "transactionTypes" NOT NULL,
	"time" TIMESTAMP NOT NULL DEFAULT NOW(),
	"description" TEXT,
	"cancelled" BOOLEAN NOT NULL DEFAULT false
);

--Criando a tabela "creditCards"

CREATE TABLE "creditCards" (
	"id" SERIAL NOT NULL PRIMARY KEY,
	"bankAccountId" INTEGER REFERENCES "bankAccount"(id),
	"name" TEXT NOT NULL,
	"number" TEXT NOT NULL,
	"securityCode" TEXT NOT NULL,
	"expirationMonth" INTEGER NOT NULL,
	"expirationYear" INTEGER NOT NULL,
	"password" TEXT NOT NULL,
	"limit" INTEGER DEFAULT NULL
);