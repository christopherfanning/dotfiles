# WordPress Development

> Local-first workflow: Docker Compose for iteration, Multipass VM for production parity testing.

## Stack

| Layer | Tool |
|-------|------|
| PHP runtime | `wordpress:php8.3-fpm` (Docker) |
| Web server | Nginx (Docker) |
| Database | MariaDB 11 (Docker) |
| Local VM | Multipass (Ubuntu, mirrors Lightsail) |
| Image build | Packer (`iac/packer/wordpress-ami.pkr.hcl`) |
| Infra | OpenTofu (`iac/opentofu/`) |
| CLI | wp-cli |

## Starter template

```
~/code/wordpress-starter/
```

Copy this for each new project:

```bash
cp -r ~/code/wordpress-starter ~/code/my-new-site
cd ~/code/my-new-site
cp .env.example .env
# Edit .env — set DB password and generate WP salts
docker compose up -d
# → http://localhost:8080
```

## wp-cli

```bash
# Inside the running container
docker compose exec wordpress wp --info
docker compose exec wordpress wp plugin install woocommerce --activate
docker compose exec wordpress wp theme list
docker compose exec wordpress wp user list
docker compose exec wordpress wp search-replace 'old-domain.com' 'new-domain.com'
docker compose exec wordpress wp cache flush
docker compose exec wordpress wp cron event run --due-now
```

## Local → Production workflow

1. **Develop** with Docker Compose locally
2. **Test** in a Multipass Ubuntu VM (same OS as Lightsail): `multipass launch --cloud-init cloud-init.yml`
3. **Build AMI** with Packer: `packer build iac/packer/wordpress-ami.pkr.hcl`
4. **Deploy** with OpenTofu: `tofu apply`

## MariaDB access

```bash
docker compose exec db mariadb -u wpuser -p wordpress
```

## Notes

- `themes/` and `plugins/` directories are bind-mounted — edit them directly on the host in nvim
- `wp_data` volume persists the WordPress install — use `docker compose down -v` to fully reset
- Never commit `.env` — it contains DB passwords and WP salts
