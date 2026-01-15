# docker-alpine-oracle-instant-client
Minimal Docker (Alpine) image with support for Oracle Instant Client.

## Features

- Based on Python 3.12 Alpine Linux
- Oracle Instant Client Basic Lite configured  
- Uses `uv` for fast Python package installation
- Python `oracledb` package configured for thin mode (no lib_dir setting required)

## Usage

Build the image:
```bash
docker build -t oracle-instant-client .
```

Run the demo:
```bash
docker run oracle-instant-client
```

## Files

- `Dockerfile` - Multi-stage build that copies uv from Astral image, downloads Oracle Instant Client
- `pyproject.toml` - Python project dependencies (oracledb)
- `main.py` - Demo script that loads oracledb and prints success

## Notes

The `oracledb` package version 2.x+ supports "thin mode" which connects directly to Oracle databases without requiring the Oracle Instant Client libraries. However, this setup includes the Instant Client for compatibility and future thick mode usage. The `lib_dir` parameter is not set in the Python code, allowing oracledb to auto-detect the configuration from the `LD_LIBRARY_PATH` environment variable.

