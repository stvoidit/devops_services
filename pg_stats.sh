#SHELL=/bin/bash
export PGPASSWORD=postgres
export ELK=http://elasticsearch:9200/postgres/logs
psql -h localhost -p 5555 -d postgres -U postgres -nqtA --command="SELECT
    jsonb_build_object( '@timestamp', now(), 'datid', datid , 'datname', datname , 'numbackends', numbackends , 'xact_commit', xact_commit , 'xact_rollback', xact_rollback , 'blks_read', blks_read , 'blks_hit', blks_hit , 'tup_returned',
 tup_returned , 'tup_fetched', tup_fetched , 'tup_inserted', tup_inserted , 'tup_updated', tup_updated , 'tup_deleted', tup_deleted , 'conflicts', conflicts , 'temp_files', temp_files , 'temp_bytes', temp_bytes , 'deadlocks', deadlocks ,
 'checksum_failures', checksum_failures , 'checksum_last_failure', checksum_last_failure , 'blk_read_time', blk_read_time , 'blk_write_time', blk_write_time , 'stats_reset', stats_reset )
FROM
    pg_stat_database;" | xargs -0 -d '\n' -I '@json' curl --url $ELK -i --header "Content-Type: application/json" --request POST --data '@json'
