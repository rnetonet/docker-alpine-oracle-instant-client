FROM ghcr.io/astral-sh/uv:python3.12-alpine AS uv

FROM python:3.12-alpine

# Copy uv from the astral image
COPY --from=uv /usr/local/bin/uv /usr/local/bin/uv

# Set working directory
WORKDIR /app

# Download and configure Oracle Instant Client
# Using busybox wget (already available in Alpine) and unzip
RUN mkdir -p /usr/lib/instantclient && \
    cd /tmp && \
    wget -q https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linuxx64.zip && \
    unzip -q instantclient-basiclite.zip && \
    mv instantclient*/ /usr/lib/instantclient && \
    rm -f instantclient-basiclite.zip

# Set Oracle Instant Client environment variable
ENV LD_LIBRARY_PATH=/usr/lib/instantclient

# Copy project files
COPY pyproject.toml .
COPY main.py .

# Install Python dependencies using uv
# The oracledb package will use thin mode by default when lib_dir is not set
RUN uv pip install --system .

# Run the demo script
CMD ["python", "main.py"]
