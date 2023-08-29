# How to run the generator?

```bash
./generator/batch
```

Append `--override` to override existing files.

```bash
./generator/batch --override
```

To generate only one page

```bash
./generator/single SCHEMA_NAME
```

```bash
./generator/single google_ads --override
```

# How to update usage?

Download the usage csv file from [Blazer](https://admin.growthnirvana.com/admin/blazer/queries/338-connector-usage-includes-custom-connectors).

Place it under ./generator/usage.csv
