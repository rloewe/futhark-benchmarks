
----------------------------------------------------------------
--- Futhark Translation of gradient-ascent @ graddiv.py file.---
--- This implements some of the gradient and divergence      ---
--- operations used in P3 Segmentation algorithms.           ---
--- This should behave as the routines of ImageArray.h       ---
--- Orignal Python by: Francois Lauze, 2014-2015             ---
--- Futhark translation: Cosmin Oancea, May, 2016            ---
--- Both from University of Copenhagen                       --- 
----------------------------------------------------------------


-----------------------------------------------------------------------
-- add_ascent_grad2s implements gradient ascent for the dual variable 
-- in CCP splitting algorithm. 2D scalar case 
-- (i.e., a 2D Chan-Vese type algorithm).
-----
-- Arguments:
-- xi: dual variable
-- v : label array
-- td: gradient ascent time step
-----
-- Gradient based terms are easy as boundary conditions are 
-- simple to manipulate. Divergence based terms are messy.
-----------------------------------------------------------------------
fun [m][n](f32,f32) 
add_ascent_grad2s( [m][n](f32,f32) xi
                 , [m][n]f32 v
                 , f32               td ) =
  map(fn [n](f32,f32) (int i) =>
        map(fn (f32,f32) (int j) => unsafe
                let (elm1, elm2) = xi[i,j] in
                -- xi[0:m-1,:,:,0] += td*(v[1:m,:,:] - v[0:m-1,:,:])
                let fst_elm = 
                    if(i < m-1) 
                    then elm1 + td*(v[i+1,j] - v[i,j])
                    else elm1
                in
                -- xi[:,0:n-1,:,1] += td*(v[:,1:n,:] - v[:,0:n-1,:])
                let snd_elm = 
                    if (j < n-1)
                    then elm2 + td*(v[i,j+1] - v[i,j])
                    else elm2
                in
                (fst_elm, snd_elm)
           , iota(n) )
     , iota(m) )


-----------------------------------------------------------------------
-- add_ascent_grad2v implements gradient ascent for the dual variable 
-- in CCP splitting algorithm. 2D vectorial case 
-- (i.e., a  2D CCP type algorithm).
----
-- Arguments:
-- xi: dual variable
-- v : label array
-- td: gradient ascent time step
-----------------------------------------------------------------------
fun [m][n][k](f32,f32) 
add_ascent_grad2v( [m][n][k](f32,f32) xi
                 , [m][n][k]f32 v
                 , f32                   td ) =
  map(fn [n][k](f32,f32) (int i) =>
        map(fn [k](f32,f32) (int j) =>
                map(fn (f32,f32) (int l) => unsafe
                        let (elm1, elm2) = xi[i,j,l] in
                        -- xi[0:m-1,:,:,0] += td*(v[1:m,:,:] - v[0:m-1,:,:])
                        let fst_elm = 
                            if(i < m-1) 
                            then elm1 + td*(v[i+1,j,l] - v[i,j,l])
                            else elm1
                        in
                        -- xi[:,0:n-1,:,1] += td*(v[:,1:n,:] - v[:,0:n-1,:])
                        let snd_elm = 
                            if (j < n-1)
                            then elm2 + td*(v[i,j+1,l] - v[i,j,l])
                            else elm2
                        in
                        (fst_elm, snd_elm)   
                   , iota(k))
           , iota(n) )
     , iota(m) )


-----------------------------------------------------------------------
-- add_ascent_grad3s implements gradient ascent for the dual variable 
-- in CCP splitting algorithm. 3D scalar case
-- (i.e., a 3D Chan-Vese type algorithm).
----
-- Arguments:
-- xi: dual variable
-- v : label array
-- td: gradient ascent time step
-----------------------------------------------------------------------
fun [m][n][p](f32,f32,f32) 
add_ascent_grad3s( [m][n][p](f32,f32,f32) xi
                 , [m][n][p]f32 v
                 , f32                       td ) =
  map(fn [n][p](f32,f32,f32) (int i) =>
        map(fn [p](f32,f32,f32) (int j) =>
                map(fn (f32,f32,f32) (int k) => unsafe
                        let (elm1, elm2, elm3) = xi[i,j,k] in
                        -- xi[0:m-1,:,:,0] += td*(v[1:m,:,:] - v[0:m-1,:,:])
                        let fst_elm = 
                            if(i < m-1) 
                            then elm1 + td*(v[i+1,j,k] - v[i,j,k])
                            else elm1
                        in
                        -- xi[:,0:n-1,:,1] += td*(v[:,1:n,:] - v[:,0:n-1,:])
                        let snd_elm = 
                            if (j < n-1)
                            then elm2 + td*(v[i,j+1,k] - v[i,j,k])
                            else elm2
                        in
                        -- xi[:,:,0:p-1,2] += td*(v[:,:,1:p] - v[:,:,0:p-1])
                        let thd_elm = 
                            if (k < p-1)
                            then elm3 + td*(v[i,j,k+1] - v[i,j,k])
                            else elm3
                        in
                        (fst_elm, snd_elm, thd_elm)   
                   , iota(p) )
           , iota(n) )
     , iota(m) )


-----------------------------------------------------------------------
-- add_ascent_grad3v implements gradient ascent for the dual variable 
-- in CCP splitting algorithm. 3D vectorial case
-- (i.e., a  3D CCP type algorithm).
----
-- Arguments:
-- xi: dual variable
-- v : label array
-- td: gradient ascent time step
-----------------------------------------------------------------------
fun [m][n][p][k](f32,f32,f32) 
add_ascent_grad3v( [m][n][p][k](f32,f32,f32) xi
                 , [m][n][p][k]f32 v
                 , f32                           td ) =
  map(fn [n][p][k](f32,f32,f32) (int i) =>
        map(fn [p][k](f32,f32,f32) (int j) =>
              map(fn [k](f32,f32,f32) (int q) =>
                    map(fn (f32,f32,f32) (int t) => unsafe
                            let (elm1, elm2, elm3) = xi[i,j,q,t] in
                            -- xi[0:m-1,:,:,:,0] += td*(v[1:m,:,:,:] - v[0:m-1,:,:,:])
                            let fst_elm = 
                                if(i < m-1) 
                                then elm1 + td*(v[i+1,j,q,t] - v[i,j,q,t])
                                else elm1
                            in
                            -- xi[:,0:n-1,:,:,1] += td*(v[:,1:n,:,:] - v[:,0:n-1,:,:])
                            let snd_elm = 
                                if (j < n-1)
                                then elm2 + td*(v[i,j+1,q,t] - v[i,j,q,t])
                                else elm2
                            in
                            -- xi[:,:,0:p-1,:,2] += td*(v[:,:,1:p,:] - v[:,:,0:p-1,:])
                            let thd_elm = 
                                if (q < p-1)
                                then elm3 + td*(v[i,j,q+1,t] - v[i,j,q,t])
                                else elm3
                            in
                            (fst_elm, snd_elm, thd_elm)
                       , iota(k) )
                 , iota(p) )
           , iota(n) )
     , iota(m) )


fun [m][n][p][k](f32,f32,f32) 
    main( [m][n][p][k](f32,f32,f32) xi
        , [m][n][p][k]f32 v
        , f32                           td ) =
  add_ascent_grad3v( xi, v, td )

