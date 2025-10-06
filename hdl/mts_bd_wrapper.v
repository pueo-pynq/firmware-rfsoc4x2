//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
//Date        : Wed Feb 14 13:30:37 2024
//Host        : ASCPHY-NC196428 running 64-bit major release  (build 9200)
//Command     : generate_target mts_bd_wrapper.bd
//Design      : mts_bd_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module mts_bd_wrapper
   (S_AXIS_0_tdata,
    S_AXIS_0_tready,
    S_AXIS_0_tvalid,
    S_AXIS_1_tdata,
    S_AXIS_1_tready,
    S_AXIS_1_tvalid,
    S_AXIS_2_tdata,
    S_AXIS_2_tready,
    S_AXIS_2_tvalid,
    S_AXIS_3_tdata,
    S_AXIS_3_tready,
    S_AXIS_3_tvalid,
    Vp_Vn_0_v_n,
    Vp_Vn_0_v_p,
    adc0_clk_0_clk_n,
    adc0_clk_0_clk_p,
    adc2_clk_0_clk_n,
    adc2_clk_0_clk_p,
    clk_adc0_0,
    
    int_trig_i,
    dac0_clk_0_clk_n,
    dac0_clk_0_clk_p,
    m00_axis_0_tdata,
    m00_axis_0_tready,
    m00_axis_0_tvalid,
    m02_axis_0_tdata,
    m02_axis_0_tready,
    m02_axis_0_tvalid,
    m20_axis_0_tdata,
    m20_axis_0_tready,
    m20_axis_0_tvalid,
    m22_axis_0_tdata,
    m22_axis_0_tready,
    m22_axis_0_tvalid,
    pl_clk0,
    pl_resetn0,
    s_axi_aclk_0,
    s_axi_aresetn_0,
    s_axis_aclk_0,
    s_axis_aresetn_0,
    sysref_in_0_diff_n,
    sysref_in_0_diff_p,
    user_sysref_adc_0,
    vin0_01_0_v_n,
    vin0_01_0_v_p,
    vin0_23_0_v_n,
    vin0_23_0_v_p,
    vin2_01_0_v_n,
    vin2_01_0_v_p,
    vin2_23_0_v_n,
    vin2_23_0_v_p,
    vout00_0_v_n,
    vout00_0_v_p);
  input [127:0]S_AXIS_0_tdata;
  output S_AXIS_0_tready;
  input S_AXIS_0_tvalid;
  input [127:0]S_AXIS_1_tdata;
  output S_AXIS_1_tready;
  input S_AXIS_1_tvalid;
  input [127:0]S_AXIS_2_tdata;
  output S_AXIS_2_tready;
  input S_AXIS_2_tvalid;
  input [127:0]S_AXIS_3_tdata;
  output S_AXIS_3_tready;
  input S_AXIS_3_tvalid;
  input Vp_Vn_0_v_n;
  input Vp_Vn_0_v_p;
  input adc0_clk_0_clk_n;
  input adc0_clk_0_clk_p;
  input adc2_clk_0_clk_n;
  input adc2_clk_0_clk_p;
  output clk_adc0_0;
  input int_trig_i;
  input dac0_clk_0_clk_n;
  input dac0_clk_0_clk_p;
  output [127:0]m00_axis_0_tdata;
  input m00_axis_0_tready;
  output m00_axis_0_tvalid;
  output [127:0]m02_axis_0_tdata;
  input m02_axis_0_tready;
  output m02_axis_0_tvalid;
  output [127:0]m20_axis_0_tdata;
  input m20_axis_0_tready;
  output m20_axis_0_tvalid;
  output [127:0]m22_axis_0_tdata;
  input m22_axis_0_tready;
  output m22_axis_0_tvalid;
  output pl_clk0;
  output pl_resetn0;
  input s_axi_aclk_0;
  input s_axi_aresetn_0;
  input s_axis_aclk_0;
  input s_axis_aresetn_0;
  input sysref_in_0_diff_n;
  input sysref_in_0_diff_p;
  input user_sysref_adc_0;
  input vin0_01_0_v_n;
  input vin0_01_0_v_p;
  input vin0_23_0_v_n;
  input vin0_23_0_v_p;
  input vin2_01_0_v_n;
  input vin2_01_0_v_p;
  input vin2_23_0_v_n;
  input vin2_23_0_v_p;
  output vout00_0_v_n;
  output vout00_0_v_p;

  wire [127:0]S_AXIS_0_tdata;
  wire S_AXIS_0_tready;
  wire S_AXIS_0_tvalid;
  wire [127:0]S_AXIS_1_tdata;
  wire S_AXIS_1_tready;
  wire S_AXIS_1_tvalid;
  wire [127:0]S_AXIS_2_tdata;
  wire S_AXIS_2_tready;
  wire S_AXIS_2_tvalid;
  wire [127:0]S_AXIS_3_tdata;
  wire S_AXIS_3_tready;
  wire S_AXIS_3_tvalid;
  wire Vp_Vn_0_v_n;
  wire Vp_Vn_0_v_p;
  wire adc0_clk_0_clk_n;
  wire adc0_clk_0_clk_p;
  wire adc2_clk_0_clk_n;
  wire adc2_clk_0_clk_p;
  wire clk_adc0_0;
  wire dac0_clk_0_clk_n;
  wire dac0_clk_0_clk_p;
  wire [127:0]m00_axis_0_tdata;
  wire m00_axis_0_tready;
  wire m00_axis_0_tvalid;
  wire [127:0]m02_axis_0_tdata;
  wire m02_axis_0_tready;
  wire m02_axis_0_tvalid;
  wire [127:0]m20_axis_0_tdata;
  wire m20_axis_0_tready;
  wire m20_axis_0_tvalid;
  wire [127:0]m22_axis_0_tdata;
  wire m22_axis_0_tready;
  wire m22_axis_0_tvalid;
  wire pl_clk0;
  wire pl_resetn0;
  wire s_axi_aclk_0;
  wire s_axi_aresetn_0;
  wire s_axis_aclk_0;
  wire s_axis_aresetn_0;
  wire sysref_in_0_diff_n;
  wire sysref_in_0_diff_p;
  wire user_sysref_adc_0;
  wire vin0_01_0_v_n;
  wire vin0_01_0_v_p;
  wire vin0_23_0_v_n;
  wire vin0_23_0_v_p;
  wire vin2_01_0_v_n;
  wire vin2_01_0_v_p;
  wire vin2_23_0_v_n;
  wire vin2_23_0_v_p;
  wire vout00_0_v_n;
  wire vout00_0_v_p;

  mts_bd mts_bd_i
       (.S_AXIS_0_tdata(S_AXIS_0_tdata),
        .S_AXIS_0_tready(S_AXIS_0_tready),
        .S_AXIS_0_tvalid(S_AXIS_0_tvalid),
        .S_AXIS_1_tdata(S_AXIS_1_tdata),
        .S_AXIS_1_tready(S_AXIS_1_tready),
        .S_AXIS_1_tvalid(S_AXIS_1_tvalid),
        .S_AXIS_2_tdata(S_AXIS_2_tdata),
        .S_AXIS_2_tready(S_AXIS_2_tready),
        .S_AXIS_2_tvalid(S_AXIS_2_tvalid),
        .S_AXIS_3_tdata(S_AXIS_3_tdata),
        .S_AXIS_3_tready(S_AXIS_3_tready),
        .S_AXIS_3_tvalid(S_AXIS_3_tvalid),
        .Vp_Vn_0_v_n(Vp_Vn_0_v_n),
        .Vp_Vn_0_v_p(Vp_Vn_0_v_p),
        .adc0_clk_0_clk_n(adc0_clk_0_clk_n),
        .adc0_clk_0_clk_p(adc0_clk_0_clk_p),
        .adc2_clk_0_clk_n(adc2_clk_0_clk_n),
        .adc2_clk_0_clk_p(adc2_clk_0_clk_p),
        .clk_adc0_0(clk_adc0_0),
        .int_trig_i(int_trig_i),
        .dac0_clk_0_clk_n(dac0_clk_0_clk_n),
        .dac0_clk_0_clk_p(dac0_clk_0_clk_p),
        .m00_axis_0_tdata(m00_axis_0_tdata),
        .m00_axis_0_tready(m00_axis_0_tready),
        .m00_axis_0_tvalid(m00_axis_0_tvalid),
        .m02_axis_0_tdata(m02_axis_0_tdata),
        .m02_axis_0_tready(m02_axis_0_tready),
        .m02_axis_0_tvalid(m02_axis_0_tvalid),
        .m20_axis_0_tdata(m20_axis_0_tdata),
        .m20_axis_0_tready(m20_axis_0_tready),
        .m20_axis_0_tvalid(m20_axis_0_tvalid),
        .m22_axis_0_tdata(m22_axis_0_tdata),
        .m22_axis_0_tready(m22_axis_0_tready),
        .m22_axis_0_tvalid(m22_axis_0_tvalid),
        .pl_clk0(pl_clk0),
        .pl_resetn0(pl_resetn0),
        .s_axi_aclk_0(s_axi_aclk_0),
        .s_axi_aresetn_0(s_axi_aresetn_0),
        .s_axis_aclk_0(s_axis_aclk_0),
        .s_axis_aresetn_0(s_axis_aresetn_0),
        .sysref_in_0_diff_n(sysref_in_0_diff_n),
        .sysref_in_0_diff_p(sysref_in_0_diff_p),
        .user_sysref_adc_0(user_sysref_adc_0),
        .vin0_01_0_v_n(vin0_01_0_v_n),
        .vin0_01_0_v_p(vin0_01_0_v_p),
        .vin0_23_0_v_n(vin0_23_0_v_n),
        .vin0_23_0_v_p(vin0_23_0_v_p),
        .vin2_01_0_v_n(vin2_01_0_v_n),
        .vin2_01_0_v_p(vin2_01_0_v_p),
        .vin2_23_0_v_n(vin2_23_0_v_n),
        .vin2_23_0_v_p(vin2_23_0_v_p),
        .vout00_0_v_n(vout00_0_v_n),
        .vout00_0_v_p(vout00_0_v_p));
endmodule
