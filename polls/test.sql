        WITH
      cv_info AS(
    SELECT
      user_id,
      server_time_usec
    FROM
      gram_vz_1
    WHERE
      gram_type = 1
      AND platform_category IN (1, 2)
      AND 
            year = 2018
                AND month = 12
                AND day BETWEEN 1 AND 1
    ),

    SELECT
      user_id,
      pv_ts
    FROM(
      SELECT
        cv_info.user_id,
        cv_info.server_time_usec AS cv_ts,
        gram_vz_1.server_time_usec AS pv_ts
      FROM
        cv_info
        LEFT JOIN gram_vz_1
          ON cv_info.user_id = gram_vz_1.user_id
      WHERE
        gram_vz_1.gram_type = 2
        AND platform_category IN (1, 2)
        AND gram_vz_1.server_time_usec <= cv_info.server_time_usec
        AND 
            year = 2018
                AND month = 12
                AND day BETWEEN 1 AND 1
    )