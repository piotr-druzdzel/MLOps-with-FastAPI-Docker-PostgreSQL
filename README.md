# MLOps Test

## Introduction

This project implements a FastAPI application to interact with the arxiv.org API and a PostgreSQL database. The application provides three endpoints:

1. `/arxiv/` - Scrape the arxiv.org API and store results in a local PostgreSQL database.
2. `/queries/` - Fetch queries from the PostgreSQL database based on query start and end times.
3. `/results/` - Provide all query results stored in JSON format with pagination.

## Requirements

- Docker
- Docker Compose

## Setup

1. Clone the repository.
2. Create a `.env` file in the root directory with the following content:

