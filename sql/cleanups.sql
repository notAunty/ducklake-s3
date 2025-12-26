-- Global
-- CALL ducklake.set_option('expire_older_than', '1 month');


-- Flush inline (small inserts)
CALL ducklake_flush_inlined_data('ducklake');

-- Merge
CALL ducklake_merge_adjacent_files('ducklake');

-- One-off deletion from S3
CALL ducklake_expire_snapshots('ducklake', older_than => now() - INTERVAL '1 week');
CALL ducklake_cleanup_old_files('ducklake', cleanup_all => true);
