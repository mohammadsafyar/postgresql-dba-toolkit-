WITH index_info AS (

    SELECT
        n.nspname AS schema_name,
        t.relname AS table_name,
        i.oid AS index_oid,
        i.relname AS index_name,
        am.amname AS index_method,

        ix.indisprimary AS is_primary,
        ix.indisunique AS is_unique,

        pg_get_expr(
            ix.indpred,
            ix.indrelid
        ) AS filter_condition,

        (
            SELECT string_agg(
                a.attname,
                '_' ORDER BY k.ordinality
            )
            FROM unnest(ix.indkey)
            WITH ORDINALITY AS k(attnum, ordinality)
            JOIN pg_attribute a
              ON a.attrelid = t.oid
             AND a.attnum = k.attnum
            WHERE k.ordinality <= ix.indnkeyatts
              AND k.attnum > 0
        ) AS columns_name,

        (
            SELECT string_agg(
                a.attname,
                '_' ORDER BY k.ordinality
            )
            FROM unnest(ix.indkey)
            WITH ORDINALITY AS k(attnum, ordinality)
            JOIN pg_attribute a
              ON a.attrelid = t.oid
             AND a.attnum = k.attnum
            WHERE k.ordinality > ix.indnkeyatts
              AND k.attnum > 0
        ) AS include_columns

    FROM pg_class i

    JOIN pg_index ix
      ON ix.indexrelid = i.oid

    JOIN pg_class t
      ON t.oid = ix.indrelid

    JOIN pg_namespace n
      ON n.oid = t.relnamespace

    JOIN pg_am am
      ON am.oid = i.relam

    WHERE i.relkind = 'i'
      AND n.nspname NOT IN (
          'pg_catalog',
          'information_schema',
          'pg_toast'
      )
),

suggested AS (

    SELECT
        *,
        
        CASE
            WHEN is_primary THEN 'pk'
            WHEN is_unique THEN 'uidx'
            WHEN filter_condition IS NOT NULL THEN 'pidx'
            WHEN index_method = 'btree' THEN 'idx'
            WHEN index_method = 'gin' THEN 'gin'
            WHEN index_method = 'gist' THEN 'gist'
            WHEN index_method = 'brin' THEN 'brin'
            WHEN index_method = 'hash' THEN 'hash'
            WHEN index_method = 'spgist' THEN 'spgist'
            ELSE index_method
        END
        || '_'
        || table_name
        || '_'
        || COALESCE(columns_name,'expression')

        ||

        CASE
            WHEN include_columns IS NOT NULL
            THEN '_inc_' || include_columns
            ELSE ''
        END AS suggested_name

    FROM index_info
)

SELECT

    schema_name,
    table_name,

    CASE
        WHEN is_primary THEN 'PRIMARY KEY'
        WHEN is_unique THEN 'UNIQUE'
        ELSE 'INDEX'
    END AS index_type,

    index_method,

    index_name AS current_name,

    -- نمایش خواناتر
    suggested_name
    || '('
    || COALESCE(columns_name,'expression')
    || ')' AS suggested_display_name,

    '('
    || COALESCE(columns_name,'expression')
    || ')' AS columns,

    format(
        'ALTER INDEX %I.%I RENAME TO %I;',
        schema_name,
        index_name,
        suggested_name
    ) AS rename_sql

FROM suggested

WHERE lower(index_name) <> lower(suggested_name)

ORDER BY
    schema_name,
    table_name,
    index_name;


	
