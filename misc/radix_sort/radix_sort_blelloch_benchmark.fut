-- Benchmark with larger datasets.
-- ==
--
-- tags { notravis }
-- input @ data/radix_sort_10K.in
-- input @ data/radix_sort_100K.in
-- input @ data/radix_sort_1M.in

include radix_sort_blelloch

fun i32 f() = 0 -- 