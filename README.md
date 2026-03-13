# PostgreSQL Binaries

This repo provides build rules to compile PostgreSQL binaries from source for the [Please](https://please.build) build system.

Additionally, pre-built PostgreSQL Binary artifacts are available for download from the GitHub release assets.

## Pre-Built Binaries: Supported Versions

| PostgreSQL Version | Supported OS | Supported Architecture | Base | AI |
|---------------------|--------------|-------------------------|------|----|
| 18.0               | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-18.0-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-18.0-linux_x86_64.tar.gz) |
| 17.6               | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-17.6-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-17.6-linux_x86_64.tar.gz) |
| 17.5               | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-17.5-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-17.5-linux_x86_64.tar.gz) |
| 17.4               | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-17.4-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-17.4-linux_x86_64.tar.gz) |
| 17.3               | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-17.3-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-17.3-linux_x86_64.tar.gz) |
| 17.2               | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-17.2-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-17.2-linux_x86_64.tar.gz) |
| 17.1               | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-17.1-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-17.1-linux_x86_64.tar.gz) |
| 17.0               | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-17.0-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-17.0-linux_x86_64.tar.gz) |
| 16.10              | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-16.10-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-16.10-linux_x86_64.tar.gz) |
| 16.9               | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-16.9-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-16.9-linux_x86_64.tar.gz) |
| 16.8               | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-16.8-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-16.8-linux_x86_64.tar.gz) |
| 16.7               | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-16.7-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-16.7-linux_x86_64.tar.gz) |
| 16.6               | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-16.6-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-16.6-linux_x86_64.tar.gz) |
| 16.5               | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-16.5-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-16.5-linux_x86_64.tar.gz) |
| 16.4               | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-16.4-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-16.4-linux_x86_64.tar.gz) |
| 16.3               | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-16.3-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-16.3-linux_x86_64.tar.gz) |
| 16.2               | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-16.2-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-16.2-linux_x86_64.tar.gz) |
| 16.1               | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-16.1-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-16.1-linux_x86_64.tar.gz) |
| 16.0               | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-16.0-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-16.0-linux_x86_64.tar.gz) |
| 15.14              | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-15.14-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-15.14-linux_x86_64.tar.gz) |
| 14.19              | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-14.19-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-14.19-linux_x86_64.tar.gz) |
| 13.22              | Linux        | x86_64                 | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-13.22-linux_x86_64.tar.gz) | [Download](https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-ai-13.22-linux_x86_64.tar.gz) |

## AI Binaries

The **AI** variants (`psql-ai-*`) include everything in the base binary plus the following extensions, compiled from source and ready to use with `CREATE EXTENSION`:

| Extension | Description | Version |
|-----------|-------------|---------|
| [pgvector](https://github.com/pgvector/pgvector) | Vector similarity search for embeddings (L2, inner product, cosine distance) | 0.8.0 (0.8.2 for PG18) |
| [Apache AGE](https://github.com/apache/age) | Graph database extension — openCypher queries on top of PostgreSQL | 1.5.0–1.7.0 (varies by PG major) |

All PostgreSQL [contrib modules](https://www.postgresql.org/docs/current/contrib.html) (hstore, pg_trgm, uuid-ossp, etc.) are also included in both base and AI binaries.

### Enabling extensions

```sql
CREATE EXTENSION vector;         -- pgvector
CREATE EXTENSION age;            -- Apache AGE
LOAD 'age';                      -- AGE also requires LOAD
SET search_path = ag_catalog, "$user", public;
```

---

## Basic Usage

### Option 1: Use as a Please Plugin

1. **Add the plugin to your project**

   In `plugins/BUILD`:
   ```python
   plugin_repo(
       name = "postgres",
       owner = "becomeliminal",
       revision = "v0.0.5",
   )
   ```

2. **Update your `.plzconfig`**

   Add the following section:
   ```ini
   [Plugin "postgres"]
   Target = //plugins:postgres
   ```

3. **Use the PostgreSQL build rules in your project**

   After setting up the plugin, you can use the `postgres` build rule to include PostgreSQL binaries in your project. Example:
   ```python
   subinclude("///postgres//build_defs:postgres")

   postgres(
       name = "psql",
       version = "18.0",
       visibility = ["PUBLIC"],
   )
   ```

   This will build the specified version of PostgreSQL binaries from source.

4. **Build with AI extensions** (pgvector + Apache AGE)

   ```python
   postgres_ai(
       name = "psql_ai",
       version = "17.6",
       visibility = ["PUBLIC"],
   )
   ```

#### Configuring Custom Build Flags

The `postgres` build definition allows you to customize the build process by passing flags to the `configure` script. This is useful if you need to enable or disable specific PostgreSQL features or specify custom installation paths.

##### Example
You can pass `configure_flags` to the build rule like this:
```python
postgres(
    name = "psql",
    version = "18.0",
    configure_flags = ["--enable-debug", "--with-openssl"],
    visibility = ["PUBLIC"],
)
```

Make sure to pass the flags as a list in the format: `["--key", "value", "--key", "value"]`.

For a detailed explanation of the available configuration options, see the [PostgreSQL Documentation on Configure Options](https://www.postgresql.org/docs/current/install-make.html#CONFIGURE-OPTIONS).

---

#### Required Tools and Libraries

Building PostgreSQL from source requires the following tools and libraries to be installed on your system:

**Required Tools:**
- `gcc`
- `make`
- `automake`
- `autoconf`
- `flex`
- `bison`
- `perl`
- `pkg-config`

**Required Libraries:**
- `libicu-dev`
- `libreadline-dev`

---

#### Installing Dependencies with Please

You can use the provided setup target to install the required tools and libraries into your environment:
```bash
plz run ///postgres//:setup
```

This will ensure all dependencies are available in the path, allowing the `postgres` binary to compile from source successfully.

---

### Option 2: Use Pre-built Binaries (Recommended for RBE)

If you prefer not to build PostgreSQL from source, use the `postgres_binary` rule to download pre-built binaries. This is much faster, especially for Remote Build Execution (RBE) where workers just download ~10MB instead of compiling for 5-10 minutes.

```python
subinclude("///postgres//build_defs:postgres")

postgres_binary(
    name = "postgres",
    version = "17.2",
    visibility = ["PUBLIC"],
)
```

The `postgres_binary` rule provides the same output structure as `postgres` (`bin`, `lib`, `include`, `share`), so it's a drop-in replacement.

For the AI variant with pgvector and Apache AGE:

```python
subinclude("///postgres//build_defs:postgres")

postgres_ai_binary(
    name = "postgres_ai",
    version = "17.6",
    visibility = ["PUBLIC"],
)
```

#### Manual Download

Alternatively, you can directly download pre-built binaries from the [GitHub release assets](https://github.com/becomeliminal/postgres/releases):

```python
remote_file(
    name = "psql",
    url = "https://github.com/becomeliminal/postgres/releases/download/v0.0.5/psql-18.0-linux_x86_64.tar.gz",
    hashes = ["<hash of the file>"], # Optional
)
```

You can find pre-built binaries for supported OS and architecture combinations in the [release page](https://github.com/becomeliminal/postgres/releases).

---

## Notes

You may need to pass the `-L /path/to/psql/share` flag to `initdb`.

---

## Releases

You can find all available versions and corresponding binaries on the [releases page](https://github.com/becomeliminal/postgres/releases).

---

## Need Additional Pre-Built Binaries?

If you need a pre-built binary for a specific PostgreSQL version, operating system, or architecture that is not currently included in the release assets, feel free to reach out or [open an issue](https://github.com/becomeliminal/postgres/issues).

We're happy to consider adding additional prebuilt binaries to future releases!
