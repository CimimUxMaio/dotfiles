---
name: mix
description: Assists with Elixir projects using Mix build tool, including Phoenix and Ecto commands for development, testing, and deployment
license: MIT
compatibility: opencode
metadata:
  category: build-tools
  languages: elixir
  frameworks: phoenix,ecto
---

## What I do

I help you work with Elixir projects using the Mix build tool. I provide guidance on:

- Project scaffolding and management
- Dependency resolution and management
- Running tests and generating coverage reports
- Database operations with Ecto (migrations, seeds, rollbacks)
- Phoenix web framework commands (generators, server management)
- Code formatting and quality checks
- Building production releases
- Interactive shell (IEx) usage

## When to use me

Use this skill when you are:

- Working in an Elixir project (`.ex` or `.exs` files present)
- Running Mix commands or asking about Elixir development tasks
- Setting up a new Phoenix web application
- Managing database schemas and migrations with Ecto
- Running tests or deploying Elixir applications
- Need to understand Mix command options and workflows

I'll automatically suggest appropriate Mix commands based on your task and provide explanations for complex operations.

---

## Core Mix Commands

### Project Management

**`mix new PROJECT_NAME`** - Creates a new Elixir project

```bash
mix new my_app
mix new my_app --sup          # Include supervision tree
mix new my_app --module MyApp # Specify module name
```

**`mix compile`** - Compiles the current project

```bash
mix compile
mix compile --force           # Force recompilation
mix compile --warnings-as-errors
```

**`mix clean`** - Deletes generated application files

```bash
mix clean
mix clean --deps              # Clean dependencies too
```

**`mix run`** - Runs the application

```bash
mix run
mix run --no-halt             # Keep application running
mix run -e "MyApp.hello()"    # Evaluate expression
mix run path/to/script.exs    # Run a script
```

### Dependency Management

**`mix deps.get`** - Fetches all dependencies defined in `mix.exs`

```bash
mix deps.get
mix deps.get --only prod      # Only production deps
```

Use after cloning a project or adding new dependencies.

**`mix deps.update DEPENDENCY`** - Updates dependencies

```bash
mix deps.update --all         # Update all dependencies
mix deps.update phoenix       # Update specific dependency
```

**`mix deps`** - Lists all dependencies and their status

```bash
mix deps
mix deps --all                # Include indirect dependencies
```

**`mix hex.outdated`** - Shows outdated Hex dependencies

```bash
mix hex.outdated
mix hex.outdated --all        # Include all levels
```

### Testing

**`mix test`** - Runs the test suite

```bash
mix test                                    # Run all tests
mix test test/my_app_test.exs              # Run specific file
mix test test/my_app_test.exs:42           # Run specific line
mix test --only focus                       # Run tagged tests
mix test --exclude integration              # Exclude tagged tests
mix test --trace                            # Detailed output
mix test --stale                            # Run stale tests only
mix test --failed                           # Run previously failed tests
mix test --cover                            # Generate coverage report
mix test --max-failures 5                   # Stop after N failures
```

Use frequently during development, before committing code, and in CI/CD pipelines.

### Code Quality

**`mix format`** - Formats code according to Elixir style guidelines

```bash
mix format                                  # Format all files
mix format lib/my_file.ex                   # Format specific file
mix format --check-formatted                # Check if formatted
```

Use before committing code, as a pre-commit hook, or in CI/CD.

**`mix credo`** - Static code analysis (requires `credo` dependency)

```bash
mix credo
mix credo --strict                          # Strict mode
mix credo list                              # List issues
```

**`mix dialyzer`** - Type checking (requires `dialyxir` dependency)

```bash
mix dialyzer
mix dialyzer --format short
```

### Documentation

**`mix docs`** - Generates HTML documentation (requires `ex_doc`)

```bash
mix docs
mix docs --formatter html
```

---

## Phoenix Framework Commands

Phoenix is the most popular web framework for Elixir.

### Project Generation

**`mix phx.new PROJECT_NAME`** - Creates a new Phoenix application

```bash
mix phx.new my_app
mix phx.new my_app --no-ecto              # Without database
mix phx.new my_app --no-html              # API only
mix phx.new my_app --no-assets            # No asset pipeline
mix phx.new my_app --database postgres    # Specify database
mix phx.new my_app --live                 # With LiveView
mix phx.new my_app --binary-id            # Use UUIDs
mix phx.new my_app --install              # Install deps automatically
```

### Development Server

**`mix phx.server`** - Starts the Phoenix development server

```bash
mix phx.server
PORT=4001 mix phx.server                  # Custom port
MIX_ENV=prod mix phx.server               # Production mode
```

**`iex -S mix phx.server`** - Starts server with interactive shell

```bash
iex -S mix phx.server
```

Use for debugging while the server runs and inspecting application state.

### Code Generators

**`mix phx.gen.html`** - Generates HTML context, controller, views, and templates

```bash
mix phx.gen.html Accounts User users name:string email:string age:integer
mix phx.gen.html Blog Post posts title:string body:text published:boolean
```

Use for scaffolding CRUD operations and quickly prototyping features.

**`mix phx.gen.json`** - Generates JSON context and API endpoints

```bash
mix phx.gen.json Accounts User users name:string email:string
```

Use for building REST APIs and mobile app backends.

**`mix phx.gen.context`** - Generates a context with functions around an Ecto schema

```bash
mix phx.gen.context Accounts User users name:string email:string:unique
```

**`mix phx.gen.schema`** - Generates an Ecto schema and migration

```bash
mix phx.gen.schema Accounts.User users name:string email:string
mix phx.gen.schema Blog.Post posts title:string user_id:references:users
```

**`mix phx.gen.live`** - Generates LiveView components for real-time features

```bash
mix phx.gen.live Accounts User users name:string email:string
```

Use for building real-time interfaces and interactive dashboards.

**`mix phx.gen.auth`** - Generates authentication system (Phoenix 1.5+)

```bash
mix phx.gen.auth Accounts User users
mix phx.gen.auth Accounts User users --web Admin
```

Use for adding user authentication, login/logout, and password reset.

**`mix phx.gen.channel`** - Generates a Phoenix channel for WebSocket communication

```bash
mix phx.gen.channel Room
```

**`mix phx.gen.cert`** - Generates self-signed SSL certificate for development

```bash
mix phx.gen.cert
```

### Routes and Information

**`mix phx.routes`** - Lists all routes in the application

```bash
mix phx.routes
mix phx.routes MyAppWeb.Router         # Specific router
```

Use for debugging routing issues and understanding application structure.

**`mix phx.digest`** - Digests and compresses static files for production

```bash
mix phx.digest
mix phx.digest.clean --all              # Clean old digested files
```

---

## Ecto Database Commands

Ecto is Elixir's database wrapper and query generator.

### Database Management

**`mix ecto.create`** - Creates the database for the repository

```bash
mix ecto.create
mix ecto.create -r MyApp.Repo           # Specific repo
```

Use for initial project setup and after cloning a project.

**`mix ecto.drop`** - Drops the database

```bash
mix ecto.drop
mix ecto.drop -r MyApp.Repo
mix ecto.drop --force                   # Skip confirmation
```

**`mix ecto.reset`** - Drops, creates, and migrates the database

```bash
mix ecto.reset
```

Use for quick database reset in development.

### Migrations

**`mix ecto.gen.migration NAME`** - Generates a new migration file

```bash
mix ecto.gen.migration create_users
mix ecto.gen.migration add_email_to_users
```

Use when creating new tables or modifying existing schemas.

**`mix ecto.migrate`** - Runs pending migrations

```bash
mix ecto.migrate
mix ecto.migrate --step 1               # Run one migration
mix ecto.migrate --to 20240101120000    # Migrate to version
mix ecto.migrate -r MyApp.Repo          # Specific repo
```

**`mix ecto.rollback`** - Rolls back migrations

```bash
mix ecto.rollback
mix ecto.rollback --step 1              # Rollback one migration
mix ecto.rollback --to 20240101120000   # Rollback to version
mix ecto.rollback --all                 # Rollback all migrations
```

Use for undoing migration mistakes and testing rollback logic.

**`mix ecto.migrations`** - Lists all migrations and their status

```bash
mix ecto.migrations
mix ecto.migrations -r MyApp.Repo
```

### Seeds and Data

**Running seeds** - Populates initial data

```bash
mix run priv/repo/seeds.exs
```

Use for populating initial data and setting up development environment.

---

## Release and Deployment

**`mix release`** - Builds a production release

```bash
mix release
mix release --overwrite                 # Overwrite existing
MIX_ENV=prod mix release
```

Use for building production deployments and creating distributable packages.

**`mix release.init`** - Generates release configuration files

```bash
mix release.init
```

---

## Interactive Shell

**`iex -S mix`** - Starts an interactive Elixir shell with the project loaded

```bash
iex -S mix
iex -S mix run                          # Run and stay in shell
```

Use for testing functions interactively, debugging, and exploring modules.

**Common IEx commands:**
```elixir
recompile()                              # Recompile changed files
h MyModule.my_function                   # Get help
i variable                               # Inspect variable
c "path/to/file.ex"                     # Compile file
```

---

## Environment Variables

Common environment variables used with Mix:

- `MIX_ENV` - Sets the environment (dev, test, prod)
- `PORT` - Sets the port for Phoenix server
- `DATABASE_URL` - Database connection string
- `SECRET_KEY_BASE` - Phoenix secret key

**Usage:**
```bash
MIX_ENV=prod mix compile
MIX_ENV=test mix test
PORT=4001 mix phx.server
```

---

## Best Practices and Common Workflows

### Development Workflow

**Project Setup:**
```bash
mix phx.new my_app
cd my_app
mix deps.get
mix ecto.create
mix ecto.migrate
```

**Daily Development:**
```bash
mix format                           # Format code
mix test                             # Run tests
mix phx.server                       # Start server
```

**Before Committing:**
```bash
mix format --check-formatted
mix test
mix credo --strict                   # If using credo
```

### Generator Field Types

When using generators (`phx.gen.html`, `phx.gen.json`, etc.):

```bash
# Basic types
name:string
age:integer
price:decimal
active:boolean
birth_date:date
published_at:datetime
profile:text

# References
user_id:references:users
post_id:references:posts

# Unique constraint
email:string:unique

# Array type (Postgres)
tags:array:string

# JSON type
metadata:map
```

### Database Reset Workflow

```bash
mix ecto.reset && mix run priv/repo/seeds.exs
```

### Quick Project Bootstrap

```bash
mix phx.new my_app && cd my_app && mix deps.get && mix ecto.setup && mix phx.server
```

---

## Troubleshooting Common Issues

**Compilation errors after dependency update:**
```bash
mix deps.clean --all
mix deps.get
mix compile
```

**Port already in use:**
```bash
lsof -ti:4000 | xargs kill -9
# Or use different port:
PORT=4001 mix phx.server
```

**Database connection issues:**
```bash
mix ecto.drop
mix ecto.create
mix ecto.migrate
```

**Stale beam files:**
```bash
mix clean
mix compile
```

**Test database issues:**
```bash
MIX_ENV=test mix ecto.reset
```

---

## Example Workflows

### Workflow 1: New Phoenix Project

When user says: "Create a new Phoenix app called blog"

1. Run: `mix phx.new blog --install`
2. Run: `cd blog && mix ecto.create`
3. Suggest: `mix phx.server` to start development

### Workflow 2: Add CRUD Resource

When user says: "Add a Post resource with title and content"

1. Run: `mix phx.gen.html Blog Post posts title:string content:text`
2. Remind: Add route to `router.ex`
3. Run: `mix ecto.migrate`
4. Suggest: `mix phx.routes` to see new routes

### Workflow 3: Database Migration

When user says: "Add email field to users table"

1. Run: `mix ecto.gen.migration add_email_to_users`
2. Edit migration file with `add :email, :string`
3. Run: `mix ecto.migrate`
4. Update schema file if needed

### Workflow 4: Running Tests

When user says: "Run tests for the accounts module"

1. Run: `mix test test/my_app/accounts_test.exs`
2. If failures, analyze and fix
3. Run: `mix test --cover` to check coverage

### Workflow 5: Production Deployment

When user says: "Build for production"

1. Run: `MIX_ENV=prod mix deps.get --only prod`
2. Run: `MIX_ENV=prod mix compile`
3. Run: `MIX_ENV=prod mix assets.deploy`
4. Run: `MIX_ENV=prod mix release`
5. Provide deployment instructions

---

## Quick Command Reference

### Essential Commands

| Command | Purpose |
|---------|---------|
| `mix help` | List all available tasks |
| `mix compile` | Compile project |
| `mix test` | Run tests |
| `mix format` | Format code |
| `mix deps.get` | Fetch dependencies |
| `iex -S mix` | Interactive shell |

### Phoenix Commands

| Command | Purpose |
|---------|---------|
| `mix phx.new APP` | New Phoenix app |
| `mix phx.server` | Start dev server |
| `mix phx.routes` | List routes |
| `mix phx.gen.html` | Generate HTML resource |
| `mix phx.gen.json` | Generate API resource |
| `mix phx.gen.live` | Generate LiveView |

### Ecto Commands

| Command | Purpose |
|---------|---------|
| `mix ecto.create` | Create database |
| `mix ecto.drop` | Drop database |
| `mix ecto.migrate` | Run migrations |
| `mix ecto.rollback` | Rollback migrations |
| `mix ecto.reset` | Reset database |
| `mix ecto.gen.migration` | Generate migration |

---

## When OpenCode Agents Should Use This Skill

Agents should automatically load this skill when:

1. Working in a directory with a `mix.exs` file
2. User mentions Mix commands explicitly
3. Files with `.ex` or `.exs` extensions are present
4. User asks about Phoenix or Ecto operations
5. User needs to run tests, migrations, or server in Elixir context
6. User is setting up a new Elixir project

When this skill is active, prefer Mix commands over manual operations, verify Phoenix/Ecto availability before suggesting framework commands, use appropriate environment (MIX_ENV) based on context, and provide command explanations for complex operations.

---

## Additional Resources

- **Mix Documentation:** https://hexdocs.pm/mix/Mix.html
- **Phoenix Documentation:** https://hexdocs.pm/phoenix/overview.html
- **Ecto Documentation:** https://hexdocs.pm/ecto/Ecto.html
- **Elixir Documentation:** https://elixir-lang.org/docs.html
- **Elixir Forum:** https://elixirforum.com/
