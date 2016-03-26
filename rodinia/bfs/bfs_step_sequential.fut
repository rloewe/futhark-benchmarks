-- A naive, sequential step function for BFS.  Its purpose is to exist as a
-- simple, working solution.
  
fun {*[i32, n], *[bool, n], *[bool, n]}
  step(*[i32, n] cost,
       [i32, n] nodes_start_index,
       [i32, n] nodes_n_edges,
       [i32, e] edges_dest,
       [bool, n] graph_visited,
       *[bool, n] graph_mask,
       *[bool, n] updating_graph_mask) =
  let active_indices =
    filter(fn bool (i32 i) => graph_mask[i],
           iota(n))

  -- This loop is a kernel in Rodinia.  Futhark's regularity makes this a bit
  -- tricky to express as a map.
  loop ({cost, graph_mask, updating_graph_mask}) =
    for indices_i < size(0, active_indices) do
      let i = active_indices[indices_i]
      in node_work(i, cost, nodes_start_index, nodes_n_edges,
                   edges_dest, graph_visited,
                   graph_mask, updating_graph_mask)
  
  in {cost, graph_mask, updating_graph_mask}

fun {*[i32, n], *[bool, n], *[bool, n]}
  node_work(i32 tid,
            *[i32, n] cost,
            [i32, n] nodes_start_index,
            [i32, n] nodes_n_edges,
            [i32, e] edges_dest,
            [bool, n] graph_visited,
            *[bool, n] graph_mask,
            *[bool, n] updating_graph_mask) =
  let start_index = nodes_start_index[tid]
  let n_edges = nodes_n_edges[tid]
  let graph_mask[tid] = False
  loop ({cost, updating_graph_mask}) =
    for start_index <= i < start_index + n_edges do
      let id = edges_dest[i]
      let visited = graph_visited[id]
      in if ! visited
         then
           let cost[id] = cost[tid] + 1
           let updating_graph_mask[id] = True
           in {cost, updating_graph_mask}
         else
           {cost, updating_graph_mask}
    in {cost, graph_mask, updating_graph_mask}