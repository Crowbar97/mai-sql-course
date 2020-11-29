run sql script:
```bash
sudo -u postgres psql \
    -d <db name> \
    -f <path to script> \
    > <path to output file> 2>&1
```

launch interactive db shell:
```bash
sudo -u postgres psql
```

changing active schema:
```sql
set search_path = <schema name>;
```