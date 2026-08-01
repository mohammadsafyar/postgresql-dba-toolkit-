SELECT
    name,
    setting,
    unit,
    context
FROM pg_settings
WHERE name IN (
    'archive_mode',
    'archive_command',
    'archive_timeout'
)
ORDER BY name;
