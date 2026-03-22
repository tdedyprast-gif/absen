# 🚀 Laravel Docker Setup (PHP 8.4 + Nginx + MySQL + phpMyAdmin)

This repository provides a complete **Dockerized Laravel development environment** using:

* **PHP 8.4 (FPM)**
* **Nginx**
* **MySQL 8**
* **phpMyAdmin**
* **Composer**

It is designed to help you spin up a fully working Laravel app with minimal setup.

---

# 📦 Prerequisites

Make sure you have the following installed:

* Docker
* Docker Compose (v2 recommended)
* Git

Check versions:

```bash
docker -v
docker compose version
```

---

# 📁 Project Structure

```
.
├── Dockerfile
├── docker-compose.yml
├── docker-entrypoint.sh
├── nginx/
│   └── default.conf
├── .env
├── vendor/
├── node_modules/
└── ...
```

---

# ⚡ Getting Started

## 1. Clone the Repository

```bash
git clone <your-repo-url>
cd <your-project-folder>
```

---

## 2. Create Laravel Project (if not already present)

If this repo is empty (no Laravel installed yet):

```bash
docker run --rm -v ${PWD}:/app composer create-project laravel/laravel .
```

---

## 3. Setup Environment File

Copy `.env.example` to `.env` if not already:

```bash
cp .env.example .env
```

---

## 4. Update Database Configuration

Inside `.env`, update:

```env
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel_db
DB_USERNAME=user
DB_PASSWORD=user123
```

---

## 5. Build and Start Containers

```bash
docker compose up -d --build
```

This will start:

* Laravel App (PHP-FPM)
* Nginx server
* MySQL database
* phpMyAdmin

---

## 6. Install Dependencies (if needed)

If vendor folder is missing:

```bash
docker compose exec app composer install
```

---

## 7. Generate Application Key

```bash
docker compose exec app php artisan key:generate
```

---

## 8. Run Migrations

```bash
docker compose exec app php artisan migrate
```

---

# 🌐 Access the Application

| Service     | URL                   |
| ----------- | --------------------- |
| Laravel App | http://localhost:8000 |
| phpMyAdmin  | http://localhost:8080 |

---

# 🛢️ Database Access

**Host:** mysql
**Port:** 3306
**Database:** laravel_db
**User:** user
**Password:** user123

> ⚠️ Port 3306 is exposed only for local dev tools (e.g., MySQL Workbench)

---

# 🧠 How It Works

### 🔹 App Container (PHP-FPM)

* Runs Laravel
* Installs dependencies via Composer
* Executes migrations automatically via entrypoint

### 🔹 Nginx

* Serves Laravel from `/public`
* Passes PHP requests to `app:9000`

### 🔹 MySQL

* Stores application data
* Uses Docker volume for persistence

### 🔹 phpMyAdmin

* Web UI for managing MySQL

---

# 🔧 Useful Commands

## View Logs

```bash
docker compose logs -f
```

## Access App Container

```bash
docker compose exec app bash
```

## Run Artisan Commands

```bash
docker compose exec app php artisan <command>
```

## Stop Containers

```bash
docker compose down
```

## Remove Everything (including volumes)

```bash
docker compose down -v
```

---

# 📂 File Permissions (Handled Automatically)

The entrypoint script ensures:

```bash
storage/
bootstrap/cache/
```

* Correct ownership (`www-data`)
* Proper permissions (`775`)

---

# 🔁 Rebuild Containers

If you change Dockerfile or dependencies:

```bash
docker compose up -d --build
```

---

# ⚠️ Common Issues & Fixes

### 1. Permission Issues

```bash
docker compose exec app chmod -R 775 storage bootstrap/cache
```

---

### 2. Composer Not Installed

Rebuild container:

```bash
docker compose build --no-cache
```

---

### 3. Database Not Connecting

* Ensure `DB_HOST=mysql`
* Wait for MySQL healthcheck
* Restart containers:

```bash
docker compose restart
```

---

### 4. Blank Page / 500 Error

Check logs:

```bash
docker compose logs app
```

---

# 🧪 Development Tips

* Use **hot reload** by editing files locally (volume mounted)
* No need to rebuild for code changes
* Only rebuild when:

  * Dockerfile changes
  * PHP extensions change

---

# 📦 Volumes

* `mysql_data` → persists database

---

# 🛑 Security Notes

* This setup is for **development only**
* Do NOT use default credentials in production
* Disable exposed MySQL port in production

---

# 🙌 Contribution

Feel free to fork, improve, and submit PRs!

---

# 📜 License

This project is open-source and free to use.

---

# 💡 Summary

With just a few commands:

```bash
docker compose up -d --build
```

You get a fully working Laravel development environment — no manual PHP, MySQL, or server setup required.

---
