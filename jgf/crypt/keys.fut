-- Not part of the benchmark as such, but maybe it is interesting by
-- itself.  This program computes the encryption- and decryption-keys
-- from a user-key.  Also adopted from the Java implementation.
-- Sequential, so don't expect anything cool here.
--
-- ==
-- input @ crypt-data/userkey0.txt
-- output @ crypt-data/keys0.txt

-- Multiplicative inverse mod 0x10001.
fun i32 inv(i16 a) =
  let a = i32(a)&0xFFFF in
  let b = 0x10001 in
  let u = 0 in
  let v = 1 in
  loop ({a,b,u,v}) = while a > 0i32 do
    let q = i32((i64(b)&0xFFFFFFFFi64) // (i64(a)&0xFFFFi64)) in
    let r = i32((i64(b)&0xFFFFFFFFi64) %% (i64(a)&0xFFFFi64)) in

    let b = i32(a) in
    let a = r in

    let t = v in
    let v = u - q * v in
    let u = t in
    {a,b,u,v} in

  (if u < 0 then u + 0x10001 else u) & 0xFFFF

fun [i16,52] encryptionKey([i16,8] userkey) =
  -- Key starts out blank.
  let Z = replicate(52, 0i16) in
  -- First 8 subkeys are userkey itself.
  loop (Z) = for i < 8 do
    let Z[i] = userkey[i] in
    Z in
  -- Each set of 8 subkeys thereafter is derived from left rotating
  -- the whole 128-bit key 25 bits to left (once between each set of
  -- eight keys and then before the last four). Instead of actually
  -- rotating the whole key, this routine just grabs the 16 bits
  -- that are 25 bits to the right of the corresponding subkey
  -- eight positions below the current subkey. That 16-bit extent
  -- straddles two array members, so bits are shifted left in one
  -- member and right (with zero fill) in the other. For the last
  -- two subkeys in any group of eight, those 16 bits start to
  -- wrap around to the first two members of the previous eight.
  loop (Z) = for 8 <= i < 52 do
    let j = i %% 8 in
    let Z[i] = if      j  < 6 then (Z[i-7]>>>9i16) | (Z[i-6]<<7i16)
               else if j == 6 then (Z[i-7]>>>9i16) | (Z[i-14]<<7i16)
                              else (Z[i-15]>>>9i16) | (Z[i-14]<<7i16) in
    Z in
  Z

fun [i16,52] decryptionKey([i16,52] Z) =
  -- Key starts out blank.
  let DK = replicate(52, 0i16) in
  let t1 = inv(Z[0]) in
  let t2 = i32(-Z[1]) & 0xFFFF in
  let t3 = i32(-Z[2]) & 0xFFFF in
  let DK[51] = i16(inv(Z[3])) in
  let DK[50] = i16(t3) in
  let DK[49] = i16(t2) in
  let DK[48] = i16(t1) in
  loop (DK) = for i < 7 do
    let kb = 4 + 6 * i in
    let jb = 47 - 6 * i in
    let t1 = Z[kb+0] in
    let DK[jb-0] = Z[kb+1] in
    let DK[jb-1] = t1 in
    let t1 = i16(inv(Z[kb+2])) in
    let t2 = -Z[kb+3] in
    let t3 = -Z[kb+4] in
    let DK[jb-2] = i16(inv(Z[kb+5])) in
    let DK[jb-3] = t2 in
    let DK[jb-4] = t3 in
    let DK[jb-5] = t1 in
    DK in
  let kb = 4 + 6 * 7 in
  let jb = 47 - 6 * 7 in

  let t1 = Z[kb+0] in
  let DK[jb-0] = Z[kb+1] in
  let DK[jb-1] = t1 in
  let t1 = i16(inv(Z[kb+2])) in
  let t2 = -Z[kb+3] in
  let t3 = -Z[kb+4] in
  let DK[jb-2] = i16(inv(Z[kb+5])) in
  let DK[jb-3] = t3 in
  let DK[jb-4] = t2 in
  let DK[jb-5] = t1 in
  DK

fun {[i16,52],[i16,52]} main([i16,8] userkey) =
  let Z = encryptionKey(userkey) in
  {Z, decryptionKey(Z)}