-- Rodinia's Myocyte benchmark translated to Futhark.
-- Code and comments based on
-- https://github.com/kkushagra/rodinia/blob/master/openmp/myocyte/
--
-- ==
--
-- notravis input @ data/small.in
-- output @ data/small.out
-- notravis input @ data/medium.in

----------------------
----- Ecc MODULE -----
----------------------

fun f32 pow(f32 x, f32 y) = x ** y
fun f32 log10(f32 x) = log32(x) / log32(10.0f32)

fun f32 fmod(f32 a, f32 b) = ( a - b * f32(int(a / b)) )

fun f32 fabs(f32 a) = if (a < 0.0f32) then -a else a

fun *[equs]f32 ecc( f32 timeinst, [equs]f32 initvalu, int initvalu_offset,
                    [pars]f32 parameter, int parameter_offset, *[equs]f32 finavalu ) =
  unsafe 
  -- variable references
  let offset_1  = initvalu_offset in
  let offset_2  = initvalu_offset+1 in
  let offset_3  = initvalu_offset+2 in
  let offset_4  = initvalu_offset+3 in
  let offset_5  = initvalu_offset+4 in
  let offset_6  = initvalu_offset+5 in
  let offset_7  = initvalu_offset+6 in
  let offset_8  = initvalu_offset+7 in
  let offset_9  = initvalu_offset+8 in
  let offset_10 = initvalu_offset+9 in
  let offset_11 = initvalu_offset+10 in
  let offset_12 = initvalu_offset+11 in
  let offset_13 = initvalu_offset+12 in
  let offset_14 = initvalu_offset+13 in
  let offset_15 = initvalu_offset+14 in
  let offset_16 = initvalu_offset+15 in
  let offset_17 = initvalu_offset+16 in
  let offset_18 = initvalu_offset+17 in
  let offset_19 = initvalu_offset+18 in
  let offset_20 = initvalu_offset+19 in
  let offset_21 = initvalu_offset+20 in
  let offset_22 = initvalu_offset+21 in
  let offset_23 = initvalu_offset+22 in
  let offset_24 = initvalu_offset+23 in
  let offset_25 = initvalu_offset+24 in
  let offset_26 = initvalu_offset+25 in
  let offset_27 = initvalu_offset+26 in
  let offset_28 = initvalu_offset+27 in
  let offset_29 = initvalu_offset+28 in
  let offset_30 = initvalu_offset+29 in
  let offset_31 = initvalu_offset+30 in
  let offset_32 = initvalu_offset+31 in
  let offset_33 = initvalu_offset+32 in
  let offset_34 = initvalu_offset+33 in
  let offset_35 = initvalu_offset+34 in
  let offset_36 = initvalu_offset+35 in
  let offset_37 = initvalu_offset+36 in
  let offset_38 = initvalu_offset+37 in
  let offset_39 = initvalu_offset+38 in
  let offset_40 = initvalu_offset+39 in
  let offset_41 = initvalu_offset+40 in
  let offset_42 = initvalu_offset+41 in
  let offset_43 = initvalu_offset+42 in
  let offset_44 = initvalu_offset+43 in
  let offset_45 = initvalu_offset+44 in
  let offset_46 = initvalu_offset+45 in
  
  -- variable references
  let parameter_offset_1  = parameter_offset in

  -- decoded input initial data
  let initvalu_1  = initvalu[offset_1 ] in
  let initvalu_2  = initvalu[offset_2 ] in
  let initvalu_3  = initvalu[offset_3 ] in
  let initvalu_4  = initvalu[offset_4 ] in
  let initvalu_5  = initvalu[offset_5 ] in
  let initvalu_6  = initvalu[offset_6 ] in
  let initvalu_7  = initvalu[offset_7 ] in
  let initvalu_8  = initvalu[offset_8 ] in
  let initvalu_9  = initvalu[offset_9 ] in
  let initvalu_10 = initvalu[offset_10] in
  let initvalu_11 = initvalu[offset_11] in
  let initvalu_12 = initvalu[offset_12] in
  let initvalu_13 = initvalu[offset_13] in
  let initvalu_14 = initvalu[offset_14] in
  let initvalu_15 = initvalu[offset_15] in
  let initvalu_16 = initvalu[offset_16] in
  let initvalu_17 = initvalu[offset_17] in
  let initvalu_18 = initvalu[offset_18] in
  let initvalu_19 = initvalu[offset_19] in
  let initvalu_20 = initvalu[offset_20] in
  let initvalu_21 = initvalu[offset_21] in
  let initvalu_22 = initvalu[offset_22] in
  let initvalu_23 = initvalu[offset_23] in
  let initvalu_24 = initvalu[offset_24] in
  let initvalu_25 = initvalu[offset_25] in
  let initvalu_26 = initvalu[offset_26] in
  let initvalu_27 = initvalu[offset_27] in
  let initvalu_28 = initvalu[offset_28] in
  let initvalu_29 = initvalu[offset_29] in
  let initvalu_30 = initvalu[offset_30] in
  let initvalu_31 = initvalu[offset_31] in
  let initvalu_32 = initvalu[offset_32] in
  let initvalu_33 = initvalu[offset_33] in
  let initvalu_34 = initvalu[offset_34] in
  let initvalu_35 = initvalu[offset_35] in
  let initvalu_36 = initvalu[offset_36] in
  let initvalu_37 = initvalu[offset_37] in
  let initvalu_38 = initvalu[offset_38] in
  let initvalu_39 = initvalu[offset_39] in
  let initvalu_40 = initvalu[offset_40] in
  let initvalu_41 = initvalu[offset_41] in
  let initvalu_42 = initvalu[offset_42] in
  let initvalu_43 = initvalu[offset_43] in
  let initvalu_44 = initvalu[offset_44] in
  let initvalu_45 = initvalu[offset_45] in
  let initvalu_46 = initvalu[offset_46] in

  -- decoded input parameters
  let parameter_1 = parameter[parameter_offset_1] in

  -- constants
  let pi   = 3.1416f32     in
  let r    = 8314.0f32     in -- [J/kmol*K]  
  let frdy = 96485.0f32    in -- [C/mol]  
  let temp = 310.0f32      in -- [K] 310
  let foRT = frdy/r/temp   in
  let cmem = 1.3810e-10f32 in -- [F] membrane capacitance
  let qpow = (temp-310.0f32)/10.0f32
  in
  -- Cell geometry
  let cellLength = 100.0f32   in  -- cell length []um
  let cellRadius = 10.25f32   in  -- cell radius []um
  let junctionLength = 160.0e-3f32 in  -- junc length []um
  let junctionRadius = 15.0e-3f32  in  -- junc radius []um
  let distSLcyto = 0.45f32    in  -- dist. SL to cytosol []um
  let distJuncSL = 0.5f32     in  -- dist. junc to SL []um
  let dcaJuncSL = 1.64e-6f32  in  -- Dca junc to SL [cm^2/sec]
  let dcaSLcyto = 1.22e-6f32  in  -- Dca SL to cyto [cm^2/sec]
  let nnaJuncSL = 1.09e-5f32  in  -- Dna junc to SL [cm^2/sec]
  let dnaSLcyto = 1.79e-5f32  in  -- Dna SL to cyto [cm^2/sec] 
  let vcell = pi*pow(cellRadius,2.0f32)*cellLength*1.0e-15f32 in -- [L]
  let vmyo = 0.65f32*vcell    in
  let vsr = 0.035f32*vcell    in
  let vsl = 0.02f32 *vcell    in
  let vjunc = 0.0539f32 * 0.01f32 * vcell in 
  let sajunc = 20150.0f32 * pi * 2.0f32 * junctionLength * junctionRadius in -- [um^2]
  let sasl = pi * 2.0f32 * cellRadius * cellLength in -- [um^2]
  let j_ca_juncsl = 1.0f32/1.2134e12f32  in    -- [L/msec]
  let j_ca_slmyo  = 1.0f32/2.68510e11f32 in    -- [L/msec]
  let j_na_juncsl = 1.0f32/(1.6382e12f32 / 3.0f32 * 100.0f32) in -- [L/msec] 
  let j_na_slmyo  = 1.0f32/(1.8308e10f32 / 3.0f32 * 100.0f32) in -- [L/msec]
  
  -- Fractional currents in compartments
  let fjunc = 0.11f32      in
  let fsl = 1.0f32 - fjunc in
  let fjunc_CaL = 0.9f32   in
  let fsl_CaL = 1.0f32 - fjunc_CaL in

  -- Fixed ion concentrations
  let cli = 15.0f32  in -- Intracellular Cl  []mM
  let clo = 150.0f32 in -- Extracellular Cl  []mM
  let ko = 5.4f32    in -- Extracellular K   []mM
  let nao = 140.0f32 in -- Extracellular Na  []mM
  let cao = 1.8f32   in -- Extracellular Ca  []mM
  let mgi = 1.0f32   in
  
  -- Nernst Potentials
  let ena_junc = (1.0f32/foRT)*log32(nao/initvalu_32)        in -- []mV
  let ena_sl = (1.0f32/foRT)*log32(nao/initvalu_33)          in -- []mV
  let ek = (1.0f32/foRT)*log32(ko/initvalu_35)               in -- []mV
  let eca_junc = (1.0f32/foRT/2.0f32)*log32(cao/initvalu_36) in -- []mV
  let eca_sl = (1.0f32/foRT/2.0f32)*log32(cao/initvalu_37)   in -- []mV
  let ecl = (1.0f32/foRT)*log32(cli/clo)                     in -- []mV

  -- Na transport parameters
  let gna =  16.0f32       in -- [mS/uF]
  let gnaB = 0.297e-3f32   in -- [mS/uF] 
  let iBarNaK = 1.90719f32 in -- [uA/uF]
  let kmNaip = 11.0f32     in -- []mM
  let kmko = 1.5f32        in -- []mM
  let q10NaK = 1.63f32     in
  let q10KmNai = 1.39f32   
  in
  -- K current parameters
  let pNaK = 0.01833f32 in
  let dToSlow = 0.06f32 in -- [mS/uF] 
  let gToFast = 0.02f32 in -- [mS/uF] 
  let gkp = 0.001f32    
  in
  -- Cl current parameters
  let gClCa = 0.109625f32 in -- [mS/uF]
  let gClB = 9.0e-3f32      in -- [mS/uF]
  let kdClCa = 100.0e-3f32     -- []mM
  in
  -- i_Ca parameters
  let pNa = 1.5e-8f32  in -- [cm/sec]
  let pCa = 5.4e-4f32  in -- [cm/sec]
  let pK = 2.7e-7f32   in -- [cm/sec]
  let kmCa = 0.6e-3f32 in -- []mM
  let q10CaL = 1.8f32 
  in
  -- Ca transport parameters
  let ibarNCX = 9.0f32   in -- [uA/uF]
  let kmCai = 3.59e-3f32 in -- []mM
  let kmcao = 1.3f32     in -- []mM
  let kmNai = 12.29f32   in -- []mM
  let kmnao = 87.5f32    in -- []mM
  let ksat = 0.27f32     in -- []none  
  let nu = 0.35f32       in -- []none
  let kdact = 0.256e-3f32 in -- []mM 
  let q10NCX = 1.57f32   in -- []none
  let ibarSLCaP = 0.0673f32 in -- [uA/uF]
  let kmPCa = 0.5e-3f32  in -- []mM 
  let gCaB = 2.513e-4f32 in -- [uA/uF] 
  let q10SLCaP = 2.35f32 in -- []none

  -- SR flux parameters
  let q10SRCaP = 2.6f32 in -- []none
  let vmax_SRCaP = 2.86e-4f32 in -- [mM/msec] (mmol/L cytosol/msec)
  let kmf = 0.246e-3f32    in -- []mM
  let kmr = 1.7f32         in -- []mML cytosol
  let hillSRCaP = 1.787f32 in -- []mM
  let ks   = 25.0f32 in -- [1/ms]      
  let koCa = 10.0f32 in -- [mM^-2 1/ms]      
  let kom  = 0.06f32 in -- [1/ms]     
  let kiCa = 0.5f32  in -- [1/mM/ms]
  let kim = 0.005f32 in -- [1/ms]
  let ec50SR = 0.45f32  in -- []mM

  -- Buffering parameters
  let bmax_Naj = 7.561f32 in -- []mM 
  let bmax_Nasl = 1.65f32 in -- []mM
  let koff_na = 1.0e-3f32   in -- [1/ms]
  let kon_na = 0.1e-3f32  in -- [1/mM/ms]
  let bmax_Tnclow = 70e-3f32 in -- []mM, TnC low affinity
  let koff_tncl = 19.6e-3f32 in -- [1/ms] 
  let kon_tncl = 32.7f32     in -- [1/mM/ms]
  let bmax_TnChigh = 140.0e-3f32  in -- []mM, TnC high affinity 
  let koff_tnchca = 0.032e-3f32 in -- [1/ms] 
  let kon_tnchca = 2.37f32      in -- [1/mM/ms]
  let koff_tnchmg = 3.33e-3f32  in -- [1/ms] 
  let kon_tnchmg = 3.0e-3f32      in -- [1/mM/ms]
  let bmax_CaM = 24.0e-3f32       in -- []mM, CaM buffering
  let koff_cam = 238.0e-3f32      in -- [1/ms] 
  let kon_cam = 34.0f32           in -- [1/mM/ms]
  let bmax_myosin = 140.0e-3f32   in -- []mM, Myosin buffering
  let koff_myoca = 0.46e-3f32     in -- [1/ms]
  let kon_myoca = 13.8f32         in -- [1/mM/ms]
  let koff_myomg = 0.057e-3f32    in -- [1/ms]
  let kon_myomg = 0.0157f32       in -- [1/mM/ms]
  let bmax_SR = 19.0f32 * 0.9e-3f32 in -- []mM 
  let koff_sr = 60.0e-3f32        in -- [1/ms]
  let kon_sr = 100.0f32           in -- [1/mM/ms]
  let bmax_SLlowsl = 37.38e-3f32 * vmyo / vsl in -- []mM, SL buffering
  let bmax_SLlowj = 4.62e-3f32   * vmyo / vjunc * 0.1f32 in -- []mM    
  let koff_sll = 1300.0e-3f32     in -- [1/ms]
  let kon_sll = 100.0f32          in -- [1/mM/ms]
  let bmax_SLhighsl = 13.35e-3f32 * vmyo / vsl in -- []mM 
  let bmax_SLhighj = 1.65e-3f32 * vmyo / vjunc * 0.1f32 in -- []mM 
  let koff_slh = 30e-3f32 in -- [1/ms]
  let kon_slh = 100.0f32  in -- [1/mM/ms]
  let bmax_Csqn = 2.7f32  in -- 140e-3*vmyo/Vsr; []mM
  let koff_csqn = 65.0f32 in -- [1/ms]
  let kon_csqn = 100.0f32 in -- [1/mM/ms]

  -- i_Na: Fast Na Current
  let am = 0.32f32 * (initvalu_39 + 47.13f32) / (1.0f32 - exp32(-0.1f32*(initvalu_39+47.13f32))) in
  let bm = 0.08f32 * exp32(-initvalu_39/11.0f32) in
  let ( ah, aj, bh, bj ) =  if (initvalu_39 >= -40.0f32)
                            then ( 0.0f32, 
                                   0.0f32,
                                   1.0f32/(0.13f32*(1.0f32+exp32(-(initvalu_39+10.66f32)/11.1f32))),
                                   0.3f32*exp32(-2.535e-7f32*initvalu_39)/(1.0f32+exp32(-0.1f32*(initvalu_39+32.0f32))) 
                                 )
                            else ( 0.135f32*exp32((80.0f32+initvalu_39)/-6.8f32),
                                   ( -127140.0f32*exp32(0.2444f32*initvalu_39) - 3.474e-5f32*exp32(-0.04391f32*initvalu_39) ) *
                                        (initvalu_39+37.78f32)/(1.0f32+exp32(0.311f32*(initvalu_39+79.23f32))),
                                   3.56f32*exp32(0.079f32*initvalu_39)+3.1e5f32*exp32(0.35f32*initvalu_39),
                                   0.1212f32 * exp32(-0.01052f32*initvalu_39) / (1.0f32 + exp32(-0.1378f32 * (initvalu_39+40.14f32)))
                                 )
  in
  let finavalu[offset_1] = am*(1.0f32-initvalu_1) - bm*initvalu_1 in
  let finavalu[offset_2] = ah*(1.0f32-initvalu_2) - bh*initvalu_2 in
  let finavalu[offset_3] = aj*(1.0f32-initvalu_3) - bj*initvalu_3 in
  let i_Na_junc = fjunc*gna*pow(initvalu_1,3.0f32)*initvalu_2*initvalu_3*(initvalu_39-ena_junc) in
  let i_Na_sl = fsl*gna*pow(initvalu_1,3.0f32)*initvalu_2*initvalu_3*(initvalu_39-ena_sl) in
  let i_Na = i_Na_junc + i_Na_sl 
  in
  -- i_nabk: Na Background Current
  let i_nabk_junc = fjunc*gnaB*(initvalu_39-ena_junc) in
  let i_nabk_sl   = fsl  *gnaB*(initvalu_39-ena_sl  ) in
  let i_nabk      = i_nabk_junc + i_nabk_sl           in

  -- i_nak: Na/K Pump Current
  let sigma = (exp32(nao/67.3f32)-1.0f32)/7.0f32 in
  let fnak = 1.0f32/(1.0f32+0.1245f32*exp32(-0.1f32*initvalu_39*foRT)+0.0365f32*sigma*exp32(-initvalu_39*foRT)) in
  let i_nak_junc = fjunc*iBarNaK*fnak*ko / (1.0f32+pow((kmNaip/initvalu_32),4.0f32)) /(ko+kmko) in
  let i_nak_sl = fsl*iBarNaK*fnak*ko /(1.0f32+pow((kmNaip/initvalu_33),4.0f32)) /(ko+kmko) in
  let i_nak = i_nak_junc + i_nak_sl 
  in
  -- i_kr: Rapidly Activating K Current
  let gkr = 0.03f32 * sqrt32(ko/5.4f32) in
  let xrss = 1.0f32 / (1.0f32 + exp32(-(initvalu_39+50.0f32)/7.5f32)) in
  let tauxr = 1.0f32/(0.00138f32*(initvalu_39+7.0f32) / (1.0f32-exp32(-0.123f32*(initvalu_39+7.0f32))) +
                6.1e-4f32*(initvalu_39+10.0f32)/(exp32(0.145f32*(initvalu_39+10.0f32))-1.0f32)) in
  let finavalu[offset_12] = (xrss-initvalu_12)/tauxr in
  let rkr = 1.0f32 / (1.0f32 + exp32((initvalu_39+33.0f32)/22.4f32)) in
  let i_kr = gkr*initvalu_12*rkr*(initvalu_39-ek)
  in
  -- i_ks: Slowly Activating K Current
  let pcaks_junc = -log10(initvalu_36)+3.0f32 in
  let pcaks_sl = -log10(initvalu_37)+3.0f32 in  
  let gks_junc = 0.07f32*(0.057f32 +0.19f32/(1.0f32+ exp32((-7.2f32+pcaks_junc)/0.6f32))) in
  let gks_sl = 0.07f32*(0.057f32 +0.19f32/(1.0f32+ exp32((-7.2f32+pcaks_sl)/0.6f32))) in 
  let eks = (1.0f32/foRT)*log32((ko+pNaK*nao)/(initvalu_35+pNaK*initvalu_34)) in
  let xsss = 1.0f32/(1.0f32+exp32(-(initvalu_39-1.5f32)/16.7f32)) in
  let tauxs = 1.0f32/(7.19e-5f32*(initvalu_39+30.0f32)/(1.0f32-exp32(-0.148f32*(initvalu_39+30.0f32))) + 
                1.31e-4f32*(initvalu_39+30.0f32)/(exp32(0.0687f32*(initvalu_39+30.0f32))-1.0f32)) in
  let finavalu[offset_13] = (xsss-initvalu_13) / tauxs in
  let i_ks_junc = fjunc*gks_junc*pow(initvalu_12,2.0f32)*(initvalu_39-eks) in
  let i_ks_sl = fsl*gks_sl*pow(initvalu_13,2.0f32)*(initvalu_39-eks) in
  let i_ks = i_ks_junc+i_ks_sl
  in
  -- i_kp: Plateau K current
  let kp_kp = 1.0f32/(1.0f32+exp32(7.488f32-initvalu_39/5.98f32)) in
  let i_kp_junc = fjunc*gkp*kp_kp*(initvalu_39-ek) in
  let i_kp_sl = fsl*gkp*kp_kp*(initvalu_39-ek) in
  let i_kp = i_kp_junc+i_kp_sl in

  -- i_to: Transient Outward K Current (slow and fast components)
  let xtoss = 1.0f32/(1.0f32+exp32(-(initvalu_39+3.0f32)/15.0f32)) in
  let ytoss = 1.0f32/(1.0f32+exp32((initvalu_39+33.5f32)/10.0f32)) in
  let rtoss = 1.0f32/(1.0f32+exp32((initvalu_39+33.5f32)/10.0f32)) in
  let tauxtos = 9.0f32/(1.0f32+exp32((initvalu_39+3.0f32)/15.0f32))+0.5f32 in
  let tauytos = 3.0e3f32/(1.0f32+exp32((initvalu_39+60.0f32)/10.0f32))+30.0f32 in
  let taurtos = 2800.0f32/(1.0f32+exp32((initvalu_39+60.0f32)/10.0f32))+220.0f32 in
  let finavalu[offset_8] = (xtoss-initvalu_8)/tauxtos in
  let finavalu[offset_9] = (ytoss-initvalu_9)/tauytos in
  let finavalu[offset_40]= (rtoss-initvalu_40)/taurtos in
  let i_tos = dToSlow*initvalu_8*(initvalu_9+0.5f32*initvalu_40)*(initvalu_39-ek) -- [uA/uF]
  in
  -- 
  let tauxtof = 3.5f32*exp32(-initvalu_39*initvalu_39/30.0f32/30.0f32)+1.5f32 in
  let tauytof = 20.0f32/(1.0f32+exp32((initvalu_39+33.5f32)/10.0f32))+20.0f32 in
  let finavalu[offset_10] = (xtoss-initvalu_10)/tauxtof in
  let finavalu[offset_11] = (ytoss-initvalu_11)/tauytof in
  let i_tof = gToFast*initvalu_10*initvalu_11*(initvalu_39-ek) in
  let i_to = i_tos + i_tof 
  in
  -- i_ki: Time-independent K Current
  let aki = 1.02f32/(1.0f32+exp32(0.2385f32*(initvalu_39-ek-59.215f32))) in
  let bki =(0.49124f32*exp32(0.08032f32*(initvalu_39+5.476f32-ek)) + exp32(0.06175f32*(initvalu_39-ek-594.31f32))) /
                (1.0f32 + exp32(-0.5143f32*(initvalu_39-ek+4.753f32))) in
  let kiss = aki/(aki+bki) in
  let i_ki = 0.9f32*sqrt32(ko/5.4f32)*kiss*(initvalu_39-ek) 
  in
  -- i_ClCa: Ca-activated Cl Current, i_Clbk: background Cl Current
  let i_ClCa_junc = fjunc*gClCa/(1.0f32+kdClCa/initvalu_36)*(initvalu_39-ecl) in
  let i_ClCa_sl = fsl*gClCa/(1.0f32+kdClCa/initvalu_37)*(initvalu_39-ecl) in
  let i_ClCa = i_ClCa_junc+i_ClCa_sl in
  let i_Clbk = gClB*(initvalu_39-ecl) 
  in
  -- i_Ca: L-type Calcium Current
  let dss = 1.0f32/(1.0f32+exp32(-(initvalu_39+14.5f32)/6.0f32)) in
  let taud = dss*(1.0f32-exp32(-(initvalu_39+14.5f32)/6.0f32))/(0.035f32*(initvalu_39+14.5f32)) in
  let fss = 1.0f32/(1.0f32+exp32((initvalu_39+35.06f32)/3.6f32))+0.6f32/(1.0f32+exp32((50.0f32-initvalu_39)/20.0f32)) in
  let tauf = 1.0f32/(0.0197f32*exp32(-pow(0.0337f32*(initvalu_39+14.5f32),2.0f32))+0.02f32) in
  let finavalu[offset_4] = (dss-initvalu_4)/taud in
  let finavalu[offset_5] = (fss-initvalu_5)/tauf in
  let finavalu[offset_6] = 1.7f32*initvalu_36*(1.0f32-initvalu_6)-11.9e-3f32*initvalu_6 in -- fCa_junc  
  let finavalu[offset_7] = 1.7f32*initvalu_37*(1.0f32-initvalu_7)-11.9e-3f32*initvalu_7    -- fCa_sl
  in
  -- 
  let ibarca_j = pCa*4.0f32*(initvalu_39*frdy*foRT) * (0.341f32*initvalu_36*exp32(2.0f32*initvalu_39*foRT)-0.341f32*cao) /
                    (exp32(2.0f32*initvalu_39*foRT)-1.0f32) in
  let ibarca_sl= pCa*4.0f32*(initvalu_39*frdy*foRT) * (0.341f32*initvalu_37*exp32(2.0f32*initvalu_39*foRT)-0.341f32*cao) /
                    (exp32(2.0f32*initvalu_39*foRT)-1.0f32) in
  let ibark = pK*(initvalu_39*frdy*foRT)*(0.75f32*initvalu_35*exp32(initvalu_39*foRT)-0.75f32*ko) /
                    (exp32(initvalu_39*foRT)-1.0f32) in
  let ibarna_j = pNa*(initvalu_39*frdy*foRT) *(0.75f32*initvalu_32*exp32(initvalu_39*foRT)-0.75f32*nao) /
                    (exp32(initvalu_39*foRT)-1.0f32) in
  let ibarna_sl= pNa*(initvalu_39*frdy*foRT) *(0.75f32*initvalu_33*exp32(initvalu_39*foRT)-0.75f32*nao) /
                    (exp32(initvalu_39*foRT)-1.0f32) in
  let i_Ca_junc = (fjunc_CaL*ibarca_j*initvalu_4*initvalu_5*(1.0f32-initvalu_6)*pow(q10CaL,qpow))*0.45f32 in
  let i_Ca_sl   = (fsl_CaL*ibarca_sl*initvalu_4*initvalu_5*(1.0f32-initvalu_7)*pow(q10CaL,qpow))*0.45f32  in
  let i_Ca = i_Ca_junc+i_Ca_sl in
  let finavalu[offset_43] = -i_Ca*cmem/(vmyo*2.0f32*frdy)*1e3f32 in
  let i_CaK = (ibark*initvalu_4*initvalu_5*(fjunc_CaL*(1.0f32-initvalu_6)+fsl_CaL*(1.0f32-initvalu_7))*pow(q10CaL,qpow))*0.45f32 in
  let i_CaNa_junc = (fjunc_CaL*ibarna_j*initvalu_4*initvalu_5*(1.0f32-initvalu_6)*pow(q10CaL,qpow))*0.45f32 in
  let i_CaNa_sl = (fsl_CaL*ibarna_sl*initvalu_4*initvalu_5*(1.0f32-initvalu_7)*pow(q10CaL,qpow))*0.45f32 in
  let i_CaNa = i_CaNa_junc+i_CaNa_sl in
  let i_Catot = i_Ca+i_CaK+i_CaNa 
  in
  -- i_ncx: Na/Ca Exchanger flux
  let ka_junc = 1.0f32/(1.0f32+pow((kdact/initvalu_36),3.0f32)) in
  let ka_sl = 1.0f32/(1.0f32+pow((kdact/initvalu_37),3.0f32)) in
  let s1_junc = exp32(nu*initvalu_39*foRT)*pow(initvalu_32,3.0f32)*cao in
  let s1_sl = exp32(nu*initvalu_39*foRT)*pow(initvalu_33,3.0f32)*cao in
  let s2_junc = exp32((nu-1.0f32)*initvalu_39*foRT)*pow(nao,3.0f32)*initvalu_36 in
  let s3_junc = (kmCai*pow(nao,3.0f32)*(1.0f32+pow((initvalu_32/kmNai),3.0f32))+pow(kmnao,3.0f32)*initvalu_36 +
                    pow(kmNai,3.0f32)*cao*(1.0f32+initvalu_36/kmCai)+kmcao*pow(initvalu_32,3.0f32)+pow(initvalu_32,3.0f32)*cao +
                    pow(nao,3.0f32)*initvalu_36)*(1.0f32+ksat*exp32((nu-1.0f32)*initvalu_39*foRT)) in
  let s2_sl = exp32((nu-1.0f32)*initvalu_39*foRT)*pow(nao,3.0f32)*initvalu_37 in
  let s3_sl = (kmCai*pow(nao,3.0f32)*(1.0f32+pow((initvalu_33/kmNai),3.0f32)) +
                pow(kmnao,3.0f32)*initvalu_37+pow(kmNai,3.0f32)*cao*(1.0f32+initvalu_37/kmCai) +
                kmcao*pow(initvalu_33,3.0f32)+pow(initvalu_33,3.0f32)*cao+pow(nao,3.0f32)*initvalu_37)*
                (1.0f32+ksat*exp32((nu-1.0f32)*initvalu_39*foRT)) in
  let i_ncx_junc = fjunc*ibarNCX*pow(q10NCX,qpow)*ka_junc*(s1_junc-s2_junc)/s3_junc in
  let i_ncx_sl = fsl*ibarNCX*pow(q10NCX,qpow)*ka_sl*(s1_sl-s2_sl)/s3_sl in
  let i_ncx = i_ncx_junc+i_ncx_sl in
  let finavalu[offset_45] = 2.0f32*i_ncx*cmem/(vmyo*2.0f32*frdy)*1e3f32
  in
  -- i_pca: Sarcolemmal Ca Pump Current
  let i_pca_junc =  fjunc *
                    pow(q10SLCaP,qpow) * 
                    ibarSLCaP *
                    pow(initvalu_36,1.6f32) /
                    (pow(kmPCa,1.6f32) + pow(initvalu_36,1.6f32)) in
  let i_pca_sl = fsl *
                pow(q10SLCaP,qpow) *
                ibarSLCaP *
                pow(initvalu_37,1.6f32) / 
                (pow(kmPCa,1.6f32) + pow(initvalu_37,1.6f32)) in 
  let i_pca = i_pca_junc + i_pca_sl in
  let finavalu[offset_44] = -i_pca*cmem/(vmyo*2.0f32*frdy)*1e3f32 
  in
  -- i_cabk: Ca Background Current
  let i_cabk_junc = fjunc*gCaB*(initvalu_39-eca_junc) in
  let i_cabk_sl = fsl*gCaB*(initvalu_39-eca_sl) in
  let i_cabk = i_cabk_junc+i_cabk_sl in
  let finavalu[offset_46] = -i_cabk*cmem/(vmyo*2.0f32*frdy)*1e3f32 
  in
  -- SR fluxes: Calcium Release, SR Ca pump, SR Ca leak
  let maxSR = 15.0f32 in
  let minSR = 1.0f32  in
  let kCaSR = maxSR - (maxSR-minSR)/(1.0f32+pow(ec50SR/initvalu_31,2.5f32)) in
  let koSRCa = koCa/kCaSR in
  let kiSRCa = kiCa*kCaSR in
  let ri = 1.0f32 - initvalu_14 - initvalu_15 - initvalu_16 in
  let finavalu[offset_14] = (kim*ri-kiSRCa*initvalu_36*initvalu_14) - 
                            (koSRCa*pow(initvalu_36,2.0f32) * initvalu_14-kom*initvalu_15) in -- R
  let finavalu[offset_15] = (koSRCa*pow(initvalu_36,2.0f32) * initvalu_14-kom*initvalu_15) - 
                            (kiSRCa*initvalu_36*initvalu_15-kim*initvalu_16) in -- O
  let finavalu[offset_16] = (kiSRCa*initvalu_36*initvalu_15-kim*initvalu_16) - 
                            (kom*initvalu_16-koSRCa*pow(initvalu_36,2.0f32)*ri) in -- i
  let j_SRCarel = ks*initvalu_15*(initvalu_31-initvalu_36) in -- [mM/ms]
  let j_serca = pow(q10SRCaP,qpow)*vmax_SRCaP*(pow((initvalu_38/kmf),hillSRCaP)-pow((initvalu_31/kmr),hillSRCaP))
                                        /(1.0f32+pow((initvalu_38/kmf),hillSRCaP)+pow((initvalu_31/kmr),hillSRCaP)) in
  let j_SRleak = 5.348e-6f32*(initvalu_31-initvalu_36) -- [mM/ms]
  in
  -- Sodium and Calcium Buffering
  let finavalu[offset_17] = kon_na*initvalu_32*(bmax_Naj-initvalu_17)-koff_na*initvalu_17   in -- NaBj  [mM/ms]
  let finavalu[offset_18] = kon_na*initvalu_33*(bmax_Nasl-initvalu_18)-koff_na*initvalu_18  in -- NaBsl [mM/ms]
  -- Cytosolic Ca Buffers
  let finavalu[offset_19] = kon_tncl*initvalu_38*(bmax_Tnclow-initvalu_19)-koff_tncl*initvalu_19 in -- TnCL [mM/ms]
  let finavalu[offset_20] = kon_tnchca*initvalu_38*(bmax_TnChigh-initvalu_20-initvalu_21)-koff_tnchca*initvalu_20 in -- TnCHc [mM/ms]
  let finavalu[offset_21] = kon_tnchmg*mgi*(bmax_TnChigh-initvalu_20-initvalu_21)-koff_tnchmg*initvalu_21 in -- TnCHm [mM/ms]
  let finavalu[offset_22] = 0.0f32 in -- CaM [mM/ms]
  let finavalu[offset_23] = kon_myoca*initvalu_38*(bmax_myosin-initvalu_23-initvalu_24)-koff_myoca*initvalu_23 in -- Myosin_ca [mM/ms]
  let finavalu[offset_24] = kon_myomg*mgi*(bmax_myosin-initvalu_23-initvalu_24)-koff_myomg*initvalu_24 in -- Myosin_mg [mM/ms]
  let finavalu[offset_25] = kon_sr*initvalu_38*(bmax_SR-initvalu_25)-koff_sr*initvalu_25 in -- SRB [mM/ms]
  let j_CaB_cytosol =   finavalu[offset_19] + finavalu[offset_20] + finavalu[offset_21] + 
                        finavalu[offset_22] + finavalu[offset_23] + finavalu[offset_24] + finavalu[offset_25]
  in
  -- Junctional and SL Ca Buffers
  let finavalu[offset_26] = kon_sll*initvalu_36*(bmax_SLlowj-initvalu_26)-koff_sll*initvalu_26  in -- SLLj  [mM/ms]
  let finavalu[offset_27] = kon_sll*initvalu_37*(bmax_SLlowsl-initvalu_27)-koff_sll*initvalu_27 in -- SLLsl [mM/ms]
  let finavalu[offset_28] = kon_slh*initvalu_36*(bmax_SLhighj-initvalu_28)-koff_slh*initvalu_28 in -- SLHj  [mM/ms]
  let finavalu[offset_29] = kon_slh*initvalu_37*(bmax_SLhighsl-initvalu_29)-koff_slh*initvalu_29 in-- SLHsl [mM/ms]
  let j_CaB_junction = finavalu[offset_26]+finavalu[offset_28] in
  let j_CaB_sl = finavalu[offset_27]+finavalu[offset_29]
  in
  -- SR Ca Concentrations
  let finavalu[offset_30] = kon_csqn*initvalu_31*(bmax_Csqn-initvalu_30)-koff_csqn*initvalu_30 in -- Csqn [mM/ms]
  let oneovervsr = 1.0f32 / vsr in
  let finavalu[offset_31] = j_serca*vmyo*oneovervsr-(j_SRleak*vmyo*oneovervsr+j_SRCarel)-finavalu[offset_30] -- Ca_sr [mM/ms]
  in
  -- Sodium Concentrations
  let i_Na_tot_junc = i_Na_junc+i_nabk_junc+3.0f32*i_ncx_junc+3.0f32*i_nak_junc+i_CaNa_junc in -- [uA/uF]
  let i_Na_tot_sl = i_Na_sl+i_nabk_sl+3.0f32*i_ncx_sl+3.0f32*i_nak_sl+i_CaNa_sl in -- [uA/uF]
  let finavalu[offset_32] = -i_Na_tot_junc*cmem/(vjunc*frdy)+j_na_juncsl/vjunc*(initvalu_33-initvalu_32)-finavalu[offset_17] in
  let oneovervsl = 1.0f32 / vsl in
  let finavalu[offset_33] = -i_Na_tot_sl*cmem*oneovervsl/frdy+j_na_juncsl*oneovervsl*(initvalu_32-initvalu_33) +
                            j_na_slmyo*oneovervsl*(initvalu_34-initvalu_33)-finavalu[offset_18] in
  let finavalu[offset_34] = j_na_slmyo/vmyo*(initvalu_33-initvalu_34) -- [mM/msec] 
  in
  -- Potassium Concentration
  let i_K_tot = i_to+i_kr+i_ks+i_ki-2.0f32*i_nak+i_CaK+i_kp in -- [uA/uF]
  let finavalu[offset_35] = 0.0f32 -- [mM/msec]
  in
  -- Calcium Concentrations
  let i_Ca_tot_junc = i_Ca_junc+i_cabk_junc+i_pca_junc-2.0f32*i_ncx_junc in -- [uA/uF]
  let i_Ca_tot_sl = i_Ca_sl+i_cabk_sl+i_pca_sl-2.0f32*i_ncx_sl in -- [uA/uF]
  let finavalu[offset_36] = -i_Ca_tot_junc*cmem/(vjunc*2.0f32*frdy)+
                            j_ca_juncsl/vjunc*(initvalu_37-initvalu_36) - 
                            j_CaB_junction+(j_SRCarel)*vsr/vjunc+j_SRleak*vmyo/vjunc in -- Ca_j
  let finavalu[offset_37] = -i_Ca_tot_sl*cmem/(vsl*2.0f32*frdy) + 
                            j_ca_juncsl/vsl*(initvalu_36-initvalu_37) +
                            j_ca_slmyo/vsl*(initvalu_38-initvalu_37)-j_CaB_sl in -- Ca_sl
  let finavalu[offset_38] = -j_serca-j_CaB_cytosol +j_ca_slmyo/vmyo*(initvalu_37-initvalu_38) in
  let junc_sl=j_ca_juncsl/vsl*(initvalu_36-initvalu_37) in
  let sl_junc=j_ca_juncsl/vjunc*(initvalu_37-initvalu_36) in
  let sl_myo=j_ca_slmyo/vsl*(initvalu_38-initvalu_37) in
  let myo_sl=j_ca_slmyo/vmyo*(initvalu_37-initvalu_38) 
  in
  let i_app = if(fmod(timeinst,parameter_1) <= 5.0f32)
              then 9.5f32 else 0.0f32
  in
  -- Membrane Potential
  let i_Na_tot = i_Na_tot_junc + i_Na_tot_sl in -- [uA/uF]
  let i_Cl_tot = i_ClCa+i_Clbk in -- [uA/uF]
  let i_Ca_tot = i_Ca_tot_junc + i_Ca_tot_sl in
  let i_tot = i_Na_tot+i_Cl_tot+i_Ca_tot+i_K_tot in
  let finavalu[offset_39] = -(i_tot-i_app) 
  in
  -- Set unused output values to 0 (MATLAB does it by default)
  let finavalu[offset_41] = 0.0f32 in
  let finavalu[offset_42] = 0.0f32 in
  finavalu


----------------------
----- Cam MODULE -----
----------------------

fun (f32, *[equs]f32) cam( f32 timeinst, [equs]f32 initvalu, 
                            int initvalu_offset,
                            [pars]f32 parameter, int parameter_offset, 
                            *[equs]f32 finavalu, f32 ca ) =
  unsafe 

  -- input data and output data variable references
  let offset_1  = initvalu_offset in
  let offset_2  = initvalu_offset+1 in
  let offset_3  = initvalu_offset+2 in
  let offset_4  = initvalu_offset+3 in
  let offset_5  = initvalu_offset+4 in
  let offset_6  = initvalu_offset+5 in
  let offset_7  = initvalu_offset+6 in
  let offset_8  = initvalu_offset+7 in
  let offset_9  = initvalu_offset+8 in
  let offset_10 = initvalu_offset+9 in
  let offset_11 = initvalu_offset+10 in
  let offset_12 = initvalu_offset+11 in
  let offset_13 = initvalu_offset+12 in
  let offset_14 = initvalu_offset+13 in
  let offset_15 = initvalu_offset+14
  in
  -- input parameters variable references
  let parameter_offset_1  = parameter_offset in
  let parameter_offset_2  = parameter_offset+1 in
  let parameter_offset_3  = parameter_offset+2 in
  let parameter_offset_4  = parameter_offset+3 in
  let parameter_offset_5  = parameter_offset+4 
  in
  -- decoding input array
  let caM   = initvalu[offset_1] in
  let ca2caM  = initvalu[offset_2] in
  let ca4caM  = initvalu[offset_3] in
  let caMB    = initvalu[offset_4] in
  let ca2caMB = initvalu[offset_5] in
  let ca4caMB = initvalu[offset_6] in           
  let pb2     = initvalu[offset_7] in
  let pb      = initvalu[offset_8] in
  let pt      = initvalu[offset_9] in
  let pt2     = initvalu[offset_10] in
  let pa      = initvalu[offset_11] in                            
  let ca4caN  = initvalu[offset_12] in
  let caMca4caN = initvalu[offset_13] in
  let ca2caMca4caN = initvalu[offset_14] in
  let ca4caMca4caN = initvalu[offset_15] 
  in
  -- decoding input parameters
  let caMtot    = parameter[parameter_offset_1] in
  let btot      = parameter[parameter_offset_2] in
  let caMKiitot = parameter[parameter_offset_3] in
  let caNtot    = parameter[parameter_offset_4] in
  let pp1tot    = parameter[parameter_offset_5] 
  in
  -- values [CONSTANTS FOR ALL THREADS]
  let k = 135.0f32 in
  let mg = 1.0f32  
  in
  -- ca/caM parameters
  let (kd02, kd24) = if (mg <= 1.0f32)
                     then ( 0.0025f32*(1.0f32+k/0.94f32-mg/0.012f32)*(1.0f32+k/8.1f32+mg/0.022f32),
                            0.128f32*(1.0f32+k/0.64f32+mg/0.0014f32)*(1.0f32+k/13.0f32-mg/0.153f32)
                          )
                     else ( 0.0025f32*(1.0f32+k/0.94f32-1.0f32/0.012f32+(mg-1.0f32)/0.060f32) *
                                (1.0f32+k/8.1f32+1.0f32/0.022f32+(mg-1.0f32)/0.068f32),
                            0.128f32*(1.0f32+k/0.64f32+1.0f32/0.0014f32+(mg-1.0f32)/0.005f32) *
                                (1.0f32+k/13.0f32-1.0f32/0.153f32+(mg-1.0f32)/0.150f32)
                          )
  in
  let k20 = 10.0f32  in -- [s^-1]      
  let k02 = k20/kd02 in -- [uM^-2 s^-1]
  let k42 = 500.0f32 in -- [s^-1]      
  let k24 = k42/kd24    -- [uM^-2 s^-1]
  in
  -- caM buffering (B) parameters
  let k0Boff = 0.0014f32 in -- [s^-1] 
  let k0Bon = k0Boff/0.2f32 in -- [uM^-1 s^-1] kon = koff/kd
  let k2Boff = k0Boff/100.0f32 in -- [s^-1] 
  let k2Bon = k0Bon in -- [uM^-1 s^-1]
  let k4Boff = k2Boff in -- [s^-1]
  let k4Bon = k0Bon      -- [uM^-1 s^-1]
  in
  -- using thermodynamic constraints
  let k20B = k20/100.0f32 in -- [s^-1] thermo constraint on loop 1
  let k02B = k02 in -- [uM^-2 s^-1] 
  let k42B = k42 in -- [s^-1] thermo constraint on loop 2
  let k24B = k24    -- [uM^-2 s^-1]
  in
  -- Wi Wa Wt Wp
  let kbi = 2.2f32 in -- [s^-1] (ca4caM dissocation from Wb)
  let kib = kbi/33.5e-3f32 in -- [uM^-1 s^-1]
  let kpp1 = 1.72f32 in -- [s^-1] (pp1-dep dephosphorylation rates)
  let kmpp1 = 11.5f32 in -- []uM
  let kib2 = kib in
  let kb2i = kib2*5.0f32 in
  let kb24 = k24 in
  let kb42 = k42*33.5e-3f32/5.0f32 in
  let kta = kbi/1000.0f32 in -- [s^-1] (ca4caM dissociation from Wt)
  let kat = kib in -- [uM^-1 s^-1] (ca4caM reassociation with Wa)
  let kt42 = k42*33.5e-6f32/5.0f32 in
  let kt24 = k24 in
  let kat2 = kib in
  let kt2a = kib*5.0f32
  in
  -- caN parameters
  let kcancaoff = 1.0f32 in -- [s^-1] 
  let kcancaon = kcancaoff/0.5f32 in -- [uM^-1 s^-1] 
  let kcancaM4on = 46.0f32 in -- [uM^-1 s^-1]
  let kcancaM4off = 0.0013f32 in -- [s^-1]
  let kcancaM2on = kcancaM4on in
  let kcancaM2off = 2508.0f32*kcancaM4off in
  let kcancaM0on = kcancaM4on in
  let kcancaM0off = 165.0f32*kcancaM2off in
  let k02can = k02 in
  let k20can = k20/165.0f32 in
  let k24can = k24 in
  let k42can = k20/2508.0f32 
  in
  -- caM Reaction fluxes
  let rcn02 = k02*pow(ca,2.0f32)*caM - k20*ca2caM in
  let rcn24 = k24*pow(ca,2.0f32)*ca2caM - k42*ca4caM
  in
  -- caM buffer fluxes
  let b = btot - caMB - ca2caMB - ca4caMB in
  let rcn02B = k02B*pow(ca,2.0f32)*caMB - k20B*ca2caMB in
  let rcn24B = k24B*pow(ca,2.0f32)*ca2caMB - k42B*ca4caMB in
  let rcn0B = k0Bon*caM*b - k0Boff*caMB in
  let rcn2B = k2Bon*ca2caM*b - k2Boff*ca2caMB in
  let rcn4B = k4Bon*ca4caM*b - k4Boff*ca4caMB 
  in
  -- caN reaction fluxes 
  let ca2caN = caNtot - ca4caN - caMca4caN - ca2caMca4caN - ca4caMca4caN in
  let rcnca4caN = kcancaon*pow(ca,2.0f32)*ca2caN - kcancaoff*ca4caN in
  let rcn02caN = k02can*pow(ca,2.0f32)*caMca4caN - k20can*ca2caMca4caN in
  let rcn24caN = k24can*pow(ca,2.0f32)*ca2caMca4caN - k42can*ca4caMca4caN in
  let rcn0caN = kcancaM0on*caM*ca4caN - kcancaM0off*caMca4caN in
  let rcn2caN = kcancaM2on*ca2caM*ca4caN - kcancaM2off*ca2caMca4caN in
  let rcn4caN = kcancaM4on*ca4caM*ca4caN - kcancaM4off*ca4caMca4caN 
  in
  -- caMkii reaction fluxes
  let pix = 1.0f32 - pb2 - pb - pt - pt2 - pa in
  let rcnCkib2 = kib2*ca2caM*pix - kb2i*pb2 in
  let rcnCkb2b = kb24*pow(ca,2.0f32)*pb2 - kb42*pb in
  let rcnCkib = kib*ca4caM*pix - kbi*pb in
  let t = pb + pt + pt2 + pa in
  let kbt = 0.055f32 * t + 0.0074f32 * pow(t,2.0f32) + 0.015f32*pow(t,3.0f32) in
  let rcnCkbt = kbt*pb - kpp1*pp1tot*pt/(kmpp1+caMKiitot*pt) in
  let rcnCktt2 = kt42*pt - kt24*pow(ca,2.0f32)*pt2 in
  let rcnCkta = kta*pt - kat*ca4caM*pa in
  let rcnCkt2a = kt2a*pt2 - kat2*ca2caM*pa in
  let rcnCkt2b2 = kpp1*pp1tot*pt2/(kmpp1+caMKiitot*pt2) in
  let rcnCkai = kpp1*pp1tot*pa/(kmpp1+caMKiitot*pa)
  in
  -- caM equations
  let dcaM = 1e-3f32*(-rcn02 - rcn0B - rcn0caN) in
  let dca2caM = 1e-3f32*(rcn02 - rcn24 - rcn2B - rcn2caN + caMKiitot*(-rcnCkib2 + rcnCkt2a) ) in
  let dca4caM = 1e-3f32*(rcn24 - rcn4B - rcn4caN + caMKiitot*(-rcnCkib+rcnCkta) ) in
  let dcaMB = 1e-3f32*(rcn0B-rcn02B) in
  let dca2caMB = 1e-3f32*(rcn02B + rcn2B - rcn24B) in
  let dca4caMB = 1e-3f32*(rcn24B + rcn4B) 
  in
  -- caMkii equations
  let dpb2 = 1e-3f32*(rcnCkib2 - rcnCkb2b + rcnCkt2b2) in -- pb2
  let dpb = 1e-3f32*(rcnCkib + rcnCkb2b - rcnCkbt) in -- pb
  let dpt = 1e-3f32*(rcnCkbt-rcnCkta-rcnCktt2) in -- pt
  let dpt2 = 1e-3f32*(rcnCktt2-rcnCkt2a-rcnCkt2b2) in -- pt2
  let dpa = 1e-3f32*(rcnCkta+rcnCkt2a-rcnCkai)        -- pa
  in
  -- caN equations
  let dca4caN = 1e-3f32*(rcnca4caN - rcn0caN - rcn2caN - rcn4caN) in -- ca4caN
  let dcaMca4caN = 1e-3f32*(rcn0caN - rcn02caN) in           -- caMca4caN
  let dca2caMca4caN = 1e-3f32*(rcn2caN+rcn02caN-rcn24caN) in -- ca2caMca4caN
  let dca4caMca4caN = 1e-3f32*(rcn4caN+rcn24caN)             -- ca4caMca4caN
  in
  -- encode output array
  let finavalu[offset_1] = dcaM in
  let finavalu[offset_2] = dca2caM in
  let finavalu[offset_3] = dca4caM in
  let finavalu[offset_4] = dcaMB in
  let finavalu[offset_5] = dca2caMB in
  let finavalu[offset_6] = dca4caMB in
  let finavalu[offset_7] = dpb2 in
  let finavalu[offset_8] = dpb in
  let finavalu[offset_9] = dpt in
  let finavalu[offset_10] = dpt2 in
  let finavalu[offset_11] = dpa in
  let finavalu[offset_12] = dca4caN in
  let finavalu[offset_13] = dcaMca4caN in
  let finavalu[offset_14] = dca2caMca4caN in
  let finavalu[offset_15] = dca4caMca4caN
  in
  -- write to global variables for adjusting ca buffering in EC coupling model
  let jca = 1e-3f32*(2.0f32*caMKiitot*(rcnCktt2-rcnCkb2b) -
            2.0f32*(rcn02+rcn24+rcn02B+rcn24B+rcnca4caN+rcn02caN+rcn24caN)) -- [uM/msec]
  in ( jca, finavalu)

----------------------
----- Fin MODULE -----
----------------------

fun *[equs]f32 fin(    [equs]f32 initvalu, int initvalu_offset_ecc,
                        int initvalu_offset_Dyad, int initvalu_offset_SL,
                        int initvalu_offset_Cyt, [pars]f32 parameter,
                        *[equs]f32 finavalu, f32 jcaDyad, f32 jcaSL, f32 jcaCyt ) =
  unsafe

  let btotDyad      = parameter[2] in
  let caMKiitotDyad = parameter[3] 
  in
  -- set variables
  let vmyo = 2.1454e-11f32 in
  let vdyad = 1.7790e-14f32 in
  let vsl = 6.6013e-13f32 in
  let kDyadSL = 3.6363e-16f32 in
  let kSLmyo = 8.587e-15f32 in
  let k0Boff = 0.0014f32 in
  let k0Bon = k0Boff/0.2f32 in
  let k2Boff = k0Boff/100.0f32 in
  let k2Bon = k0Bon in
  let k4Boff = k2Boff in
  let k4Bon = k0Bon
  in
  -- ADJUST ECC incorporate ca buffering from caM, convert jcaCyt from uM/msec to mM/msec
  let finavalu[initvalu_offset_ecc+35] = finavalu[initvalu_offset_ecc+35] + 1e-3f32*jcaDyad in
  let finavalu[initvalu_offset_ecc+36] = finavalu[initvalu_offset_ecc+36] + 1e-3f32*jcaSL in
  let finavalu[initvalu_offset_ecc+37] = finavalu[initvalu_offset_ecc+37] + 1e-3f32*jcaCyt
  in
  -- incorporate caM diffusion between compartments
  let caMtotDyad =    initvalu[initvalu_offset_Dyad+0]
                    + initvalu[initvalu_offset_Dyad+1]
                    + initvalu[initvalu_offset_Dyad+2]
                    + initvalu[initvalu_offset_Dyad+3]
                    + initvalu[initvalu_offset_Dyad+4]
                    + initvalu[initvalu_offset_Dyad+5]
                    + caMKiitotDyad * (  initvalu[initvalu_offset_Dyad+6]
                                    + initvalu[initvalu_offset_Dyad+7]
                                    + initvalu[initvalu_offset_Dyad+8]
                                    + initvalu[initvalu_offset_Dyad+9])
                    + initvalu[initvalu_offset_Dyad+12]
                    + initvalu[initvalu_offset_Dyad+13]
                    + initvalu[initvalu_offset_Dyad+14]
  in
  let bdyad = btotDyad - caMtotDyad in -- [uM dyad]
  let j_cam_dyadSL = 1e-3f32 * (  k0Boff*initvalu[initvalu_offset_Dyad+0] - 
                        k0Bon*bdyad*initvalu[initvalu_offset_SL+0]) in -- [uM/msec dyad]
  let j_ca2cam_dyadSL = 1e-3f32 * (  k2Boff*initvalu[initvalu_offset_Dyad+1] - 
                        k2Bon*bdyad*initvalu[initvalu_offset_SL+1]) in -- [uM/msec dyad]
  let j_ca4cam_dyadSL = 1e-3f32 * (  k2Boff*initvalu[initvalu_offset_Dyad+2] - 
                        k4Bon*bdyad*initvalu[initvalu_offset_SL+2])    -- [uM/msec dyad]
  in
  let j_cam_SLmyo    = kSLmyo * (  initvalu[initvalu_offset_SL+0] - initvalu[initvalu_offset_Cyt+0]) in -- [umol/msec]
  let j_ca2cam_SLmyo = kSLmyo * (  initvalu[initvalu_offset_SL+1] - initvalu[initvalu_offset_Cyt+1]) in -- [umol/msec]
  let j_ca4cam_SLmyo = kSLmyo * (  initvalu[initvalu_offset_SL+2] - initvalu[initvalu_offset_Cyt+2])    -- [umol/msec]
  in
  -- ADJUST CAM Dyad 
  let finavalu[initvalu_offset_Dyad+0] = finavalu[initvalu_offset_Dyad+0] - j_cam_dyadSL in
  let finavalu[initvalu_offset_Dyad+1] = finavalu[initvalu_offset_Dyad+1] - j_ca2cam_dyadSL in
  let finavalu[initvalu_offset_Dyad+2] = finavalu[initvalu_offset_Dyad+2] - j_ca4cam_dyadSL
  in
  -- ADJUST CAM Sl
  let finavalu[initvalu_offset_SL+0] = finavalu[initvalu_offset_SL+0] + j_cam_dyadSL*vdyad/vsl - j_cam_SLmyo/vsl in
  let finavalu[initvalu_offset_SL+1] = finavalu[initvalu_offset_SL+1] + j_ca2cam_dyadSL*vdyad/vsl - j_ca2cam_SLmyo/vsl in
  let finavalu[initvalu_offset_SL+2] = finavalu[initvalu_offset_SL+2] + j_ca4cam_dyadSL*vdyad/vsl - j_ca4cam_SLmyo/vsl
  in
  -- ADJUST CAM Cyt 
  let finavalu[initvalu_offset_Cyt+0] = finavalu[initvalu_offset_Cyt+0] + j_cam_SLmyo/vmyo in
  let finavalu[initvalu_offset_Cyt+1] = finavalu[initvalu_offset_Cyt+1] + j_ca2cam_SLmyo/vmyo in
  let finavalu[initvalu_offset_Cyt+2] = finavalu[initvalu_offset_Cyt+2] + j_ca4cam_SLmyo/vmyo
  in finavalu

-------------------------
----- Master MODULE -----
-------------------------

--fun f32  inf() = 1.0f32 / 0.0f32
--fun f32 minf() = 0.0f32 - inf()
--fun f32  nan() = inf()  / inf()
--fun f32 mnan() = 0.0f32 - nan()

--fun bool isnan(f32 x) = let xp = fabs(x) in pow(xp,0.5f32) != sqrt32(xp)
--fun bool isinf(f32 x) = ( x == inf() || x == minf() )

fun *[equs]f32 master( f32 timeinst, [equs]f32 initvalu, [pars]f32 parameter ) =
  let finavalu = replicate(equs, 0.0f32) in
  -- ecc function
  let initvalu_offset_ecc  = 0 in
  let parameter_offset_ecc = 0 in
  let finavalu = ecc( timeinst, initvalu, initvalu_offset_ecc, parameter, parameter_offset_ecc, finavalu)
  in
  let jcaDyad = 0.0f32 in
  let jcaSL   = 0.0f32 in
  let jcaCyt  = 0.0f32 in
  loop ((jcaDyad, jcaSL, jcaCyt, finavalu)) = for ii < 3 do
        let (initvalu_offset, parameter_offset, ind) = 
            if      (ii == 0) then -- cam function for Dyad
                ( 46, 1, 35 ) 
            else if (ii == 1) then -- cam function for SL
                ( 61, 6, 36 ) 
            else -- if (ii == 2) then -- cam function for Cyt
                ( 76, 11, 37 )
        in
        let inp_val = unsafe (initvalu[ind]*1e3f32) in
        let (res_val, finavalu) = cam(  timeinst, initvalu, initvalu_offset, parameter,
                                        parameter_offset, finavalu, inp_val )
        in
        let ( jcaDyad, jcaSL, jcaCyt ) = 
            if      (ii == 0) then ( res_val, jcaSL,   jcaCyt )
            else if (ii == 1) then ( jcaDyad, res_val, jcaCyt )
            else                   ( jcaDyad, jcaSL,   res_val)
        in  ( jcaDyad, jcaSL, jcaCyt, finavalu)
  in
  -- final adjustments
  let finavalu = fin(  initvalu, initvalu_offset_ecc, 46, 61, 76, 
                       parameter, finavalu, jcaDyad, jcaSL, jcaCyt ) 
  in
  map(fn f32 (f32 x) => 
        if ( isnan32(x) || isinf32(x) ) 
        then 0.0001f32
        else x 
     , finavalu)


----------------------------------------
----- embedded_fehlberg_7_8 MODULE -----
----------------------------------------

fun (*[equs]f32, *[equs]f32) 
embedded_fehlberg_7_8(  f32 timeinst, f32 h,
                        [equs]f32  initvalu,
                        [pars]f32  parameter ) =
  let c_1_11 = 41.0f32 / 840.0f32 in
  let c6 = 34.0f32 / 105.0f32 in
  let c_7_8= 9.0f32 / 35.0f32 in
  let c_9_10 = 9.0f32 / 280.0f32 in

  let a2 = 2.0f32 / 27.0f32 in
  let a3 = 1.0f32 / 9.0f32 in
  let a4 = 1.0f32 / 6.0f32 in
  let a5 = 5.0f32 / 12.0f32 in
  let a6 = 1.0f32 / 2.0f32 in
  let a7 = 5.0f32 / 6.0f32 in
  let a8 = 1.0f32 / 6.0f32 in
  let a9 = 2.0f32 / 3.0f32 in
  let a10 = 1.0f32 / 3.0f32 in

  let b31 = 1.0f32 / 36.0f32 in
  let b32 = 3.0f32 / 36.0f32 in
  let b41 = 1.0f32 / 24.0f32 in
  let b43 = 3.0f32 / 24.0f32 in
  let b51 = 20.0f32 / 48.0f32 in
  let b53 = -75.0f32 / 48.0f32 in
  let b54 = 75.0f32 / 48.0f32 in
  let b61 = 1.0f32 / 20.0f32 in
  let b64 = 5.0f32 / 20.0f32 in
  let b65 = 4.0f32 / 20.0f32 in
  let b71 = -25.0f32 / 108.0f32 in
  let b74 =  125.0f32 / 108.0f32 in
  let b75 = -260.0f32 / 108.0f32 in
  let b76 =  250.0f32 / 108.0f32 in
  let b81 = 31.0f32/300.0f32 in
  let b85 = 61.0f32/225.0f32 in
  let b86 = -2.0f32/9.0f32 in
  let b87 = 13.0f32/900.0f32 in
  let b91 = 2.0f32 in
  let b94 = -53.0f32/6.0f32 in
  let b95 = 704.0f32 / 45.0f32 in
  let b96 = -107.0f32 / 9.0f32 in
  let b97 = 67.0f32 / 90.0f32 in
  let b98 = 3.0f32 in
  let b10_1 = -91.0f32 / 108.0f32 in
  let b10_4 = 23.0f32 / 108.0f32 in
  let b10_5 = -976.0f32 / 135.0f32 in
  let b10_6 = 311.0f32 / 54.0f32 in
  let b10_7 = -19.0f32 / 60.0f32 in
  let b10_8 = 17.0f32 / 6.0f32 in
  let b10_9 = -1.0f32 / 12.0f32 in
  let b11_1 = 2383.0f32 / 4100.0f32 in
  let b11_4 = -341.0f32 / 164.0f32 in
  let b11_5 = 4496.0f32 / 1025.0f32 in
  let b11_6 = -301.0f32 / 82.0f32 in
  let b11_7 = 2133.0f32 / 4100.0f32 in
  let b11_8 = 45.0f32 / 82.0f32 in
  let b11_9 = 45.0f32 / 164.0f32 in
  let b11_10 = 18.0f32 / 41.0f32 in
  let b12_1 = 3.0f32 / 205.0f32 in
  let b12_6 = - 6.0f32 / 41.0f32 in
  let b12_7 = - 3.0f32 / 205.0f32 in
  let b12_8 = - 3.0f32 / 41.0f32 in
  let b12_9 = 3.0f32 / 41.0f32 in
  let b12_10 = 6.0f32 / 41.0f32 in
  let b13_1 = -1777.0f32 / 4100.0f32 in
  let b13_4 = -341.0f32 / 164.0f32 in
  let b13_5 = 4496.0f32 / 1025.0f32 in
  let b13_6 = -289.0f32 / 82.0f32 in
  let b13_7 = 2193.0f32 / 4100.0f32 in
  let b13_8 = 51.0f32 / 82.0f32 in
  let b13_9 = 33.0f32 / 164.0f32 in
  let b13_10 = 12.0f32 / 41.0f32 in

  let err_factor  = -41.0f32 / 840.0f32 in
  let h2_7 = a2 * h in
  
  -- initvalu_temp[equations]
  -- finavalu_temp[13, equations]
  let finavalu_temp = replicate(13, replicate(equs, 0.0f32)) in

  loop (finavalu_temp) = for ii < 13 do
    let ( timeinst_temp, initvalu_temp ) = 
        if      (ii == 0) then 
            ( timeinst, initvalu )
        else if (ii == 1) then
            let timeinst_temp = timeinst + h2_7 in
            let initvalu_temp = map( fn f32 ((f32,f32) xy) => let (x,y) = xy in x + h2_7 * y
                                    , zip(initvalu,finavalu_temp[0]) ) in
             ( timeinst_temp, initvalu_temp )
        else if (ii == 2) then
            let timeinst_temp = timeinst + a3*h in
            let initvalu_temp = map( fn f32 ((f32,f32,f32) xy) => 
                                        let (x,y1,y2) = xy in 
                                        x + h * ( b31*y1 + b32*y2 )
                                   , zip(initvalu,finavalu_temp[0],finavalu_temp[1]) ) in
            ( timeinst_temp, initvalu_temp )
        else if (ii == 3) then
            let timeinst_temp = timeinst + a4*h in
            let initvalu_temp = map( fn f32 ((f32,f32,f32) xy) => 
                                        let (x,y1,y2) = xy in 
                                        x + h * ( b41*y1 + b43*y2 )
                                   , zip(initvalu,finavalu_temp[0],finavalu_temp[2]) ) in
            ( timeinst_temp, initvalu_temp )
        else if (ii == 4) then
            let timeinst_temp = timeinst + a5*h in
            let initvalu_temp = map( fn f32 (int i) => 
                                        initvalu[i] + h * ( b51*finavalu_temp[0,i] + 
                                        b53*finavalu_temp[2,i] + b54*finavalu_temp[3,i])
                                   , iota(equs) ) in
            ( timeinst_temp, initvalu_temp )
        else if (ii == 5) then
            let timeinst_temp = timeinst + a6*h in
            let initvalu_temp = map( fn f32 (int i) => 
                                        initvalu[i] + h * ( b61*finavalu_temp[0,i] + 
                                        b64*finavalu_temp[3,i] + b65*finavalu_temp[4,i] )
                                   , iota(equs) ) in
            ( timeinst_temp, initvalu_temp )
        else if (ii == 6) then
              let timeinst_temp = timeinst + a7 * h in
              let initvalu_temp = map( fn f32 (int i) => 
                                        initvalu[i] + h * ( b71*finavalu_temp[0,i] + 
                                        b74*finavalu_temp[3,i] + b75*finavalu_temp[4,i] + 
                                        b76*finavalu_temp[5,i] )
                                     , iota(equs) ) in
              ( timeinst_temp, initvalu_temp )
        else if (ii == 7) then
              let timeinst_temp = timeinst + a8 * h in
              let initvalu_temp = map( fn f32 (int i) => 
                                        initvalu[i] + h * ( b81*finavalu_temp[0,i] + 
                                        b85*finavalu_temp[4,i] + b86*finavalu_temp[5,i] + 
                                        b87*finavalu_temp[6,i] )
                                     , iota(equs) ) in
              ( timeinst_temp, initvalu_temp )
        else if (ii == 8) then
            let timeinst_temp = timeinst + a9*h in
            let initvalu_temp = map( fn f32 (int i) => 
                                        initvalu[i] + h * ( b91*finavalu_temp[0,i] + 
                                        b94*finavalu_temp[3,i] + b95*finavalu_temp[4,i] + 
                                        b96*finavalu_temp[5,i] + b97*finavalu_temp[6,i] + 
                                        b98*finavalu_temp[7,i] )
                                   , iota(equs) ) in
            ( timeinst_temp, initvalu_temp )
        else if (ii == 9) then
            let timeinst_temp = timeinst + a10*h in
            let initvalu_temp = map( fn f32 (int i) => 
                                        initvalu[i] + h * ( b10_1*finavalu_temp[0,i] + 
                                        b10_4*finavalu_temp[3,i] + b10_5*finavalu_temp[4,i] + 
                                        b10_6*finavalu_temp[5,i] + b10_7*finavalu_temp[6,i] + 
                                        b10_8*finavalu_temp[7,i] + b10_9*finavalu_temp[8,i] )
                                   , iota(equs) ) in
            ( timeinst_temp, initvalu_temp )
        else if (ii == 10) then
            let timeinst_temp = timeinst + h in
            let initvalu_temp = map( fn f32 (int i) => 
                                        initvalu[i] + h * ( b11_1*finavalu_temp[0,i] + 
                                        b11_4*finavalu_temp[3,i] + b11_5*finavalu_temp[4,i] + 
                                        b11_6*finavalu_temp[5,i] + b11_7*finavalu_temp[6,i] + 
                                        b11_8*finavalu_temp[7,i] + b11_9*finavalu_temp[8,i] + 
                                        b11_10 * finavalu_temp[9,i])
                                   , iota(equs) ) in
            ( timeinst_temp, initvalu_temp )
        else if (ii == 11) then
            let timeinst_temp = timeinst in
            let initvalu_temp = map( fn f32 (int i) => 
                                        initvalu[i] + h * ( b12_1*finavalu_temp[0,i] + 
                                        b12_6*finavalu_temp[5,i] + b12_7*finavalu_temp[6,i] + 
                                        b12_8*finavalu_temp[7,i] + b12_9*finavalu_temp[8,i] + 
                                        b12_10 * finavalu_temp[9,i] )
                                   , iota(equs) ) in
            ( timeinst_temp, initvalu_temp )
        else -- if (ii == 12) then
            let timeinst_temp = timeinst + h in
            let initvalu_temp = map( fn f32 (int i) => 
                                        initvalu[i] + h * ( b13_1*finavalu_temp[0,i] + 
                                        b13_4*finavalu_temp[3,i] + b13_5*finavalu_temp[4,i] + 
                                        b13_6*finavalu_temp[5,i] + b13_7*finavalu_temp[6,i] + 
                                        b13_8*finavalu_temp[7,i] + b13_9*finavalu_temp[8,i] + 
                                        b13_10*finavalu_temp[9,i] + finavalu_temp[11,i] )
                                   , iota(equs) ) in
            ( timeinst_temp, initvalu_temp )
    in unsafe 
    let finavalu_temp[ii] = master( timeinst_temp, initvalu_temp, parameter ) in
    finavalu_temp
  --------------
  -- end loop --
  --------------
  in
  let finavalu = map( fn f32 (int i) =>
                        initvalu[i] +  h * (c_1_11 * (finavalu_temp[0,i] + finavalu_temp[10,i]) +
                            c6 * finavalu_temp[5,i] + c_7_8 * (finavalu_temp[6,i] + finavalu_temp[7,i]) +
                            c_9_10 * (finavalu_temp[8,i] + finavalu_temp[9,i]) )
                    , iota(equs) )
  in 
  let error = map( fn f32 (int i) =>
                        fabs(err_factor * (finavalu_temp[0,i] + finavalu_temp[10,i] - finavalu_temp[11,i] - finavalu_temp[12,i]))
                 , iota(equs) )
  in ( finavalu, error )


-------------------------
----- SOLVER MODULE -----
-------------------------

fun f32 min_scale_factor() = 0.125f32
fun f32 max_scale_factor() = 4.0f32
fun int attempts()         = 12

fun f32 max(f32 x, f32 y) = if ( x < y ) then y else x
fun f32 min(f32 x, f32 y) = if ( x < y ) then x else y

fun (bool,[equs]f32) 
solver(int xmax, [pars]f32 params, [equs]f32 y0) =
  let err_exponent  = 1.0f32 / 7.0f32 in
  let last_interval = 0.0f32 in
  let h_init = 1.0f32 in
  let h = h_init in
  let xmin = 0 in
  let tolerance = 10.0f32 / f32(xmax-xmin) in
  let y_km1  = y0 in -- copy(y0)

  if (xmax < xmin || h <= 0.0f32) then ( False, y_km1 )
  else if ( xmax == xmin ) then ( True, y_km1 )
  else 
  let (h, last_interval) = if (h > f32(xmax - xmin) )
                           then ( f32(xmax - xmin), 1.0f32 )
                           else ( h, last_interval )
  in
  -- initialize return and loop-variant params
  let failed = False in
  let km1    = 0     in
  loop((km1, failed, y_km1)) = while ( (!failed) && (km1 < xmax) ) do -- for km1 < xmax do
    -- reinitialize variables
    let h          = h_init in
    let scale_fina = 1.0f32 in
    let y_k = replicate(equs, 0.0f32) in
    
    -- make attempts to minimize error
    let breakLoop  = False  in
    let j = 0 in
    loop((j,h,y_k,breakLoop,scale_fina)) = while ( (!breakLoop) && (j < attempts()) ) do
      -- REiNiTiALiZE ALL VAriABLES
      let error   = 0 in
      let outside = 0 in
      let scale_min = max_scale_factor() in

      -- EVALUATE ALL equations
      let (y_k, err) = reshape( (equs), embedded_fehlberg_7_8( f32(km1), h, y_km1, params) ) in
      
      -- iF THERE WAS NO ERROR FOR ANY OF equations, SET SCALE AND LEAVE THE LOOP
      let errs = map( fn bool (f32 e) => if e > 0.0f32 then True else False, err ) in
      let error= reduce(||, False, errs) in

--      let {breakLoop, scale_fina} = if(!error)
--                                    then {True,  max_scale_factor()}
--                                    else {False, scale_fina}

      if (!error)
      then (j+1, h, y_k, True, max_scale_factor())
      else 
      -- FiGURE OUT SCALE AS THE MiNiMUM OF COMPONENT SCALES
      let yy = map( fn f32 (f32 x) =>
                        if (x == 0.0f32) then tolerance else fabs(x)
                  , y_km1 )
      in
      let scale = map ( fn f32 ((f32,f32) yy_erri) =>
                            let (yyi, erri) = yy_erri in
                            0.8f32 * pow( tolerance * yyi / erri , err_exponent )
                      , zip(yy,err) )
      in
      let scale_min = reduce(min, scale_min, scale) in
      let scale_fina = min( max(scale_min,min_scale_factor()), max_scale_factor())
      in
      -- iF WiTHiN TOLERANCE, FiNiSH attempts...
      let tmps =map ( fn bool ((f32,f32) err_yyi) =>
                        let (erri, yyi) = err_yyi in
                        erri <= ( tolerance * yyi )
                    , zip(err, yy) ) in
      let breakLoop = reduce (&&, True, tmps) in

      -- ...OTHERWiSE, ADJUST STEP FOR NEXT ATTEMPT
      -- scale next step in a default way
      let h = h * scale_fina in

      -- limit step to 0.9, because when it gets close to 1, it no longer
      -- makes sense, as 1 is already the next time instance
      -- (added to original algorithm)
      let h = if (h >= 0.9f32) then 0.9f32 else h
      in
      -- if instance+step exceeds range limit, limit to that range
      let h = if ( f32(km1) + h > f32(xmax) ) then f32(xmax - km1)
              else if ( f32(km1) + h + 0.5f32 * h > f32(xmax) )
                   then 0.5f32 * h else h
      in (j+1, h, y_k, breakLoop, scale_fina)
    in ( km1+1, !breakLoop, y_k )
  in (!failed,y_km1)

-----------------------
----- MAiN MODULE -----
-----------------------

fun int equations () = 91
fun int parameters() = 16

fun (bool, [workload][91]f32)
main(int repeat, f32 eps, int workload, int xmax, [91]f32 y0, [16]f32 params) =
  let (oks, y_res) = unzip (
    map ( fn (bool,[91]f32) (int i) =>
            let add_fact = f32(i % repeat)*eps in
            let y_row = map(+add_fact, y0) in
            solver(xmax, params, y_row)
        , iota(workload) ) )
  in
  ( reduce(&&, True, oks), y_res )



fun ([91]f32, [91]f32)
main_EMBEDDED(int xmax, [workload][91]f32 y, [workload][16]f32 params) =
    embedded_fehlberg_7_8( 0.0f32, 1.0f32, y[0], params[0])

fun (f32, [91]f32)
main_ECC_CAM(int xmax, [workload][91]f32 y, [workload][16]f32 params) =
    let finavalu = replicate(91, 0.0f32) in
    let finavalu = ecc( 0.0f32, y[0], 0, params[0], 0, finavalu ) in
    let (res_val, finavalu) = cam(  0.0f32, y[0], 46, params[0],  
                                    1, finavalu, y[0, 35]*1e3f32 )
    in (res_val, finavalu)

fun [91]f32
main_MASTER(int xmax, [workload][91]f32 y, [workload][16]f32 params) =
    master( 0.0f32, y[0], params[0] ) 
