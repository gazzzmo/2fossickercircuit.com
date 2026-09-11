# 2 Fossicker Circuit — Property Website

Single-page marketing website for the sale of 2 Fossicker Circuit, Springfield QLD 4300.
Live at https://2fossickercircuit.com.

- `index.html` — the entire site (no build step, no dependencies)
- `deploy.sh` — uploads the site to the web host over FTP(S)
- Content sourced from the realestate.com.au listing (Property ID 152030564),
  marketed by Clare May Real Estate, Camira.

## Deployment (FTP)

The site is a single static file. Deployment is a plain FTP upload to the web host.

Prerequisites, supplied either in the environment or a gitignored `.ftpcreds` file:

| Variable   | Meaning                                                        |
|------------|----------------------------------------------------------------|
| `FTP_URL`  | Destination URL, e.g. `ftp://ftp.example.com/public_html/`     |
| `FTP_USER` | FTP account username                                           |
| `FTP_PASS` | FTP account password                                           |

Create `.ftpcreds` (never committed):

```text
FTP_URL=ftps://ftp.example.com/public_html/
FTP_USER=youruser
FTP_PASS=yourpass
```

Then run:

```bash
./deploy.sh
```

Upload target: the host's web root (`public_html`, `www`, or `httpdocs`, depending
on the host). `index.html` must land at that root so it serves at
`https://2fossickercircuit.com/`.

## FTPS vs plain FTP

Most modern hosts require FTPS (explicit TLS) or SFTP. Use an `ftps://` URL in
`FTP_URL` when the host requires FTPS, and curl's `--ssl-reqd` flag is applied
automatically for `ftps://`. If the host requires SFTP instead, upload with `sftp`
rather than this script. Confirm the protocol with the hosting provider before the
first deploy.

## DNS

The domain is registered separately. Its DNS now points at the web host (the host's
nameservers, or an A record to the host's IP), not GitHub Pages. This is managed at
the registrar or hosting control panel.

## History

Originally deployed via GitHub Pages with a CNAME and DNS A/AAAA records pointed at
Pages. Migrated to a dedicated web host with FTP upload. The CNAME file was removed
with the migration.
